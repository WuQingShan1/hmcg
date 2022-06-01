package com.yjxxt.crm.model;/*
  Created by IntelliJ IDEA.
  User: wuqingshan
  Date: 2022/5/21
  Time: 12:25
  To change this template use File | Settings | File Templates.
*/

public class UserModel {
    private String userIdStr;

    private String userName;
    private String trueName;

    public String getUserIdStr() {
        return userIdStr;
    }

    public void setUserIdStr(String userIdStr) {
        this.userIdStr = userIdStr;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getTrueName() {
        return trueName;
    }

    public void setTrueName(String trueName) {
        this.trueName = trueName;
    }
}
