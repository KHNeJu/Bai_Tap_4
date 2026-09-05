package com.example.dao.impl;

import com.example.config.JpaConfig;
import com.example.dao.IProductDao;
import com.example.model.Product;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.util.List;

public class ProductDao implements IProductDao {
    @Override
    public void insert(Product product) {
        executeInTransaction(entityManager -> entityManager.persist(product));
    }

    @Override
    public void update(Product product) {
        executeInTransaction(entityManager -> entityManager.merge(product));
    }

    @Override
    public void delete(int id) {
        executeInTransaction(entityManager -> {
            Product product = entityManager.find(Product.class, id);
            if (product != null) {
                entityManager.remove(product);
            }
        });
    }

    @Override
    public Product findById(int id) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        try {
            return entityManager.find(Product.class, id);
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Product> findLatest(int limit) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        try {
            return entityManager.createNamedQuery("Product.findLatest", Product.class)
                    .setMaxResults(limit)
                    .getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Product> findPage(int page, int pageSize) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        try {
            return entityManager.createNamedQuery("Product.findPage", Product.class)
                    .setFirstResult(page * pageSize)
                    .setMaxResults(pageSize)
                    .getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public int count() {
        EntityManager entityManager = JpaConfig.getEntityManager();
        try {
            return entityManager.createQuery("SELECT COUNT(p) FROM Product p", Long.class)
                    .getSingleResult().intValue();
        } finally {
            entityManager.close();
        }
    }

    private void executeInTransaction(EntityManagerOperation operation) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            operation.execute(entityManager);
            transaction.commit();
        } catch (RuntimeException exception) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw exception;
        } finally {
            entityManager.close();
        }
    }

    @FunctionalInterface
    private interface EntityManagerOperation {
        void execute(EntityManager entityManager);
    }
}
