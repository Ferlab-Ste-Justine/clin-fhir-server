package bio.ferlab.clin.es;

import bio.ferlab.clin.es.config.ResourceDaoConfiguration;
import bio.ferlab.clin.es.indexer.NanuqIndexer;
import bio.ferlab.clin.properties.BioProperties;
import bio.ferlab.clin.utils.MD5Utils;
import ca.uhn.fhir.jpa.searchparam.SearchParameterMap;
import ca.uhn.fhir.rest.api.server.IBundleProvider;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import java.util.*;
import java.util.stream.Collectors;

import static bio.ferlab.clin.es.TemplateIndexer.ANALYSES_TEMPLATE;
import static bio.ferlab.clin.es.TemplateIndexer.SEQUENCINGS_TEMPLATE;

@Component
@RequiredArgsConstructor
public class MigrationManager {

  private static final Logger log = LoggerFactory.getLogger(MigrationManager.class);

  private final TemplateIndexer templateIndexer;
  private final BioProperties bioProperties;
  private final ElasticsearchRestClient esClient;
  private final NanuqIndexer nanuqIndexer;
  private final ResourceDaoConfiguration configuration;

  @EventListener(ApplicationReadyEvent.class)
  public void startMigration() {
    // always index templates
    Map<String, String> templates = this.templateIndexer.indexTemplates();

    // indexes that will be used at the end of the process
    final String analysesIndex = bioProperties.getNanuqEsAnalysesIndex();
    final String sequencingsIndex = bioProperties.getNanuqEsSequencingsIndex();

    // current ES mappings MD5 hashes
    final String currentESAnalysesMappingHash = Optional.ofNullable(this.esClient.mapping(analysesIndex, true))
      .map(m -> MD5Utils.fromESIndexMapping(analysesIndex, m, true)).orElse(null);
    final String currentESsequencingsMappingHash = Optional.ofNullable(this.esClient.mapping(sequencingsIndex, true))
      .map(m -> MD5Utils.fromESIndexMapping(sequencingsIndex, m, true)).orElse(null);

    // temporary indexes with templates hash
    final String analysesIndexWithHash = formatIndexWithHash(analysesIndex, templates.get(ANALYSES_TEMPLATE));
    final String sequencingIndexWithHash = formatIndexWithHash(sequencingsIndex, templates.get(SEQUENCINGS_TEMPLATE));

    // compare template with current ES hashes
    final boolean analysesHasChanged = !templates.get(ANALYSES_TEMPLATE).equals(currentESAnalysesMappingHash);
    final boolean sequencingsHasChanged = !templates.get(SEQUENCINGS_TEMPLATE).equals(currentESsequencingsMappingHash);

    // Perform migration if any of them is different
    if (analysesHasChanged || sequencingsHasChanged) {
      log.info("Migrate: {} {}", analysesIndexWithHash, sequencingIndexWithHash);

      // insure the temporary indexes don't exist already
      this.cleanup(List.of(analysesIndexWithHash, sequencingIndexWithHash));
      // index the data into the temporary indexes with hashes
      this.migrate(analysesIndexWithHash, sequencingIndexWithHash);

      // rolling the index with hashes into official indexes
      this.rolling(analysesIndexWithHash, analysesIndex);
      this.rolling(sequencingIndexWithHash, sequencingsIndex);
      // remove temporary indexes with hashes
      this.cleanup(List.of(analysesIndexWithHash, sequencingIndexWithHash));
    } else {
      log.info("Nothing to migrate");
    }
  }

  private void migrate(String analysesIndex, String sequencingIndex) {
    int batchSize = 100, offset = 0;
    boolean running = true;
    int total = 0;
    do {
      final SearchParameterMap searchParameterMap = SearchParameterMap.newSynchronous();
      searchParameterMap.setCount(batchSize);
      searchParameterMap.setOffset(offset);
      // good old batch with pagination
      final IBundleProvider bundle = this.configuration.serviceRequestDAO.search(searchParameterMap);
      final Set<String> prescriptionIds = bundle.getResources(0, batchSize).stream().map(r -> r.getIdElement().getIdPart()).collect(Collectors.toSet());
      if (!prescriptionIds.isEmpty()) {
        this.nanuqIndexer.doIndex(null, prescriptionIds, analysesIndex, sequencingIndex, false);
        offset += batchSize;
        total += prescriptionIds.size();
      } else {
        running = false;
      }
    } while(running);
    log.info("Total migrated: {}", total);
  }

  private void cleanup(List<String> indexesToCleanup) {
    final List<String> nonNullIndexes = indexesToCleanup.stream().filter(Objects::nonNull).collect(Collectors.toList());
    if (!nonNullIndexes.isEmpty()) {
      log.info("Cleanup ES indexes ...");
      this.esClient.delete(nonNullIndexes);
    }
  }

  private void rolling(String indexWithHash, String index) {
    log.info("Rolling: {} => {}", indexWithHash, index);
    this.cleanup(List.of(index));
    final String alias = this.esClient.aliases().get(index);
    if (alias != null)
      this.esClient.setAlias(List.of(), List.of(alias), index);
    this.esClient.bocksIndexWrite(indexWithHash);
    this.esClient.clone(indexWithHash, index);
  }

  private String formatIndexWithHash(String index, String templateHash) {
    return String.format("%s-%s", index, templateHash);
  }

}
