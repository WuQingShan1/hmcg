package com.yjxxt.crm;/*     
  Created by IntelliJ IDEA.
  User: wuqingshan
  Date: 2022/5/21
  Time: 16:57
  To change this template use File | Settings | File Templates.
*/

import com.alibaba.fastjson.JSON;
import com.yjxxt.crm.base.ResultInfo;
import com.yjxxt.crm.exceptions.NoLoginException;
import com.yjxxt.crm.exceptions.ParamsException;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@Component
public class GlobalExceptionResolver implements HandlerExceptionResolver {
    @Override
    public ModelAndView resolveException
            (HttpServletRequest request,
               HttpServletResponse response,
             Object handler, Exception ex) {
        if (ex instanceof NoLoginException){
            System.out.println("cookie未登录");
            ModelAndView modelAndView = new ModelAndView();
            modelAndView.setViewName("redirect:/index");
            return modelAndView;
        }
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("code",500);
        modelAndView.addObject("msg","错误信息");
        modelAndView.setViewName("error");
        if (handler instanceof HandlerMethod){
            HandlerMethod  handlerMethod = (HandlerMethod) handler;
            ResponseBody responseBody = handlerMethod.getMethod().getDeclaredAnnotation(ResponseBody.class);
            if (responseBody==null){
                if (ex instanceof ParamsException){
                    ParamsException p = (ParamsException) ex;
                    modelAndView.addObject("code",p.getCode());
                    modelAndView.addObject("msg",p.getMsg());
                }
                return modelAndView;
            }else{
                ResultInfo resultInfo = new ResultInfo();
                resultInfo.setCode(500);
                resultInfo.setMsg("网络异常");
                if (ex instanceof ParamsException){
                    ParamsException p = (ParamsException) ex;
                    resultInfo.setCode(p.getCode());
                    resultInfo.setMsg(p.getMsg());
                }
                response.setContentType("application/json;charset=UTF-8");
                try{
                    PrintWriter out = response.getWriter();
                    out.write(JSON.toJSONString(resultInfo));
                    out.flush();
                    out.close();
                }catch (IOException i){
                    i.printStackTrace();
                }
                return null;
            }
        }

        return modelAndView;
    }
}
