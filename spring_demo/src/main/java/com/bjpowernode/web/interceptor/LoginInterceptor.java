package com.bjpowernode.web.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginInterceptor implements HandlerInterceptor {
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println(request.getRequestURI());
        if( request.getSession().getAttribute("loginUser") == null ) {
            // 强制跳转到登录页面
            response.sendRedirect("/user/login.html");
            return false;
        }

        return true;
    }
}
