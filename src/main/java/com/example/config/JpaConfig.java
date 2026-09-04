package com.example.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.Map;

/** Creates one application-wide factory and one EntityManager per DAO operation. */
public final class JpaConfig {
        private static final EntityManagerFactory FACTORY = Persistence.createEntityManagerFactory(
            "baitap-jpa",
            Map.of("jakarta.persistence.jdbc.password", System.getenv().getOrDefault("DB_PASSWORD", "")));

    private JpaConfig() {
    }

    public static EntityManager getEntityManager() {
        return FACTORY.createEntityManager();
    }

    public static void close() {
        if (FACTORY.isOpen()) {
            FACTORY.close();
        }
    }
}
