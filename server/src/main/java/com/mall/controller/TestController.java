package com.mall.controller;

import com.mall.dto.TestResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;

@RestController
@RequestMapping("/api")
@Tag(name = "测试接口", description = "用于系统测试和健康检查的接口")
public class TestController {

    @Operation(
        summary = "系统测试接口",
        description = "返回系统基本信息，用于验证服务是否正常运行"
    )
    @ApiResponses(value = {
        @ApiResponse(
            responseCode = "200",
            description = "请求成功",
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = TestResponse.class)
            )
        )
    })
    @GetMapping("/test")
    public ResponseEntity<TestResponse> test() {
        TestResponse response = new TestResponse(
                "Hello World",
                "mall-server", 
                LocalDateTime.now(),
                "success"
        );
        
        return ResponseEntity.ok(response);
    }
}
