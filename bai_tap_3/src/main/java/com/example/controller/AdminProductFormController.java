package com.example.controller;

import com.example.model.Category;
import com.example.model.Product;
import com.example.service.ICategoryService;
import com.example.service.IProductService;
import com.example.service.impl.CategoryServiceImpl;
import com.example.service.impl.ProductServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;

@WebServlet(urlPatterns = {"/admin/product/add", "/admin/product/insert", "/admin/product/edit", "/admin/product/update"})
public class AdminProductFormController extends HttpServlet {
    private static final BigDecimal MAX_PRICE = new BigDecimal("999999999.99");
    private final IProductService productService = new ProductServiceImpl();
    private final ICategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("categories", categoryService.findAll());
        if (request.getServletPath().endsWith("/edit")) {
            try {
                request.setAttribute("product", productService.findById(Integer.parseInt(request.getParameter("id"))));
            } catch (Exception ignored) {
                response.sendRedirect(request.getContextPath() + "/admin/product/list");
                return;
            }
        }
        request.getRequestDispatcher("/views/admin/product-form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String rawPrice = request.getParameter("price");
            BigDecimal price = new BigDecimal(rawPrice.replace(".", "").replace(',', '.'));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            Category category = categoryService.findById(categoryId);
                if (name == null || name.isBlank() || category == null || price.signum() < 0
                    || price.compareTo(MAX_PRICE) > 0 || price.scale() > 2 || quantity < 0) {
                throw new IllegalArgumentException();
            }
            Product product;
            if (request.getServletPath().endsWith("/update")) {
                product = productService.findById(Integer.parseInt(request.getParameter("id")));
                product.setName(name.trim());
                product.setDescription(description);
                product.setPrice(price);
                product.setQuantity(quantity);
                product.setCategory(category);
            } else {
                product = new Product(name.trim(), description, price, request.getParameter("image"), quantity, new Date(), category);
            }
            product.setImage(request.getParameter("image"));
            if (request.getServletPath().endsWith("/update")) {
                productService.update(product);
            } else {
                productService.insert(product);
            }
            response.sendRedirect(request.getContextPath() + "/admin/product/list");
        } catch (Exception exception) {
            request.setAttribute("alert", "Dữ liệu sản phẩm không hợp lệ.");
            doGet(request, response);
        }
    }
}
