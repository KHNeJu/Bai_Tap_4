package com.example.dao.impl;

import com.example.config.JpaConfig;
import com.example.dao.UserDao;
import com.example.model.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;

public class UserDaoImpl implements UserDao {

    @Override
    public User get(String username) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        try {
            return entityManager.createNamedQuery("User.findByUsername", User.class)
                    .setParameter("username", username)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public User findById(int id) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        try {
            return entityManager.find(User.class, id);
        } finally {
            entityManager.close();
        }
    }

    @Override
    public User findByPhone(String phone) {
        if (phone == null || phone.isBlank()) {
            return null;
        }
        EntityManager entityManager = JpaConfig.getEntityManager();
        try {
            return entityManager.createNamedQuery("User.findByPhone", User.class)
                    .setParameter("phone", phone.trim())
                    .getResultStream()
                    .findFirst()
                    .orElse(null);
        } finally {
            entityManager.close();
        }
    }

    @Override
    public void insert(User user) {
        executeInTransaction(entityManager -> entityManager.persist(user));
    }

    @Override
    public void update(User user) {
        executeInTransaction(entityManager -> entityManager.merge(user));
    }

    @Override
    public boolean checkExistEmail(String email) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        try {
            Long count = entityManager.createQuery(
                            "SELECT COUNT(u) FROM User u WHERE u.email = :email", Long.class)
                    .setParameter("email", email)
                    .getSingleResult();
            return count > 0;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public boolean checkExistUsername(String username) {
        return get(username) != null;
    }

    @Override
    public boolean checkExistPhone(String phone) {
        return findByPhone(phone) != null;
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
