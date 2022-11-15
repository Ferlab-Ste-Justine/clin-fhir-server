package bio.ferlab.clin.utils;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.codec.digest.DigestUtils;

public class MD5Utils {

  private MD5Utils() {}

  public static String fromTemplate(String templateContent) {
    try {
      final JsonNode properties = new ObjectMapper().readTree(templateContent).get("template").get("mappings").get("properties");
      return DigestUtils.md5Hex(properties.toString());
    } catch (Exception e) {
      throw new RuntimeException("Failed to compute template MD5: " + e.getMessage(), e);
    }
  }

  public static String fromESIndexMapping(String rootName, String indexMapping, boolean ignoreIfMissing) {
    try {
      final JsonNode properties = new ObjectMapper().readTree(indexMapping).get(rootName).get("mappings").get("properties");
      return DigestUtils.md5Hex(properties.toString());
    } catch (Exception e) {
      if (ignoreIfMissing) {
        return null;
      } else {
        throw new RuntimeException("Failed to compute index mapping MD5: " + e.getMessage(), e);
      }
    }
  }
}
