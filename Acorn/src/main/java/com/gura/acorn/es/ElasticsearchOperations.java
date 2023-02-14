package com.gura.acorn.es;

import org.springframework.data.elasticsearch.core.DocumentOperations;
import org.springframework.data.elasticsearch.core.SearchOperations;

public interface ElasticsearchOperations extends DocumentOperations, SearchOperations {
    //...
}
