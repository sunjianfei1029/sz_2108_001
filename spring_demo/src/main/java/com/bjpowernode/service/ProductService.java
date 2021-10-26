package com.bjpowernode.service;

import com.bjpowernode.pojo.Product;

import java.util.List;

public interface ProductService {
    List<Product> queryList();

    void delete(String... id);

    void save(Product product);

    Product getById(String id);

    void edit(Product product);
}
