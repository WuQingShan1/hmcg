package com.yjxxt.crm.dao;

import com.yjxxt.crm.base.BaseMapper;
import com.yjxxt.crm.vo.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

public interface UserMapper extends BaseMapper<User,Integer> {

    User selectByPrimaryKey(Integer id);
    User queryUserByName(String userName);
    int updateByPrimaryKey(@Param("newPwd") String newPwd, @Param("userId")  Integer userId);
    List<Map<String,Object>> queryAllSales();


}