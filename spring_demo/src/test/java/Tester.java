import com.bjpowernode.pojo.Product;
import com.bjpowernode.service.ProductService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@ContextConfiguration("classpath:applicationContext.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class Tester {
    @Autowired
    private ProductService productService;

    @Test
    public void test01() {
        List<Product> products = productService.queryList();
        System.out.println(products);
    }
}
