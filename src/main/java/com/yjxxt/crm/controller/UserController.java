package com.yjxxt.crm.controller;/*     
  Created by IntelliJ IDEA.
  User: wuqingshan
  Date: 2022/5/21
  Time: 10:33
  To change this template use File | Settings | File Templates.
*/

import com.yjxxt.crm.model.UserModel;
import com.yjxxt.crm.base.BaseController;
import com.yjxxt.crm.base.ResultInfo;
import com.yjxxt.crm.exceptions.ParamsException;
import com.yjxxt.crm.query.UserQuery;
import com.yjxxt.crm.service.UserService;
import com.yjxxt.crm.utils.LoginUserUtil;
import com.yjxxt.crm.utils.Md5Util;
import com.yjxxt.crm.vo.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("user")
public class UserController extends BaseController {
    @Resource
    private UserService service;
    @RequestMapping(value="login",method = RequestMethod.POST)
    @ResponseBody
    public ResultInfo userLogin(String userName,String userPwd){
        ResultInfo resultInfo  = new ResultInfo();
        try{
            UserModel userModel = service.loginCheck(userName,userPwd);
            resultInfo.setResult(userModel);
            System.out.println("user");
        }catch (ParamsException p){
            p.printStackTrace();
            resultInfo.setCode(p.getCode());
            resultInfo.setMsg(p.getMsg());
        }catch (Exception e){
            e.printStackTrace();
            resultInfo.setMsg("用户登录失败");
            resultInfo.setCode(500);
        }
        return resultInfo;
    }
}
