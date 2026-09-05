package com.example.controller;

import com.example.model.User;
import com.example.service.UserService;
import com.example.service.impl.UserServiceImpl;
import com.example.util.MailService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.SecureRandom;

@WebServlet("/forgot-password")
public class ForgotPasswordController extends HttpServlet {
    private static final SecureRandom RANDOM = new SecureRandom();
    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        User user = email == null ? null : userService.findByEmail(email.trim());
        if (user == null) {
            request.setAttribute("alert", "Không tìm thấy tài khoản với email này.");
            doGet(request, response);
            return;
        }

        String otp = String.format("%06d", RANDOM.nextInt(1_000_000));
        HttpSession session = request.getSession(true);
        session.setAttribute("resetEmail", user.getEmail());
        session.setAttribute("resetOtp", otp);
        session.setAttribute("resetOtpExpires", System.currentTimeMillis() + 10 * 60 * 1000L);
        try {
            MailService.sendOtp(user.getEmail(), otp, "Mã xác nhận đặt lại mật khẩu");
            response.sendRedirect(request.getContextPath() + "/forgot-password/verify");
        } catch (IllegalStateException exception) {
            session.invalidate();
            request.setAttribute("alert", exception.getMessage());
            doGet(request, response);
        }
    }
}
