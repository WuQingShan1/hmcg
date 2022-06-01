package com.yjxxt.crm.aspect;/*     
  Created by IntelliJ IDEA.
  User: wuqingshan
  Date: 2022/5/27
  Time: 11:44
  To change this template use File | Settings | File Templates.
*/

import com.yjxxt.crm.annotation.RequirePermission;
import com.yjxxt.crm.exceptions.NoLoginException;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

@Component
@Aspect
public class PermissionAspect {
    @Resource
    private HttpSession session;
    @Around(value = "@annotation(com.yjxxt.crm.annotation.RequirePermission)")
    public Object around(ProceedingJoinPoint pjp) throws Throwable {

        List<String> permissions = (List<String>) session.getAttribute("permissions");
        if (permissions==null||permissions.size()==0){

        }
        MethodSignature methodSignature = (MethodSignature) pjp.getSignature();
        RequirePermission requirePermission = methodSignature.getMethod().getDeclaredAnnotation(RequirePermission.class);
        if (!permissions.contains(requirePermission.code())) {
            throw new NoLoginException();
        }
        Object object = pjp.proceed();
        return object;
    }
}
