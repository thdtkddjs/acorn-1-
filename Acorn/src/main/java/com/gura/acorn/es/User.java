package com.gura.acorn.es;

import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;

import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.PersistenceConstructor;
import org.springframework.data.elasticsearch.annotations.Document;

@Document(indexName = "users")
@Entity
public class User {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Embedded
    private BasicProfile basicProfile;

    protected User() {
    }

    public User(String name) {
        this(name, null);
    }

    public User(String name, String description) {
        this(null, new BasicProfile(name, description));
    }

    @PersistenceConstructor
    public User(Long id, BasicProfile basicProfile) {
        this.id = id;
        this.basicProfile = basicProfile;
    }

    // getter 생략
}