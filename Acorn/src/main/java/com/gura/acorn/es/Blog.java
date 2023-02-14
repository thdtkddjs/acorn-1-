package com.gura.acorn.es;

import java.util.Date;

import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;

import lombok.Setter;

@Setter
@Document(indexName = "blog")
public class Blog {
	@Field(type = FieldType.Date)
	private Date log_date;

	@Field(type = FieldType.Text)
	private String log_text;

	@Field(type = FieldType.Long)
	private Long price;

    @Id
    private String id;
    private String title;
    private String content;

}