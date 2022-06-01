package com.yjxxt.crm.controller;/*     
  Created by IntelliJ IDEA.
  User: wuqingshan
  Date: 2022/5/20
  Time: 20:49
  To change this template use File | Settings | File Templates.
*/

import com.yjxxt.crm.base.BaseController;
import com.yjxxt.crm.service.UserService;
import com.yjxxt.crm.utils.LoginUserUtil;
import com.yjxxt.crm.vo.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class IndexController extends BaseController {
    @Resource
    private UserService service;

//    @RequestMapping("index")
    @RequestMapping("index")
    public String index(HttpServletRequest request){
        System.out.println(request.getAttribute("ctx"));
        System.out.println("jjjjjfffjjjj");
        return "index";
    }
    @RequestMapping("welcome")
    public String welcome(){
        return "welcome";
    }
    @RequestMapping("main")
    public String main(HttpSession session,HttpServletRequest request){
        Cookie[] cookies =  request.getCookies();
        for (Cookie cookie : cookies) {
            System.out.println(cookie.getName()+"......."+cookie.getValue());
        }
        Integer userId = LoginUserUtil.releaseUserIdFromCookie(request);

        User user =service.selectByPrimaryKey(userId);
        session.setAttribute("user",user);
//        List<String> permissions = permissionService.queryUserHasRolesHasPermissions(user.getId());
//        System.out.println(permissions.toString());
//        request.getSession().setAttribute("permissions",permissions);
        return "main";
    }
}
