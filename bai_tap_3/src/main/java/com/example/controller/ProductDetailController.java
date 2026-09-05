package com.example.controller;

import com.example.service.IProductService;
import com.example.service.impl.ProductServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/product/detail")
public class ProductDetailController extends HttpServlet {
    private final IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("product", productService.findById(id));
        } catch (Exception ignored) {
            request.setAttribute("product", null);
        }
        request.getRequestDispatcher("/views/product-detail.jsp").forward(request, response);
    }
}
