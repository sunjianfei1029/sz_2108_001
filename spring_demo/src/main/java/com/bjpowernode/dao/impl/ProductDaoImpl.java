package com.bjpowernode.dao.impl;

import com.bjpowernode.dao.ProductDao;
import com.bjpowernode.pojo.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProductDaoImpl implements ProductDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Product> queryList() {
        String sql = "select * from product";
        try {
            return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Product.class));
        } catch (Exception e) {
            e.printStackTrace();
            // 抓取异常的目的是为了处理异常

            // 将异常再次抛出的目的是让调用者能够捕获到异常
            throw new RuntimeException(e);
        }
    }

    public void delete(String id) {
        String sql = "delete from product where id=?";
        try {
            jdbcTemplate.update(sql, id);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    public void save(Product product) {
        String sql = "insert into product values(?,?,?,?,?)";
        try {
            jdbcTemplate.update(sql, product.getId(), product.getName(),
                    product.getPrice(), product.getNum(), product.getDescription());
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    public Product getById(String id) {
        String sql = "select * from product where id=?";
        try {
            // queryForObject: 查询一个对象
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Product.class), id);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    public void edit(Product product) {
        String sql = "update product set name=?,price=?,num=?,description=? where id=?";
        try {
            jdbcTemplate.update(sql, product.getName(), product.getPrice(),
                    product.getNum(), product.getDescription(), product.getId());
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }
}
