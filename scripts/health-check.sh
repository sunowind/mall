#!/bin/bash

# Mall Blog 服务健康检查脚本

set -e

echo "🔍 检查 Mall Blog 服务状态..."

# 检查端口函数
check_port() {
    local port=$1
    local service=$2
    if nc -z localhost $port 2>/dev/null; then
        echo "✅ $service (端口 $port) - 运行中"
        return 0
    else
        echo "❌ $service (端口 $port) - 未运行"
        return 1
    fi
}

# 检查HTTP服务函数
check_http() {
    local url=$1
    local service=$2
    if curl -s -f $url > /dev/null 2>&1; then
        echo "✅ $service ($url) - 可访问"
        return 0
    else
        echo "❌ $service ($url) - 不可访问"
        return 1
    fi
}

echo ""
echo "📊 基础服务检查："

# 检查数据库服务
check_port 5432 "PostgreSQL"
check_port 6379 "Redis"
check_port 27017 "MongoDB"
check_port 9200 "Elasticsearch"
check_port 5672 "RabbitMQ"

echo ""
echo "🌐 Web 服务检查："

# 检查Web服务
check_http "http://localhost:9200" "Elasticsearch API"
check_http "http://localhost:15672" "RabbitMQ 管理界面"

# 检查应用服务（如果运行中）
echo ""
echo "🚀 应用服务检查："
check_http "http://localhost:8080/actuator/health" "后端服务"
check_http "http://localhost:5173" "前端服务"

echo ""
echo "📋 服务状态总结："

# 使用 docker compose 或 docker-compose
if command -v docker compose &> /dev/null; then
    DOCKER_COMPOSE_CMD="docker compose"
else
    DOCKER_COMPOSE_CMD="docker-compose"
fi

if command -v $DOCKER_COMPOSE_CMD &> /dev/null; then
    echo ""
    $DOCKER_COMPOSE_CMD ps
else
    echo "Docker Compose 未安装，无法显示容器状态"
fi

echo ""
echo "🔧 故障排除："
echo "  - 启动服务: ./scripts/start-dev.sh"
echo "  - 查看日志: docker-compose logs [service_name]"
echo "  - 重启服务: docker-compose restart [service_name]" 