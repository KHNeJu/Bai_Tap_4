package com.example.service.impl;

import com.example.dao.IProductDao;
import com.example.dao.impl.ProductDao;
import com.example.model.Product;
import com.example.service.IProductService;

import java.util.List;

public class ProductServiceImpl implements IProductService {
    private final IProductDao productDao = new ProductDao();

    @Override public void insert(Product product) { productDao.insert(product); }
    @Override public void update(Product product) { productDao.update(product); }
    @Override public void delete(int id) { productDao.delete(id); }
    @Override public Product findById(int id) { return productDao.findById(id); }
    @Override public List<Product> findLatest(int limit) { return productDao.findLatest(limit); }
    @Override public List<Product> findPage(int page, int pageSize) { return productDao.findPage(page, pageSize); }
    @Override public int count() { return productDao.count(); }
}
