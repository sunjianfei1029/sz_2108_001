package com.bjpowernode.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("user")
public class UserController {

    /*@PostMapping("login.do")
    public String login(String username, String password, HttpSession session) {
        if("zhangsan".equals(username)&&"123".equals(password)) {
            // 完成登录操作，将用户信息保存到session中，后续需要根据session中是否有用户信息来判断是否已登录
            session.setAttribute("loginUser", username);
            return "redirect:/index.html";
        }
        return "redirect:/user/login.html";
    }*/

    @PostMapping("login.do")
    public void login(String username, String password, HttpSession session, HttpServletResponse response) throws Exception {
        if("zhangsan".equals(username)&&"123".equals(password)) {
            // 完成登录操作，将用户信息保存到session中，后续需要根据session中是否有用户信息来判断是否已登录
            session.setAttribute("loginUser", username);
            response.sendRedirect("/index.html");
        }
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().write("<script>alert('账号或密码错误！');history.go(-1);</script>");
    }
    @PostMapping("login2.do")
    @ResponseBody // 将方法的返回值转换为json
    public Map login(String username, String password, HttpSession session) throws Exception {

        Map map = new HashMap();

        if("zhangsan".equals(username)&&"123".equals(password)) {
            // 完成登录操作，将用户信息保存到session中，后续需要根据session中是否有用户信息来判断是否已登录
            session.setAttribute("loginUser", username);
            map.put("success", true);
            return map;
        }
        map.put("success", false);
        map.put("msg", "账号或密码错误！");
        return map;
    }

    @GetMapping("login.html")
    public String login() {
        return "login";
    }
}
