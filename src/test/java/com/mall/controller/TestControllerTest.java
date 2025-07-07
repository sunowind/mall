package com.mall.controller;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(TestController.class)
public class TestControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    public void testEndpoint_ShouldReturnSuccessResponse() throws Exception {
        mockMvc.perform(get("/api/test"))
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json"))
                .andExpect(jsonPath("$.message").value("Hello World"))
                .andExpect(jsonPath("$.service").value("mall-server"))
                .andExpect(jsonPath("$.status").value("success"))
                .andExpect(jsonPath("$.timestamp").exists());
    }

    @Test
    public void testEndpoint_ShouldReturnCorrectResponseStructure() throws Exception {
        mockMvc.perform(get("/api/test"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message").isString())
                .andExpect(jsonPath("$.service").isString())
                .andExpect(jsonPath("$.status").isString())
                .andExpect(jsonPath("$.timestamp").isString());
    }
} 