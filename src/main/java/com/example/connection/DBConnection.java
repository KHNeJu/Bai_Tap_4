package com.example.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    // Thay đổi tài khoản/mật khẩu tuỳ theo cấu hình MySQL của bạn
    private final String serverName = "localhost";
    private final String dbName = "user_database";
    private final String portNumber = "3306";
    private final String userID = "root";
    private final String password = "Admin123@";

    public Connection getConnection() throws Exception {
        String url = "jdbc:h2:mem:testdb;MODE=MySQL;DB_CLOSE_DELAY=-1;INIT=RUNSCRIPT FROM 'classpath:database.sql'";
        Class.forName("org.h2.Driver");
        return DriverManager.getConnection(url, "sa", "");
    }
}
