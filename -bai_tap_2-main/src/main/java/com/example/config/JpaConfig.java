package com.example.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

/** Creates one application-wide factory and one EntityManager per DAO operation. */
public final class JpaConfig {
    private static final EntityManagerFactory FACTORY = Persistence.createEntityManagerFactory("baitap-jpa");

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
