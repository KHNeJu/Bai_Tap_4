package com.example.service;

import com.example.model.Product;

import java.util.List;

public interface IProductService {
    void insert(Product product);
    void update(Product product);
    void delete(int id);
    Product findById(int id);
    List<Product> findLatest(int limit);
    List<Product> findPage(int page, int pageSize);
    int count();
}
