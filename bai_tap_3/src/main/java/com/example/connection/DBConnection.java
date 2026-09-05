package com.example.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private final String serverName = "localhost";
    private final String dbName = "user_database";
    private final String portNumber = "3306";
    private final String userID = "root";
    private final String password = System.getenv().getOrDefault("DB_PASSWORD", "100706");

    public Connection getConnection() throws Exception {
        String url = "jdbc:mysql://localhost:3306/user_database?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&characterEncoding=UTF-8";
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, userID, password);
    }
}
