package com.bjpowernode.service.impl;

import com.bjpowernode.dao.ProductDao;
import com.bjpowernode.pojo.Product;
import com.bjpowernode.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {
    @Autowired
    private ProductDao productDao;

    public List<Product> queryList() {
        return productDao.queryList();
    }

    public void delete(String... ids) {
        for (String s : ids) {
            productDao.delete(s);
        }
    }

    public void save(Product product) {
        productDao.save(product);
    }

    public Product getById(String id) {
        return productDao.getById(id);
    }

    public void edit(Product product) {
        productDao.edit(product);
    }
}
