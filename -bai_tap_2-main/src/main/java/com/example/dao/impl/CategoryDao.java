package com.example.dao.impl;

import com.example.config.JpaConfig;
import com.example.dao.ICategoryDao;
import com.example.model.Category;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.util.List;

/** JPA DAO for Category. Every write is executed in one local transaction. */
public class CategoryDao implements ICategoryDao {
    @Override
    public void insert(Category category) {
        executeInTransaction(entityManager -> entityManager.persist(category));
    }

    @Override
    public void update(Category category) {
        executeInTransaction(entityManager -> entityManager.merge(category));
    }

    @Override
    public void delete(int categoryId) {
        executeInTransaction(entityManager -> {
            Category category = entityManager.find(Category.class, categoryId);
            if (category == null) {
                throw new IllegalArgumentException("Không tìm thấy danh mục có id=" + categoryId);
            }
            entityManager.remove(category);
        });
    }

    @Override
    public Category findById(int categoryId) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        try {
            return entityManager.find(Category.class, categoryId);
        } finally {
            entityManager.close();
        }
    }

    @Override
    public Category findByCategoryname(String name) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        try {
            return entityManager.createQuery(
                            "SELECT c FROM Category c WHERE c.categoryName = :categoryName", Category.class)
                    .setParameter("categoryName", name)
                    .getResultStream()
                    .findFirst()
                    .orElse(null);
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Category> findAll() {
        EntityManager entityManager = JpaConfig.getEntityManager();
        try {
            return entityManager.createNamedQuery("Category.findAll", Category.class).getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Category> searchByName(String categoryName) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        try {
            TypedQuery<Category> query = entityManager.createQuery(
                    "SELECT c FROM Category c WHERE LOWER(c.categoryName) LIKE LOWER(:categoryName) ORDER BY c.categoryId",
                    Category.class);
            return query.setParameter("categoryName", "%" + categoryName.trim() + "%").getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Category> findAll(int page, int pageSize) {
        if (page < 0 || pageSize <= 0) {
            throw new IllegalArgumentException("page phải >= 0 và pageSize phải > 0");
        }
        EntityManager entityManager = JpaConfig.getEntityManager();
        try {
            return entityManager.createNamedQuery("Category.findAll", Category.class)
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
            Long total = entityManager.createQuery("SELECT COUNT(c) FROM Category c", Long.class).getSingleResult();
            return total.intValue();
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
