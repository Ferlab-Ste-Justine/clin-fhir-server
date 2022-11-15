package bio.ferlab.clin.es;

import bio.ferlab.clin.es.indexer.NanuqIndexer;
import bio.ferlab.clin.properties.BioProperties;
import bio.ferlab.clin.utils.MD5Utils;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.Map;
import java.util.TreeMap;

@Component
@RequiredArgsConstructor
public class TemplateIndexer {

  private static final Logger log = LoggerFactory.getLogger(TemplateIndexer.class);
  public static final String ANALYSES_TEMPLATE = "clin-analyses-template.json";
  public static final String SEQUENCINGS_TEMPLATE = "clin-sequencings-template.json";

  private final ElasticsearchRestClient esClient;

  public Map<String, String> indexTemplates() {
    final Map<String, String> templates = new TreeMap<>();
    templates.put(ANALYSES_TEMPLATE, indexTemplate(ANALYSES_TEMPLATE));
    templates.put(SEQUENCINGS_TEMPLATE, indexTemplate(SEQUENCINGS_TEMPLATE));
    return templates;
  }

  private String indexTemplate(String path) {
    log.info("Index ES template from resource: {}", path);
    final String templateName = FilenameUtils.getBaseName(path);
    final String templateContent = loadTemplate(path);
    esClient.indexTemplate(templateName, templateContent);
    return MD5Utils.fromTemplate(templateContent);
  }

  private String loadTemplate(String path) {
    try(InputStream is = getClass().getClassLoader().getResourceAsStream(path)) {
      return IOUtils.toString(is, StandardCharsets.UTF_8.name());
    } catch (Exception e) {
      throw new RuntimeException("Failed to load template from resources: " + path, e);
    }
  }
  
}
