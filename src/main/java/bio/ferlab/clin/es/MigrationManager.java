package bio.ferlab.clin.es;

import bio.ferlab.clin.es.config.ResourceDaoConfiguration;
import bio.ferlab.clin.es.indexer.NanuqIndexer;
import bio.ferlab.clin.properties.BioProperties;
import ca.uhn.fhir.jpa.searchparam.SearchParameterMap;
import ca.uhn.fhir.rest.api.server.IBundleProvider;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
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

  public enum Type {
    always, hash, none
  }

  private final TemplateIndexer templateIndexer;
  private final BioProperties bioProperties;
  private final ElasticsearchRestClient esClient;
  private final NanuqIndexer nanuqIndexer;
  private final ResourceDaoConfiguration configuration;

  @EventListener(ApplicationReadyEvent.class)
  public void startMigration() {

    // always index templates
    Map<String, String> templates = this.templateIndexer.indexTemplates();
    Map<String, String> aliases = esClient.aliases();

    // indexes that will be used as aliases at the end of the process
    final String analysesIndex = bioProperties.getNanuqEsAnalysesIndex();
    final String sequencingsIndex = bioProperties.getNanuqEsSequencingsIndex();

    // indexes with templates hash known by elastic-search
    final String currentESAnalysesIndexWithHash = aliases.get(analysesIndex);
    final String currentESSequencingIndexWithHash = aliases.get(sequencingsIndex);

    if (Type.hash.equals(bioProperties.getNanuqReindex())) {

      // indexes with templates hash from this release of FHIR
      final String analysesIndexWithHash = formatIndexWithHash(analysesIndex, templates.get(ANALYSES_TEMPLATE));
      final String sequencingIndexWithHash = formatIndexWithHash(sequencingsIndex, templates.get(SEQUENCINGS_TEMPLATE));

      // compare current template hash with ES
      final boolean analysesHasChanged = !analysesIndexWithHash.equals(currentESAnalysesIndexWithHash);
      final boolean sequencingsHasChanged = !sequencingIndexWithHash.equals(currentESSequencingIndexWithHash);

      // Perform migration if any of them is different
      if (analysesHasChanged || sequencingsHasChanged) {
        log.info("Migrate: {} {}", analysesIndexWithHash, sequencingIndexWithHash);
        this.migrate(analysesIndexWithHash, sequencingIndexWithHash);

        // always remove indexes that could have the names of the aliases to publish
        this.cleanup(List.of(analysesIndex, sequencingsIndex));

        // remove + add the aliases referring the new indexes + hash
        List<String> indexesToCleanup = new ArrayList<>();
        if (analysesHasChanged) {
          this.publish(analysesIndexWithHash, currentESAnalysesIndexWithHash, analysesIndex);
          indexesToCleanup.add(currentESAnalysesIndexWithHash);
        }

        if (sequencingsHasChanged) {
          this.publish(sequencingIndexWithHash, currentESSequencingIndexWithHash, sequencingsIndex);
          indexesToCleanup.add(currentESSequencingIndexWithHash);
        }

        // cleanup previous indexes
        this.cleanup(indexesToCleanup);
      } else {
        log.info("Nothing to migrate");
      }
    } else if (Type.always.equals(bioProperties.getNanuqReindex())){
      log.info("Re-index: {} {}", analysesIndex, sequencingsIndex);
      // remove all previous aliases and indexes
      List<String> indexesToCleanup = new ArrayList<>(List.of(analysesIndex, sequencingsIndex));
      if (currentESAnalysesIndexWithHash != null) {
        this.esClient.setAlias(List.of(), List.of("*"), analysesIndex);
        indexesToCleanup.add(currentESAnalysesIndexWithHash);
      }
      if (currentESSequencingIndexWithHash != null) {
        this.esClient.setAlias(List.of(), List.of("*"), sequencingsIndex);
        indexesToCleanup.add(currentESSequencingIndexWithHash);
      }
      this.cleanup(indexesToCleanup);
      this.migrate(analysesIndex, sequencingsIndex);
    } else {
      log.info("Re-index is disabled");
    }
  }

  private void createEmptyIndexes(List<String> indexes) {
    indexes.stream()
      .filter(Objects::nonNull)
      .filter(StringUtils::isNotBlank)
      .forEach(this.esClient::createIndex);
  }

  private void migrate(String analysesIndex, String sequencingIndex) {
    // always create empty indexes in case nothing to index
    this.createEmptyIndexes(List.of(analysesIndex, sequencingIndex));
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
    log.info("Total indexed: {}", total);
  }

  private void cleanup(List<String> indexesToCleanup) {
    final List<String> nonNullIndexes = indexesToCleanup.stream().filter(Objects::nonNull).collect(Collectors.toList());
    if (!nonNullIndexes.isEmpty()) {
      log.info("Cleanup ES indexes ...");
      this.esClient.delete(nonNullIndexes);
    }
  }

  private void publish(String indexWithHash, String currentESIndexWithHash, String index) {
    log.info("Publish: {} <=> {}", index, indexWithHash);
    List<String> aliasesToRemove = currentESIndexWithHash != null ? List.of("*") : List.of();
    this.esClient.setAlias(List.of(indexWithHash), aliasesToRemove, index);
  }

  private String formatIndexWithHash(String index, String templateHash) {
    return String.format("%s-%s", index, templateHash);
  }

}
