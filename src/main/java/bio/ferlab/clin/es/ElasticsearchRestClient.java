package bio.ferlab.clin.es;

import bio.ferlab.clin.es.data.Actions;
import bio.ferlab.clin.es.data.ElasticsearchData;
import bio.ferlab.clin.utils.JsonGenerator;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.util.EntityUtils;
import org.elasticsearch.client.Request;
import org.elasticsearch.client.Response;
import org.elasticsearch.client.ResponseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpMethod;

import java.io.IOException;
import java.util.*;

@RequiredArgsConstructor
public class ElasticsearchRestClient {
    private static final Logger log = LoggerFactory.getLogger(ElasticsearchRestClient.class);
    public static final String FAILED_TO_CREATE_INDEX = "Failed to create index";
    public static final String FAILED_TO_GET_ALIASES = "Failed to get aliases";
    public static final String FAILED_TO_DELETE_INDEX = "Failed to delete index";
    public static final String FAILED_TO_SET_ALIAS = "Failed to set alias";
    public static final String FAILED_TO_SAVE_RESOURCE = "Failed to save resource";
    public static final String FAILED_TO_INDEX_TEMPLATE = "Failed to index template";
    public static final String FAILED_TO_DELETE_RESOURCE = "Failed to delete resource";
    private final ElasticsearchData data;
    private final JsonGenerator jsonGenerator;

    public void createIndex(String index) {
        log.info("Create index: {}", index);
        try {
            final Request request = new Request(
              HttpMethod.PUT.name(), String.format("/%s", index)
            );
            this.data.client.performRequest(request);
        } catch (IOException e) {
            if (e instanceof  ResponseException && e.getMessage().contains("resource_already_exists_exception")) {
                log.warn("Index already exists: {}", index);
            } else {
                log.error(e.getLocalizedMessage());
                throw new ca.uhn.fhir.rest.server.exceptions.InternalErrorException(FAILED_TO_CREATE_INDEX);
            }
        }
    }

    public Map<String, String> aliases() {
        log.info("Get aliases");
        Map<String, String> aliases = new TreeMap<>();
        try {
            final Request request = new Request(
              HttpMethod.GET.name(), "_cat/aliases"
            );
            final Response response = this.data.client.performRequest(request);
            final String body = EntityUtils.toString(response.getEntity());
            Arrays.stream(body.split("\n")).map(line -> line.split("\\s+")).filter(a -> a.length >= 2).forEach(e -> aliases.put(e[0], e[1]));
        } catch (IOException e) {
            log.error(e.getLocalizedMessage());
            throw new ca.uhn.fhir.rest.server.exceptions.InternalErrorException(FAILED_TO_GET_ALIASES);
        }
        return aliases;
    }

    public void setAlias(List<String> add, List<String> remove, String alias) {
        log.info("Set alias: {} add: {} remove: {}", alias, add, remove);
        try {

            final Actions actions = new Actions();
            remove.forEach(r-> actions.getActions().add(new Actions.ActionRemove(r, alias)));
            add.forEach(r-> actions.getActions().add(new Actions.ActionAdd(r, alias)));

            final Request request = new Request(
              HttpMethod.POST.name(), "/_aliases"
            );
            request.setJsonEntity(jsonGenerator.toString(actions));
            this.data.client.performRequest(request);
        } catch (IOException e) {
            log.error(e.getLocalizedMessage());
            throw new ca.uhn.fhir.rest.server.exceptions.InternalErrorException(FAILED_TO_SET_ALIAS);
        }
    }

     public void index(String index, IndexData data) {
        final String id = data.id;
        log.info(String.format("Indexing resource id[%s]", id));
        try {
            final Request request = new Request(
                    HttpMethod.PUT.name(),
                    String.format("/%s/_doc/%s", index, id)
            );
            request.setJsonEntity(data.jsonContent);
            this.data.client.performRequest(request);
        } catch (IOException e) {
            log.error(e.getLocalizedMessage());
            throw new ca.uhn.fhir.rest.server.exceptions.InternalErrorException(FAILED_TO_SAVE_RESOURCE);
        }
    }

    public void indexTemplate(String templateName, String templateContent) {
        log.info("Indexing template: {}", templateName);
        try {
            final Request request = new Request(
                HttpMethod.PUT.name(),
                String.format("/_index_template/%s",templateName)
            );
            request.setJsonEntity(templateContent);
            this.data.client.performRequest(request);
        } catch (IOException e) {
            log.error(e.getLocalizedMessage());
            throw new ca.uhn.fhir.rest.server.exceptions.InternalErrorException(FAILED_TO_INDEX_TEMPLATE);
        }
    }

    public void delete(List<String> indexes) {
        final String joined = StringUtils.join(indexes, ",");
        log.info(String.format("Deleting index [%s]", joined));
        try {
            final Request request = new Request(
              HttpMethod.DELETE.name(),
              String.format("/%s?ignore_unavailable=true", joined)
            );
            this.data.client.performRequest(request);
        } catch (IOException e) {
            log.error(e.getLocalizedMessage());
            throw new ca.uhn.fhir.rest.server.exceptions.InternalErrorException(FAILED_TO_DELETE_INDEX);
        }
    }

    public void delete(String index, String id) {
        log.info(String.format("Deleting resource id[%s]", id));
        try {
            final Request request = new Request(
                    HttpMethod.DELETE.name(),
                    String.format("/%s/_doc/%s", index, id)
            );
            this.data.client.performRequest(request);
        } catch (ResponseException e) {
            log.error(e.getLocalizedMessage());
            if (e.getResponse().getStatusLine().getStatusCode() != 404) {
                throw new ca.uhn.fhir.rest.server.exceptions.InternalErrorException(FAILED_TO_DELETE_RESOURCE);
            }
        } catch (IOException e) {
            log.error(e.getLocalizedMessage());
            throw new ca.uhn.fhir.rest.server.exceptions.InternalErrorException(FAILED_TO_DELETE_RESOURCE);
        }
    }

    public static class IndexData {
        public final String id;
        public final String jsonContent;

        public IndexData(String id, String jsonContent) {
            this.id = id;
            this.jsonContent = jsonContent;
        }
    }

}
