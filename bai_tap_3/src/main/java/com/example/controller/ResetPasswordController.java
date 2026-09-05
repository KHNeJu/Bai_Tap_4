package com.example.controller;

import com.example.service.UserService;
import com.example.service.impl.UserServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/forgot-password/verify")
public class ResetPasswordController extends HttpServlet {
    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/reset-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String expectedOtp = session == null ? null : (String) session.getAttribute("resetOtp");
        Long expiresAt = session == null ? null : (Long) session.getAttribute("resetOtpExpires");
        String otp = request.getParameter("otp");
        String password = request.getParameter("password");
        if (expectedOtp == null || expiresAt == null || System.currentTimeMillis() > expiresAt
                || otp == null || !expectedOtp.equals(otp.trim())) {
            request.setAttribute("alert", "Mã OTP không đúng hoặc đã hết hạn.");
            doGet(request, response);
            return;
        }
        if (password == null || password.length() < 6 || password.length() > 255) {
            request.setAttribute("alert", "Mật khẩu phải có từ 6 đến 255 ký tự.");
            doGet(request, response);
            return;
        }
        if (!userService.updatePassword((String) session.getAttribute("resetEmail"), password)) {
            request.setAttribute("alert", "Không thể cập nhật mật khẩu.");
            doGet(request, response);
            return;
        }
        session.invalidate();
        response.sendRedirect(request.getContextPath() + "/login?reset=1");
    }
}
