package com.yjxxt.crm.interceptors;/*     
  Created by IntelliJ IDEA.
  User: wuqingshan
  Date: 2022/5/21
  Time: 18:14
  To change this template use File | Settings | File Templates.
*/

import com.yjxxt.crm.exceptions.NoLoginException;
import com.yjxxt.crm.service.UserService;
import com.yjxxt.crm.utils.LoginUserUtil;
import com.yjxxt.crm.vo.User;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.ws.Service;

public class NoLoginInterceptor extends HandlerInterceptorAdapter {
   @Resource
   private UserService service;
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
         Integer userId = LoginUserUtil.releaseUserIdFromCookie(request);
         User user =service.selectByPrimaryKey(userId);
        System.out.println(userId);
         if (null==userId||null==user){
             throw new NoLoginException();
         }
        return true;
    }
}
