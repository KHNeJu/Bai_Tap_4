package com.example.service.impl;

import com.example.dao.UserDao;
import com.example.dao.impl.UserDaoImpl;
import com.example.model.User;
import com.example.service.UserService;

import java.util.Date;

public class UserServiceImpl implements UserService {
    private UserDao userDao = new UserDaoImpl();

    @Override
    public void insert(User user) {
        userDao.insert(user);
    }

    @Override
    public boolean register(String email, String password, String username, String fullname, String phone) {
        if (userDao.checkExistUsername(username)) {
            return false;
        }
        long millis = System.currentTimeMillis();
        Date date = new Date(millis);
        userDao.insert(new User(email, username, fullname, password, null, 3, phone, date));
        return true;
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.checkExistEmail(email);
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }

    @Override
    public boolean checkExistPhone(String phone) {
        return userDao.checkExistPhone(phone);
    }

    @Override
    public User login(String username, String password) {
        User user = this.get(username);
        if (user != null && password.equals(user.getPassWord())) {
            user.setLastLogin(new Date());
            userDao.update(user);
            return user;
        }
        return null;
    }

    @Override
    public User get(String username) {
        return userDao.get(username);
    }

    @Override
    public User findById(int id) {
        return userDao.findById(id);
    }

    @Override
    public User findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public boolean updatePassword(String email, String password) {
        User user = userDao.findByEmail(email);
        if (user == null) {
            return false;
        }
        user.setPassWord(password);
        userDao.update(user);
        return true;
    }

    @Override
    public boolean updateProfile(int userId, String fullName, String phone, String avatar) {
        User user = userDao.findById(userId);
        if (user == null) {
            return false;
        }
        if (phone != null && !phone.isBlank()) {
            User existing = userDao.findByPhone(phone.trim());
            if (existing != null && existing.getId() != userId) {
                return false;
            }
        }
        user.setFullName(fullName.trim());
        user.setPhone(phone == null || phone.isBlank() ? null : phone.trim());
        if (avatar != null) {
            user.setAvatar(avatar);
        }
        userDao.update(user);
        return true;
    }
}
