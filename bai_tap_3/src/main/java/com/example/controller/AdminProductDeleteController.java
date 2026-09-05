package com.example.controller;

import com.example.service.IProductService;
import com.example.service.impl.ProductServiceImpl;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/product/delete")
public class AdminProductDeleteController extends HttpServlet {
    private final IProductService productService = new ProductServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            productService.delete(Integer.parseInt(request.getParameter("id")));
        } catch (Exception ignored) {
            // Return to the list even when an invalid id is submitted.
        }
        response.sendRedirect(request.getContextPath() + "/admin/product/list");
    }
}
