package com.mall.dto;

import io.swagger.v3.oas.annotations.media.Schema;

import java.time.LocalDateTime;

@Schema(description = "测试接口响应")
public record TestResponse(
    @Schema(description = "响应消息", example = "Hello World")
    String message,
    
    @Schema(description = "服务名称", example = "mall-server") 
    String service,
    
    @Schema(description = "响应时间戳")
    LocalDateTime timestamp,
    
    @Schema(description = "响应状态", example = "success")
    String status
) {} 