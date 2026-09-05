package com.example.util;

import java.nio.file.Path;

public class Constant {
    public static final String SESSION_USERNAME = "username";
    public static final String COOKIE_REMEMBER = "username";
    public static final String REGISTER = "/views/register.jsp";
        public static final String DIR = Path.of(System.getProperty("user.dir"), "uploads")
            .toAbsolutePath().normalize().toString();
}
