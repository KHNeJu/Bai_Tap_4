package com.example.controller;

import com.example.service.UserService;
import com.example.service.impl.UserServiceImpl;
import com.example.util.Constant;
import com.example.util.MailService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.SecureRandom;
import java.util.regex.Pattern;

@WebServlet(urlPatterns = "/register")
public class RegisterController extends HttpServlet {
    private static final Pattern USERNAME_PATTERN = Pattern.compile("[A-Za-z0-9_]{3,50}");
    private static final Pattern PHONE_PATTERN = Pattern.compile("[0-9+() .-]{7,20}");
    private final UserService service = new UserServiceImpl();
    private static final SecureRandom RANDOM = new SecureRandom();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute(Constant.SESSION_USERNAME) != null) {
            resp.sendRedirect(req.getContextPath() + "/admin/home"); // Ví dụ chuyển admin
            return;
        }

        // Check cookie
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(Constant.COOKIE_REMEMBER)) {
                    session = req.getSession(true);
                    session.setAttribute(Constant.SESSION_USERNAME, cookie.getValue());
                    resp.sendRedirect(req.getContextPath() + "/admin/home");
                    return;
                }
            }
        }
        req.getRequestDispatcher(Constant.REGISTER).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        if (isBlank(username) || !USERNAME_PATTERN.matcher(username.trim()).matches()) {
            registerError(req, resp, "Username phải gồm 3-50 ký tự chữ, số hoặc dấu gạch dưới.");
            return;
        }
        if (isBlank(password) || password.length() < 6 || password.length() > 255) {
            registerError(req, resp, "Mật khẩu phải có từ 6 đến 255 ký tự.");
            return;
        }
        if (isBlank(email) || email.length() > 255 || !email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            registerError(req, resp, "Email không hợp lệ.");
            return;
        }
        if (isBlank(fullname) || fullname.trim().length() < 2 || fullname.trim().length() > 255) {
            registerError(req, resp, "Họ tên phải có từ 2 đến 255 ký tự.");
            return;
        }
        if (!isBlank(phone) && !PHONE_PATTERN.matcher(phone.trim()).matches()) {
            registerError(req, resp, "Số điện thoại không hợp lệ.");
            return;
        }

        username = username.trim();
        email = email.trim();
        fullname = fullname.trim();
        phone = isBlank(phone) ? null : phone.trim();

        if (service.checkExistEmail(email)) {
            req.setAttribute("alert", "Email đã tồn tại!");
            req.getRequestDispatcher(Constant.REGISTER).forward(req, resp);
            return;
        }

        if (service.checkExistUsername(username)) {
            req.setAttribute("alert", "Tài khoản đã tồn tại!");
            req.getRequestDispatcher(Constant.REGISTER).forward(req, resp);
            return;
        }

        String otp = String.format("%06d", RANDOM.nextInt(1_000_000));
        HttpSession session = req.getSession(true);
        session.setAttribute("pendingRegisterEmail", email);
        session.setAttribute("pendingRegisterPassword", password);
        session.setAttribute("pendingRegisterUsername", username);
        session.setAttribute("pendingRegisterFullname", fullname);
        session.setAttribute("pendingRegisterPhone", phone);
        session.setAttribute("registerOtp", otp);
        session.setAttribute("registerOtpExpires", System.currentTimeMillis() + 10 * 60 * 1000L);
        try {
            MailService.sendOtp(email, otp, "Mã kích hoạt tài khoản");
            resp.sendRedirect(req.getContextPath() + "/register/verify");
        } catch (IllegalStateException exception) {
            session.invalidate();
            registerError(req, resp, exception.getMessage());
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.isBlank();
    }

    private void registerError(HttpServletRequest req, HttpServletResponse resp, String message)
            throws ServletException, IOException {
        req.setAttribute("alert", message);
        req.getRequestDispatcher(Constant.REGISTER).forward(req, resp);
    }
}
