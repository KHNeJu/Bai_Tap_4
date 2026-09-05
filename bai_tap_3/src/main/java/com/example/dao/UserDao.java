package com.example.dao;

import com.example.model.User;

public interface UserDao {
    User get(String username);

    User findById(int id);

    User findByEmail(String email);

    User findByPhone(String phone);

    void insert(User user);

    void update(User user);

    boolean checkExistEmail(String email);

    boolean checkExistUsername(String username);

    boolean checkExistPhone(String phone);
}
