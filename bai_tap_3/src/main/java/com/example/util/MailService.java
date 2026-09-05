package com.example.util;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;

public final class MailService {
    private MailService() {
    }

    public static void sendOtp(String recipient, String otp, String subject) {
        String username = getSetting("MAIL_USERNAME", "mail.username");
        String password = getSetting("MAIL_PASSWORD", "mail.password");
        if (username == null || username.isBlank() || password == null || password.isBlank()) {
            throw new IllegalStateException("Chưa cấu hình Gmail. Hãy đặt MAIL_USERNAME/MAIL_PASSWORD trong Environment variables của Tomcat hoặc thêm -Dmail.username và -Dmail.password vào VM options.");
        }

        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
            message.setSubject(subject);
            message.setText("Mã OTP của bạn là: " + otp + "\nMã có hiệu lực trong 10 phút.");
            Transport.send(message);
        } catch (Exception exception) {
            throw new IllegalStateException("Không thể gửi email OTP.", exception);
        }
    }

    private static String getSetting(String environmentName, String systemPropertyName) {
        String value = System.getenv(environmentName);
        if (value == null || value.isBlank()) {
            value = System.getProperty(systemPropertyName);
        }
        return value;
    }
}