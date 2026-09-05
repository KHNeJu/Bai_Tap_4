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

@WebServlet("/register/verify")
public class VerifyRegistrationController extends HttpServlet {
    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/verify-registration.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String expectedOtp = session == null ? null : (String) session.getAttribute("registerOtp");
        Long expiresAt = session == null ? null : (Long) session.getAttribute("registerOtpExpires");
        String actualOtp = request.getParameter("otp");
        if (expectedOtp == null || expiresAt == null || System.currentTimeMillis() > expiresAt
                || actualOtp == null || !expectedOtp.equals(actualOtp.trim())) {
            request.setAttribute("alert", "Mã OTP không đúng hoặc đã hết hạn.");
            doGet(request, response);
            return;
        }

        String email = (String) session.getAttribute("pendingRegisterEmail");
        String username = (String) session.getAttribute("pendingRegisterUsername");
        boolean registered = !userService.checkExistEmail(email)
                && userService.register(email,
                (String) session.getAttribute("pendingRegisterPassword"), username,
                (String) session.getAttribute("pendingRegisterFullname"),
                (String) session.getAttribute("pendingRegisterPhone"));
        if (!registered) {
            request.setAttribute("alert", "Email hoặc username đã tồn tại.");
            doGet(request, response);
            return;
        }
        session.invalidate();
        response.sendRedirect(request.getContextPath() + "/login?registered=1");
    }
}
