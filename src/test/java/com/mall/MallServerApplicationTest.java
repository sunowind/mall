package com.mall;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;

@SpringBootTest
@TestPropertySource(properties = "server.port=0")
public class MallServerApplicationTest {

    @Test
    public void contextLoads() {
        // 测试Spring上下文是否能正常加载
    }
} 