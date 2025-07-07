#!/bin/bash

# Mall Blog 开发环境停止脚本

set -e

echo "🛑 停止 Mall Blog 开发环境..."

# 使用 docker compose 或 docker-compose
if command -v docker compose &> /dev/null; then
    DOCKER_COMPOSE_CMD="docker compose"
else
    DOCKER_COMPOSE_CMD="docker-compose"
fi

# 停止并移除容器
$DOCKER_COMPOSE_CMD down

echo "✅ 开发环境已停止"
echo ""
echo "💡 提示："
echo "  - 数据已保存在 Docker volumes 中"
echo "  - 重新启动: ./scripts/start-dev.sh"
echo "  - 完全清理: ./scripts/clean-dev.sh" 