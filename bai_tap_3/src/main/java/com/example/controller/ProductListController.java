package com.example.controller;

import com.example.service.IProductService;
import com.example.service.impl.ProductServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/product")
public class ProductListController extends HttpServlet {
    private static final int PAGE_SIZE = 6;
    private final IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int page = parsePage(request.getParameter("page"));
        int total = productService.count();
        int totalPages = Math.max(1, (int) Math.ceil(total / (double) PAGE_SIZE));
        page = Math.min(page, totalPages - 1);
        request.setAttribute("products", productService.findPage(page, PAGE_SIZE));
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("/views/products.jsp").forward(request, response);
    }

    private int parsePage(String value) {
        try {
            return Math.max(0, Integer.parseInt(value) - 1);
        } catch (Exception ignored) {
            return 0;
        }
    }
}
