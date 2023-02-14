package com.gura.acorn.es;

import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestHighLevelClient;
import org.springframework.context.annotation.Configuration;

import lombok.RequiredArgsConstructor;

@Configuration
@RequiredArgsConstructor
public class EsConfig extends AbstractElasticsearchConfiguration {

    private final EsProperties esProperties = new EsProperties();

    @Override
    public RestHighLevelClient elasticsearchClient() {
        // https://discuss.elastic.co/t/localhost-nodename-nor-servname-provided-or-not-known/186173/11
        return new RestHighLevelClient(RestClient.builder(esProperties.httpHost()));
    }
}
