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

@WebServlet(urlPatterns = {"/admin/category/edit", "/admin/category/update"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class CategoryEditController extends HttpServlet {
    ICategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            int id = Integer.parseInt(idStr);
            Category category = cateService.findById(id);
            req.setAttribute("category", category);
            RequestDispatcher dispatcher = req.getRequestDispatcher("/views/admin/edit-category.jsp");
            dispatcher.forward(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        try {
            int id = Integer.parseInt(req.getParameter("id"));
            String categoryName = req.getParameter("categoryName");
            int status = Integer.parseInt(req.getParameter("status"));

            Category category = new Category();
            category.setCategoryId(id);
            category.setCategoryName(categoryName);
            category.setStatus(status);

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
            } else {
                String imageUrl = req.getParameter("images");
                category.setImages(imageUrl == null || imageUrl.isBlank() ? null : imageUrl.trim());
            }

            cateService.update(category);
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("alert", "System error!");
            req.getRequestDispatcher("/views/admin/edit-category.jsp").forward(req, resp);
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
