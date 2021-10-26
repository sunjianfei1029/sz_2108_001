package com.bjpowernode.web.controller;

import com.bjpowernode.pojo.Product;
import com.bjpowernode.service.ProductService;
import com.bjpowernode.web.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Map;

//@Controller
//@ResponseBody // 相当于每个方法上都有该注解
@RestController // @Controller+@ResponseBody
@RequestMapping("product")
public class ProductControllerRESTFul {
    @Autowired
    private ProductService productService;

    //@RequestMapping("/products.json")
    @GetMapping("products.json")
    public List products() {
        return productService.queryList();
    }

    //@RequestMapping(method = RequestMethod.POST)
    @PostMapping
    public Map save2(Product product) {
        productService.save(product);
        return Result.SUCCESS;
    }

    //@RequestMapping(value = "{id}", method = RequestMethod.DELETE)
    @DeleteMapping("{id}/{name}")
    public Map delete2(@PathVariable String[] id, @PathVariable String name) {
        System.out.println(name);
        productService.delete(id);
        return Result.SUCCESS;
    }

    // 处理get请求
    //@RequestMapping(value = "{id}", method = RequestMethod.GET)
    @GetMapping("{id}")
    public Product toEdit(@PathVariable String id) {
        System.out.println(id);
        System.out.println(id);
        System.out.println(id);
        return productService.getById(id);
    }

    // 处理post请求
    //@RequestMapping(method = RequestMethod.PUT)
    @PutMapping
    public Map edit2(Product product) {
        System.out.println(product);
        productService.edit(product);
        return Result.SUCCESS;
    }
}
