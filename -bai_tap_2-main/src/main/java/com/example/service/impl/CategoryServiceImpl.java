package com.example.service.impl;

import com.example.dao.ICategoryDao;
import com.example.dao.impl.CategoryDao;
import com.example.model.Category;
import com.example.service.ICategoryService;
import com.example.util.Constant;

import java.io.File;
import java.util.List;

public class CategoryServiceImpl implements ICategoryService {
    private final ICategoryDao categoryDao = new CategoryDao();

    @Override
    public void insert(Category category) {
        if (findByCategoryname(category.getCategoryName()) != null) {
            throw new IllegalArgumentException("Tên danh mục đã tồn tại");
        }
        categoryDao.insert(category);
    }

    @Override
    public void update(Category newCategory) {
        Category oldCategory = categoryDao.findById(newCategory.getCategoryId());
        if (oldCategory == null) {
            throw new IllegalArgumentException("Danh mục không tồn tại");
        }
        oldCategory.setCategoryName(newCategory.getCategoryName());
        oldCategory.setStatus(newCategory.getStatus());
        if (newCategory.getImages() != null && !newCategory.getImages().isEmpty()
                && !newCategory.getImages().equals(oldCategory.getImages())) {
            // Xóa ảnh cũ khi ảnh mới thực sự thay đổi.
            String fileName = oldCategory.getImages();
            if (isLocalUpload(fileName)) {
                File file = new File(Constant.DIR + File.separator + fileName);
                if (file.exists()) {
                    file.delete();
                }
            }
            oldCategory.setImages(newCategory.getImages());
        }
        categoryDao.update(oldCategory);
    }

    @Override
    public void delete(int id) {
        Category category = categoryDao.findById(id);
        if (category != null && isLocalUpload(category.getImages())) {
            File file = new File(Constant.DIR + File.separator + category.getImages());
            if (file.exists()) {
                file.delete();
            }
        }
        categoryDao.delete(id);
    }

    @Override
    public Category findById(int id) {
        return categoryDao.findById(id);
    }

    @Override
    public Category findByCategoryname(String name) {
        return categoryDao.findByCategoryname(name);
    }

    @Override
    public List<Category> findAll() {
        return categoryDao.findAll();
    }

    @Override
    public List<Category> searchByName(String keyword) {
        return categoryDao.searchByName(keyword);
    }

    @Override
    public List<Category> findAll(int page, int pageSize) {
        return categoryDao.findAll(page, pageSize);
    }

    @Override
    public int count() {
        return categoryDao.count();
    }

    private boolean isLocalUpload(String image) {
        return image != null && !image.isBlank() && !image.startsWith("http://") && !image.startsWith("https://");
    }
}
