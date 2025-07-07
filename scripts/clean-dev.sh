#!/bin/bash

# Mall Blog 开发环境清理脚本

set -e

echo "🧹 清理 Mall Blog 开发环境..."

# 使用 docker compose 或 docker-compose
if command -v docker compose &> /dev/null; then
    DOCKER_COMPOSE_CMD="docker compose"
else
    DOCKER_COMPOSE_CMD="docker-compose"
fi

# 确认操作
read -p "⚠️  这将删除所有数据库数据，确定继续吗？(y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ 操作已取消"
    exit 1
fi

# 停止并移除容器和卷
$DOCKER_COMPOSE_CMD down -v

# 清理相关镜像（可选）
read -p "🗑️  是否同时清理 Docker 镜像？(y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🗑️  清理镜像..."
    docker image prune -f
    docker volume prune -f
fi

echo "✅ 开发环境已完全清理"
echo ""
echo "🚀 重新开始: ./scripts/start-dev.sh" 