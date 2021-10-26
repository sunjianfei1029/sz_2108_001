package com.bjpowernode.web.controller;

import com.bjpowernode.pojo.Product;
import com.bjpowernode.service.ProductService;
import com.bjpowernode.web.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Map;

@Controller
public class ProductController {
    @Autowired
    private ProductService productService;

    @RequestMapping("/index.html")
    public ModelAndView get(ModelAndView mv) {
        List<Product> products = productService.queryList();
        mv.addObject("products", products);
        mv.setViewName("index");
        return mv;
    }

    @RequestMapping("/add.html")
    public String add() {
        return "add";
    }

    @RequestMapping("/edit.html")
    public ModelAndView edit(String id) {
        ModelAndView mv = new ModelAndView();
        Product product = productService.getById(id);
        mv.addObject("product", product);
        mv.setViewName("edit");
        return mv;
    }

    @RequestMapping("/save.do")
    public String save(Product product) {
        productService.save(product);
        return "redirect:/index.html";
    }

    @RequestMapping("/edit.do")
    public String edit(Product product) {
        productService.edit(product);
        return "redirect:/index.html";
    }

    @RequestMapping("/delete.do")
    public String delete(String[] id) {
        productService.delete(id);
        return "redirect:/index.html";
    }

    @RequestMapping("/index_ajax.html")
    public String indexAjax() {
        return "index_ajax";
    }

    @RequestMapping("/ajax/products.json")
    @ResponseBody // 将方法的返回值转换为json
    public List products() {
        return productService.queryList();
    }

    @RequestMapping("/ajax/save.do")
    @ResponseBody // 将方法的返回值转换为json
    public Map save2(Product product) {
        productService.save(product);
        return Result.SUCCESS;
    }

    @RequestMapping("/ajax/delete.do")
    @ResponseBody // 将方法的返回值转换为json
    public Map delete2(String[] id) {
        productService.delete(id);
        return Result.SUCCESS;
    }

    // 处理get请求
    @RequestMapping(value = "/ajax/edit.do", method = RequestMethod.GET)
    @ResponseBody // 将方法的返回值转换为json
    public Product toEdit(String id) {
        return productService.getById(id);
    }

    // 处理post请求
    @RequestMapping(value = "/ajax/edit.do", method = RequestMethod.POST)
    @ResponseBody // 将方法的返回值转换为json
    public Map edit2(Product product) {
        productService.edit(product);
        return Result.SUCCESS;
    }
}
