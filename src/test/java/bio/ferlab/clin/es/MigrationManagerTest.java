package bio.ferlab.clin.es;

import bio.ferlab.clin.es.config.ResourceDaoConfiguration;
import bio.ferlab.clin.es.indexer.NanuqIndexer;
import bio.ferlab.clin.properties.BioProperties;
import ca.uhn.fhir.jpa.api.dao.IFhirResourceDao;
import ca.uhn.fhir.rest.api.server.IBundleProvider;
import ca.uhn.fhir.rest.server.SimpleBundleProvider;
import ca.uhn.fhir.rest.server.exceptions.InvalidRequestException;
import org.hl7.fhir.r4.model.ServiceRequest;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.util.List;
import java.util.Map;
import java.util.Set;

import static bio.ferlab.clin.es.TemplateIndexer.ANALYSES_TEMPLATE;
import static bio.ferlab.clin.es.TemplateIndexer.SEQUENCINGS_TEMPLATE;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

class MigrationManagerTest {

  private final TemplateIndexer templateIndexer = Mockito.mock(TemplateIndexer.class);
  private final BioProperties bioProperties = Mockito.mock(BioProperties.class);
  private final ElasticsearchRestClient esClient = Mockito.mock(ElasticsearchRestClient.class);
  private final NanuqIndexer nanuqIndexer = Mockito.mock(NanuqIndexer.class);
  final IFhirResourceDao<ServiceRequest> serviceRequestDao = Mockito.mock(IFhirResourceDao.class);
  final ResourceDaoConfiguration daoConfiguration = new ResourceDaoConfiguration(null, null, serviceRequestDao, null, null
    , null, null, null, null, null, null);

  private final MigrationManager migrationManager = new MigrationManager(templateIndexer, bioProperties, esClient, nanuqIndexer, daoConfiguration);

  @BeforeEach
  void beforeEach() {
    when(bioProperties.getNanuqReindex()).thenReturn(MigrationManager.Type.hash);
    when(bioProperties.getNanuqEsAnalysesIndex()).thenReturn("analyses");
    when(bioProperties.getNanuqEsSequencingsIndex()).thenReturn("sequencings");
  }

  @Test
  void reindex() {
    when(bioProperties.getNanuqReindex()).thenReturn(MigrationManager.Type.always);

    when(templateIndexer.indexTemplates()).thenReturn(Map.of(ANALYSES_TEMPLATE, "HASH2", SEQUENCINGS_TEMPLATE, "HASH1"));
    when(esClient.aliases()).thenReturn(Map.of("analyses", "analyses-HASH2"));

    ServiceRequest sr1 = new ServiceRequest();
    sr1.setId("sr1");
    ServiceRequest sr2 = new ServiceRequest();
    sr2.setId("sr2");
    final SimpleBundleProvider bundleProvider1 = new SimpleBundleProvider(List.of(sr1, sr2));
    final SimpleBundleProvider bundleProvider2 = new SimpleBundleProvider();
    when(serviceRequestDao.search(any())).thenReturn(bundleProvider1).thenReturn(bundleProvider2);

    migrationManager.startMigration();

    verify(esClient).delete(eq(List.of("analyses", "sequencings", "analyses-HASH2")));
    verify(esClient).createIndex(eq("analyses"));
    verify(esClient).createIndex(eq("sequencings"));
    verify(esClient, never()).setAlias(eq(List.of()), eq(List.of("*")), eq("sequencings"));
    verify(esClient).setAlias(eq(List.of()), eq(List.of("*")), eq("analyses"));
    verify(nanuqIndexer).doIndex(eq(null), eq(Set.of("sr1", "sr2")), eq("analyses"), eq("sequencings"), eq(false));
  }

  @Test
  void no_migration() {

    when(templateIndexer.indexTemplates()).thenReturn(Map.of(ANALYSES_TEMPLATE, "HASH1", SEQUENCINGS_TEMPLATE, "HASH1"));
    when(esClient.aliases()).thenReturn(Map.of("analyses", "analyses-HASH1", "sequencings", "sequencings-HASH1"));

    migrationManager.startMigration();

    verify(nanuqIndexer, never()).doIndex(eq(null), any(), any(), any(), eq(false));
  }

  @Test
  void do_first_time_migration() {

    when(templateIndexer.indexTemplates()).thenReturn(Map.of(ANALYSES_TEMPLATE, "HASH2", SEQUENCINGS_TEMPLATE, "HASH1"));
    when(esClient.aliases()).thenReturn(Map.of("analyses", "analyses-HASH1"));

    ServiceRequest sr1 = new ServiceRequest();
    sr1.setId("sr1");
    ServiceRequest sr2 = new ServiceRequest();
    sr2.setId("sr2");
    final SimpleBundleProvider bundleProvider1 = new SimpleBundleProvider(List.of(sr1, sr2));
    final SimpleBundleProvider bundleProvider2 = new SimpleBundleProvider();
    when(serviceRequestDao.search(any())).thenReturn(bundleProvider1).thenReturn(bundleProvider2);

    migrationManager.startMigration();

    verify(nanuqIndexer).doIndex(eq(null), eq(Set.of("sr1", "sr2")), eq("analyses-HASH2"), eq("sequencings-HASH1"), eq(false));
    verify(esClient).createIndex(eq("analyses-HASH2"));
    verify(esClient).createIndex(eq("sequencings-HASH1"));
    verify(esClient).setAlias(eq(List.of("analyses-HASH2")), eq(List.of("*")), eq("analyses"));
    verify(esClient).setAlias(eq(List.of("sequencings-HASH1")), eq(List.of()), eq("sequencings"));
    verify(esClient).delete(eq(List.of("analyses", "sequencings")));
    verify(esClient).delete(eq(List.of("analyses-HASH1")));
  }

  @Test
  void do_one_index__migration() {

    when(templateIndexer.indexTemplates()).thenReturn(Map.of(ANALYSES_TEMPLATE, "HASH2", SEQUENCINGS_TEMPLATE, "HASH1"));
    when(esClient.aliases()).thenReturn(Map.of("analyses", "analyses-HASH1", "sequencings", "sequencings-HASH1"));

    ServiceRequest sr1 = new ServiceRequest();
    sr1.setId("sr1");
    ServiceRequest sr2 = new ServiceRequest();
    sr2.setId("sr2");
    final SimpleBundleProvider bundleProvider1 = new SimpleBundleProvider(List.of(sr1, sr2));
    final SimpleBundleProvider bundleProvider2 = new SimpleBundleProvider();
    when(serviceRequestDao.search(any())).thenReturn(bundleProvider1).thenReturn(bundleProvider2);

    migrationManager.startMigration();

    verify(nanuqIndexer).doIndex(eq(null), eq(Set.of("sr1", "sr2")), eq("analyses-HASH2"), eq("sequencings-HASH1"), eq(false));
    verify(esClient).createIndex(eq("analyses-HASH2"));
    verify(esClient).createIndex(eq("sequencings-HASH1"));
    verify(esClient).setAlias(eq(List.of("analyses-HASH2")), eq(List.of("*")), eq("analyses"));
    verify(esClient, never()).setAlias(any(), any(), eq("sequencings"));
    verify(esClient).delete(eq(List.of("analyses", "sequencings")));
    verify(esClient).delete(eq(List.of("analyses-HASH1")));
  }

  @Test
  void do_both_indexes_migration() {

    when(templateIndexer.indexTemplates()).thenReturn(Map.of(ANALYSES_TEMPLATE, "HASH2", SEQUENCINGS_TEMPLATE, "HASH2"));
    when(esClient.aliases()).thenReturn(Map.of("analyses", "analyses-HASH1", "sequencings", "sequencings-HASH1"));

    ServiceRequest sr1 = new ServiceRequest();
    sr1.setId("sr1");
    ServiceRequest sr2 = new ServiceRequest();
    sr2.setId("sr2");
    final SimpleBundleProvider bundleProvider1 = new SimpleBundleProvider(List.of(sr1, sr2));
    final SimpleBundleProvider bundleProvider2 = new SimpleBundleProvider();
    when(serviceRequestDao.search(any())).thenReturn(bundleProvider1).thenReturn(bundleProvider2);

    migrationManager.startMigration();

    verify(nanuqIndexer).doIndex(eq(null), eq(Set.of("sr1", "sr2")), eq("analyses-HASH2"), eq("sequencings-HASH2"), eq(false));
    verify(esClient).createIndex(eq("analyses-HASH2"));
    verify(esClient).createIndex(eq("sequencings-HASH2"));
    verify(esClient).setAlias(eq(List.of("analyses-HASH2")), eq(List.of("*")), eq("analyses"));
    verify(esClient).setAlias(eq(List.of("sequencings-HASH2")), eq(List.of("*")), eq("sequencings"));
    verify(esClient).delete(eq(List.of("analyses", "sequencings")));
    verify(esClient).delete(eq(List.of("analyses-HASH1", "sequencings-HASH1")));
  }
}