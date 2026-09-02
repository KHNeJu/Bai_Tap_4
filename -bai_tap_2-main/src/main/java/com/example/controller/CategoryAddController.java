package com.example.controller;

import com.example.model.Category;
import com.example.service.ICategoryService;
import com.example.service.impl.CategoryServiceImpl;
import com.example.util.Constant;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

@WebServlet(urlPatterns = {"/admin/category/add", "/admin/category/insert"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class CategoryAddController extends HttpServlet {
    ICategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("/views/admin/add-category.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String categoryName = req.getParameter("categoryName");
        int status = Integer.parseInt(req.getParameter("status"));

        Category category = new Category();
        category.setCategoryName(categoryName);
        category.setStatus(status);
        String imageUrl = req.getParameter("images");

        try {
            Part part = req.getPart("icon");
            if (part != null && part.getSize() > 0) {
                String originalFileName = extractFileName(part);
                if (originalFileName != null && !originalFileName.isEmpty()) {
                    int index = originalFileName.lastIndexOf(".");
                    String ext = "";
                    if (index > 0) {
                        ext = originalFileName.substring(index);
                    }
                    String fileName = System.currentTimeMillis() + ext;
                    
                    File uploadDir = new File(Constant.DIR + File.separator + "category");
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    
                    part.write(Constant.DIR + File.separator + "category" + File.separator + fileName);
                    category.setImages("category/" + fileName);
                }
            }
            if (category.getImages() == null && imageUrl != null && !imageUrl.isBlank()) {
                category.setImages(imageUrl.trim());
            }
            cateService.insert(category);
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("alert", "System error!");
            req.getRequestDispatcher("/views/admin/add-category.jsp").forward(req, resp);
        }
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
}
