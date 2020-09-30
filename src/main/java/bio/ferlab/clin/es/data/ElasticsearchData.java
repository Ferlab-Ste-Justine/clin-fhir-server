package bio.ferlab.clin.es.data;

import org.elasticsearch.client.RestClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

public class ElasticsearchData {
    private static final Logger logger = LoggerFactory.getLogger(ElasticsearchData.class);
    public final RestClient client;
    public final String host;
    public final String authToken;

    public ElasticsearchData(RestClient client, String host, String authToken) {
        this.client = client;
        this.host = host;
        this.authToken = authToken;
    }

    public void close() {
        try {
            this.client.close();
        } catch (IOException e) {
            logger.error(e.getLocalizedMessage());
            e.printStackTrace();
        }
    }
}
