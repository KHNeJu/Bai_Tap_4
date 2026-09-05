package com.example.controller;

import com.example.model.User;
import com.example.service.UserService;
import com.example.service.impl.UserServiceImpl;
import com.example.util.Constant;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.regex.Pattern;

@WebServlet(urlPatterns = {"/profile", "/profile/update"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50)
public class ProfileController extends HttpServlet {
    private static final Pattern PHONE_PATTERN = Pattern.compile("[0-9+() .-]{7,20}");
    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User currentUser = getLoggedInUser(req, resp);
        if (currentUser == null) {
            return;
        }
        User user = userService.findById(currentUser.getId());
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.setAttribute("user", user);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/views/profile.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        User currentUser = getLoggedInUser(req, resp);
        if (currentUser == null) {
            return;
        }

        try {
            String fullName = req.getParameter("fullName");
            String phone = req.getParameter("phone");

                if (fullName == null || fullName.isBlank() || fullName.trim().length() < 2
                    || fullName.trim().length() > 255) {
                req.setAttribute("alert", "Họ tên không được để trống.");
                req.setAttribute("user", userService.findById(currentUser.getId()));
                req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
                return;
            }
            if (phone != null && !phone.isBlank() && !PHONE_PATTERN.matcher(phone.trim()).matches()) {
                req.setAttribute("alert", "Số điện thoại không hợp lệ.");
                req.setAttribute("user", userService.findById(currentUser.getId()));
                req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
                return;
            }

            String avatarPath = null;
            Part avatarPart = req.getPart("avatar");
            if (avatarPart != null && avatarPart.getSize() > 0) {
                String originalFileName = extractFileName(avatarPart);
                if (originalFileName != null && !originalFileName.isEmpty()) {
                    int index = originalFileName.lastIndexOf(".");
                    String ext = index > 0 ? originalFileName.substring(index) : "";
                    String fileName = System.currentTimeMillis() + ext;

                    File uploadDir = new File(Constant.DIR + File.separator + "user");
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }

                    avatarPart.write(Constant.DIR + File.separator + "user" + File.separator + fileName);
                    avatarPath = "user/" + fileName;
                }
            } else {
                String existingAvatar = req.getParameter("avatarUrl");
                if (existingAvatar != null && !existingAvatar.isBlank()) {
                    existingAvatar = existingAvatar.trim();
                    if (!existingAvatar.matches("https?://[^\\s]+") || existingAvatar.length() > 255) {
                        req.setAttribute("alert", "Link ảnh đại diện không hợp lệ.");
                        req.setAttribute("user", userService.findById(currentUser.getId()));
                        req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
                        return;
                    }
                    avatarPath = existingAvatar;
                }
            }

            boolean updated = userService.updateProfile(currentUser.getId(), fullName, phone, avatarPath);
            if (!updated) {
                req.setAttribute("alert", "Cập nhật thất bại. Số điện thoại có thể đã được sử dụng.");
                req.setAttribute("user", userService.findById(currentUser.getId()));
                req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
                return;
            }

            User refreshedUser = userService.findById(currentUser.getId());
            HttpSession session = req.getSession(false);
            if (session != null) {
                session.setAttribute("account", refreshedUser);
            }

            req.setAttribute("success", "Cập nhật hồ sơ thành công.");
            req.setAttribute("user", refreshedUser);
            req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("alert", "Lỗi hệ thống khi cập nhật hồ sơ.");
            req.setAttribute("user", userService.findById(currentUser.getId()));
            req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
        }
    }

    private User getLoggedInUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return null;
        }
        return (User) session.getAttribute("account");
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp == null) {
            return "";
        }
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
}
