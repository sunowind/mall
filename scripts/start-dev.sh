#!/bin/bash

# Mall Blog 开发环境启动脚本

set -e

echo "🚀 启动 Mall Blog 开发环境..."

# 检查 Docker 是否安装
if ! command -v docker &> /dev/null; then
    echo "❌ Docker 未安装，请先安装 Docker"
    exit 1
fi

if ! command -v docker-compose &> /dev/null && ! command -v docker compose &> /dev/null; then
    echo "❌ Docker Compose 未安装，请先安装 Docker Compose"
    exit 1
fi

# 创建必要的目录
mkdir -p server/db/init server/db/mongo-init

echo "📦 启动数据库服务..."

# 使用 docker compose 或 docker-compose
if command -v docker compose &> /dev/null; then
    DOCKER_COMPOSE_CMD="docker compose"
else
    DOCKER_COMPOSE_CMD="docker-compose"
fi

# 启动服务
$DOCKER_COMPOSE_CMD up -d

echo "⏳ 等待服务启动..."
sleep 10

# 健康检查
echo "🔍 检查服务状态..."
$DOCKER_COMPOSE_CMD ps

echo "📊 服务访问地址："
echo "  PostgreSQL:    localhost:5432 (用户: mall, 密码: password)"
echo "  Redis:         localhost:6379"
echo "  MongoDB:       localhost:27017 (用户: admin, 密码: password)"
echo "  Elasticsearch: http://localhost:9200"
echo "  RabbitMQ Web:  http://localhost:15672 (用户: admin, 密码: password)"

echo ""
echo "✅ 开发环境启动完成！"
echo ""
echo "📝 下一步："
echo "  1. 启动后端服务: cd server && mvn spring-boot:run"
echo "  2. 启动前端服务: cd ui && bun run dev"
echo ""
echo "🛑 停止服务: ./scripts/stop-dev.sh" 