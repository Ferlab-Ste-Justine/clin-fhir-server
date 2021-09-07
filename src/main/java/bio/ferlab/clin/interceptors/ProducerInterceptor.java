package bio.ferlab.clin.interceptors;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.interceptor.api.Hook;
import ca.uhn.fhir.interceptor.api.Interceptor;
import ca.uhn.fhir.interceptor.api.Pointcut;
import ca.uhn.fhir.parser.IParser;
import org.apache.avro.Schema;
import org.hl7.fhir.instance.model.api.IBaseResource;
import org.springframework.data.redis.connection.stream.MapRecord;
import org.springframework.data.redis.connection.stream.RecordId;
import org.springframework.data.redis.connection.stream.StreamRecords;
import org.springframework.data.redis.connection.stream.StringRecord;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import tech.allegro.schema.json2avro.converter.JsonAvroConverter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Objects;

import static java.util.Objects.requireNonNull;

/**
 * Intercepts requests CREATE/UPDATE/DELETE requests, and index patient data to ES when needed.
 * Subscription couldn't be used in this scenario, as they do not offer a way to handle deletions and to filter out
 * unnecessary attributes.
 */
@Interceptor
@Service
public class ProducerInterceptor {
    private final RedisTemplate<String, String> redisTemplate;
    private final IParser jsonParser;
    private JsonAvroConverter converter = new JsonAvroConverter();

    private final Schema schema;

    public ProducerInterceptor(RedisTemplate<String, String> redisTemplate) {
        this.redisTemplate = redisTemplate;
        this.jsonParser = FhirContext.forR4().newJsonParser();
        try {
            schema = new Schema.Parser().parse(requireNonNull(getClass().getResource("/patient-schema.avsc")).openStream());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

    }

    @Hook(Pointcut.STORAGE_PRECOMMIT_RESOURCE_DELETED)
    public void resourceDeleted(IBaseResource resource) {
        send(resource, "delete");

    }

    private void send(IBaseResource resource, String action) {
        Map<String, Object> resourceMap = new HashMap<>();
        resourceMap.put("action", action);
        resourceMap.put("resource_type", resource.fhirType());
        resourceMap.put("version_id", resource.getMeta().getVersionId());
        resourceMap.put("resource_id", resource.getIdElement().getIdPart());
        String jsonResource = jsonParser.encodeResourceToString(resource);
        byte[] resourceAvro = converter.convertToAvro(jsonResource.getBytes(), schema);
        resourceMap.put("resource", resourceAvro);

        MapRecord<String, String, Object> record = StreamRecords.mapBacked(resourceMap).withStreamKey("fhir:" + resource.fhirType().toLowerCase(Locale.ROOT));
        RecordId recordId = redisTemplate.opsForStream().add(record);
        System.out.println("Record Id = " + recordId.getValue());
    }

    @Hook(Pointcut.STORAGE_PRECOMMIT_RESOURCE_CREATED)
    public void resourceCreated(IBaseResource resource) {
        send(resource, "create");

    }

    @Hook(Pointcut.STORAGE_PRECOMMIT_RESOURCE_UPDATED)
    public void resourceUpdated(IBaseResource previous, IBaseResource resource) {
        send(resource, "update");
    }

}
