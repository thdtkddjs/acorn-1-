package com.gura.acorn.es;


import java.util.Optional;

import org.apache.http.HttpHost;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Component
@Setter
@ConfigurationProperties(prefix = "elasticsearch")
public class EsProperties {

    private String host;        // ES 호스트
    private int port;           // ES 포트
    private Indices indecies;   // ES 인덱스 정보

    public HttpHost httpHost() {
        return new HttpHost(host, port, "http");
    }

    public String getStudentIndexName() {
        return Optional.ofNullable(indecies).map(t -> getStudentIndexName()).orElse(null);
    }

    public String getTestIndexName() {
        return Optional.ofNullable(indecies).map(t -> getTestIndexName()).orElse(null);
    }

    @Getter
    @Setter
    public static class Indices {
        String studentsIndexName;
        String testIndexName;
    }

}
