# Mall Blog 开发环境搭建指南

## 🚀 快速开始

### 1. 环境要求

- Java 21+ (推荐 GraalVM)
- Node.js 18+ 或 Bun 1.0+
- Maven 3.8+
- Docker 和 Docker Compose (可选，用于数据库服务)

### 2. 项目结构

```
mall/
├── server/          # 后端 Spring Boot 服务
├── ui/              # 前端 React 应用
├── docker-compose.yml # Docker 服务配置
├── scripts/         # 开发脚本
└── docs/           # 项目文档
```

## 📦 方式一：使用 Docker Compose (推荐)

### 启动所有数据库服务

```bash
# 启动开发环境
./scripts/start-dev.sh

# 检查服务状态
./scripts/health-check.sh

# 停止服务
./scripts/stop-dev.sh
```

### 服务访问地址

- **PostgreSQL**: localhost:5432 (用户: mall, 密码: password)
- **Redis**: localhost:6379
- **MongoDB**: localhost:27017 (用户: admin, 密码: password)
- **Elasticsearch**: http://localhost:9200
- **RabbitMQ 管理界面**: http://localhost:15672 (用户: admin, 密码: password)

## 🔧 方式二：手动启动服务

如果 Docker 不可用，可以手动安装和启动各个服务：

### PostgreSQL 安装

```bash
# Ubuntu/Debian
sudo apt install postgresql postgresql-contrib

# 创建数据库和用户
sudo -u postgres psql
CREATE DATABASE mall;
CREATE USER mall WITH PASSWORD 'password';
GRANT ALL PRIVILEGES ON DATABASE mall TO mall;
\q
```

### Redis 安装

```bash
# Ubuntu/Debian
sudo apt install redis-server

# 启动服务
sudo systemctl start redis-server
```

### MongoDB 安装

```bash
# Ubuntu/Debian
sudo apt install mongodb

# 启动服务
sudo systemctl start mongodb
```

## 🏃‍♂️ 启动应用

### 启动后端服务

```bash
cd server
mvn spring-boot:run
```

访问地址：
- API 服务: http://localhost:8080
- 健康检查: http://localhost:8080/actuator/health
- API 测试: http://localhost:8080/api/test

### 启动前端服务

```bash
cd ui
bun install        # 或 npm install
bun run dev        # 或 npm run dev
```

访问地址：http://localhost:5173

## 🧪 测试

### 后端测试

```bash
cd server
mvn test
```

### 前端测试

```bash
cd ui
bun test           # 或 npm test
```

## 🔍 开发工具

### API 文档

- Swagger UI: http://localhost:8080/swagger-ui.html (后续添加)

### 数据库管理

- **PostgreSQL**: 使用 pgAdmin 或 DBeaver
- **MongoDB**: 使用 MongoDB Compass
- **Redis**: 使用 Redis CLI 或 RedisInsight

### 日志查看

```bash
# Docker 服务日志
docker-compose logs -f [service_name]

# 应用日志
tail -f server/logs/application.log
```

## 🛠️ 常见问题

### 端口冲突

如果端口被占用，可以修改配置文件：

- 后端端口: `server/src/main/resources/application.yml`
- 前端端口: `ui/vite.config.ts`
- 数据库端口: `docker-compose.yml`

### 数据库连接失败

1. 确保数据库服务已启动
2. 检查连接配置是否正确
3. 验证防火墙设置

### 内存不足

- 确保至少有 8GB 可用内存
- 调整 Docker 内存限制
- 关闭不必要的服务

## 📚 下一步

1. [API 开发指南](./api-development.md)
2. [前端开发指南](./frontend-development.md)
3. [数据库设计](./database-design.md)
4. [部署指南](./deployment.md) 