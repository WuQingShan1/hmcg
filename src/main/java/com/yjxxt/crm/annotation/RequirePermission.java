package com.yjxxt.crm.annotation;/*     
  Created by IntelliJ IDEA.
  User: wuqingshan
  Date: 2022/5/26
  Time: 23:38
  To change this template use File | Settings | File Templates.
*/

import java.lang.annotation.*;

@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface RequirePermission {
    String code() default "";
}
