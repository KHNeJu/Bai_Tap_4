package com.example.service;

import com.example.model.Category;

import java.util.List;

/** Service contract matching the required Category CRUD methods. */
public interface ICategoryService {
    void insert(Category category);
    int count();
    List<Category> findAll(int page, int pageSize);
    List<Category> searchByName(String categoryName);
    List<Category> findAll();
    Category findById(int categoryId);
    void delete(int categoryId);
    void update(Category category);
    Category findByCategoryname(String name);
}
