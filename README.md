# Mall 服务技术文档

这是一个用于学习和实践的 博客网站项目，涵盖了后端、前端及 CI/CD 的主流技术栈，适合中大型互联网应用的开发与部署。

---

## 目录结构建议

```
mall/
├── server/   # 后端 Java 服务
│   ├── src/
│   ├── config/
│   ├── docs/
│   ├── docker/
│   └── tests/
├── ui/       # 前端 React 项目
│   ├── src/
│   ├── public/
│   ├── docs/
│   └── tests/
├── docker-compose.yml  # 本地开发环境
├── docs/              # 项目文档
└── tech.md            # 技术文档
```

---

## 系统架构

```
┌─────────────┐    ┌──────────────┐    ┌─────────────┐
│   前端 UI   │────│   后端 API   │────│   数据存储   │
│   React     │    │ Spring Boot  │    │ Postgres    │
│   Vite      │    │ Spring Sec   │    │ MongoDB     │
│   Tailwind  │    │ MyBatis      │    │ Redis       │
└─────────────┘    └──────────────┘    │ Elasticsearch│
                           │           └─────────────┘
                           │
                   ┌──────────────┐
                   │   消息队列    │
                   │   RabbitMQ   │
                   └──────────────┘
```

---

## 后端

- 目录：`server/`
- 技术栈：
  - **Spring Boot**：微服务框架，快速开发
  - **Spring Security**：认证授权框架
  - **MyBatis**：持久层框架，数据库操作
  - **Elasticsearch**：搜索引擎，商品搜索/推荐
  - **RabbitMQ**：异步消息队列，订单处理
  - **Redis**：缓存、会话存储、限流
  - **MongoDB**：非关系型数据库，商品详情/日志
  - **Postgres**：关系型数据库，核心业务数据
  - **Maven**：项目构建工具
  - **Java GraalVM**：高性能 JVM

- **开发环境要求**：
  - JDK 最新+（推荐 GraalVM）
  - Maven 3.8+
  - Postgres 14+
  - Redis 7+
  - MongoDB 5+
  - Elasticsearch 7+

- **本地启动示例**：
  ```bash
  cd server
  ./mvnw spring-boot:run
  ```

- **API 文档**：
  - 使用 Swagger/OpenAPI 3.0 自动生成
  - 本地访问：`http://localhost:8080/swagger-ui.html`
  - API 规范文件：`server/docs/api-spec.yml`

---

## 前端

- 目录：`ui/`
- 技术栈：
  - **TypeScript**：类型安全的 JavaScript
  - **React**：前端框架，组件化开发
  - **Tailwind CSS**：原子化 CSS 框架
  - **Shadcn**：现代化 UI 组件库
  - **Bun**：快速的包管理器和运行时
  - **Vite**：构建工具，快速热重载

- **开发环境要求**：
  - Node.js 18+ 或 Bun 1.0+
  - 推荐使用 Bun 进行依赖管理和开发

- **本地启动示例**：
  ```bash
  cd ui
  bun install
  bun run dev
  ```

- **构建部署**：
  ```bash
  bun run build    # 生产构建
  bun run preview  # 预览构建结果
  ```

---

## Docker 支持

### 本地开发环境
```bash
# 启动所有服务（数据库、缓存、搜索引擎等）
docker-compose up -d

# 停止服务
docker-compose down
```

### Docker Compose 配置示例
```yaml
# docker-compose.yml
version: '3.8'
services:
  postgres:
    image: postgres:14
    environment:
      POSTGRES_DB: mall
      POSTGRES_USER: mall
      POSTGRES_PASSWORD: password
    ports:
      - "5432:5432"
  
  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
  
  mongodb:
    image: mongo:5
    ports:
      - "27017:27017"
  
  elasticsearch:
    image: elasticsearch:7.17.0
    environment:
      - discovery.type=single-node
    ports:
      - "9200:9200"
  
  rabbitmq:
    image: rabbitmq:3-management
    ports:
      - "5672:5672"
      - "15672:15672"
```

---

## 数据库初始化

- **数据库迁移工具**：Flyway 或 Liquibase
- **初始化脚本位置**：`server/db/migration/`
- **种子数据**：`server/db/seed/`
- **执行方式**：
  ```bash
  # 执行数据库迁移
  ./mvnw flyway:migrate
  
  # 清理并重新初始化
  ./mvnw flyway:clean flyway:migrate
  ```

---

## 测试策略

### 后端测试
- **单元测试**：JUnit 5 + Mockito
- **集成测试**：Spring Boot Test + Testcontainers
- **API 测试**：RestAssured 或 MockMvc
- **运行测试**：
  ```bash
  cd server
  ./mvnw test                    # 单元测试
  ./mvnw verify -P integration   # 集成测试
  ```

### 前端测试
- **单元测试**：Vitest + React Testing Library
- **端到端测试**：Playwright 或 Cypress
- **运行测试**：
  ```bash
  cd ui
  bun test                # 单元测试
  bun test:e2e           # 端到端测试
  ```

---

## CI/CD

- **使用 GitHub Actions 实现自动化部署流水线**
- **推荐流程**：
  1. 代码检查（Lint/Format）
  2. 单元测试 + 集成测试
  3. 安全扫描（依赖漏洞检查）
  4. 构建 Docker 镜像
  5. 部署到测试环境
  6. 自动化测试验证
  7. 部署到生产环境

### 部署文件位置
- GitHub Actions：`.github/workflows/`
- Docker 构建：`Dockerfile`
- Kubernetes 配置：`k8s/`

---

## 监控和日志

### 日志管理
- **后端日志**：Logback + SLF4J
- **日志格式**：JSON 格式，便于日志聚合
- **日志级别**：DEBUG（开发）、INFO（生产）

### 监控方案
- **应用监控**：Spring Boot Actuator + Micrometer
- **系统监控**：可选 Prometheus + Grafana
- **链路追踪**：可选 Zipkin 或 Jaeger
- **健康检查端点**：`/actuator/health`

---

## 安全配置

### 认证授权
- **JWT Token** 认证机制
- **RBAC** 角色权限控制（管理员、编辑、普通用户）
- **密码加密**：BCrypt

### 安全措施
- **HTTPS** 强制使用
- **CORS** 跨域请求控制
- **SQL 注入防护**：参数化查询
- **XSS 防护**：输入验证和输出转义
- **API 限流**：Redis + Spring Security

### 配置文件安全
```bash
# 敏感配置使用环境变量
export DB_PASSWORD=your_password
export JWT_SECRET=your_jwt_secret
export REDIS_PASSWORD=your_redis_password
```

---

## 部署环境说明

### 开发环境
- **本地开发**：Docker Compose 一键启动
- **数据库**：本地 Docker 容器
- **调试模式**：开启热重载和详细日志

### 测试环境
- **自动部署**：每次 PR 合并后自动部署
- **数据隔离**：独立的测试数据库
- **性能测试**：定期执行压力测试

### 生产环境
- **高可用部署**：多实例负载均衡
- **数据备份**：定期备份数据库和文件
- **监控告警**：24/7 监控和告警机制
- **灰度发布**：分阶段发布新版本
- **CDN 加速**：静态资源和图片加速

### 推荐部署平台
- **云服务**：阿里云、腾讯云、AWS
- **容器编排**：Kubernetes 或 Docker Swarm
- **CI/CD 平台**：GitHub Actions、GitLab CI
- **CDN 服务**：阿里云 CDN、CloudFlare

---

## 常见问题与解决办法

- **端口冲突**：请确保本地未占用 8080（后端）、5173（前端）等默认端口
- **依赖安装失败**：建议使用国内镜像源或 VPN
- **数据库连接失败**：检查数据库服务是否启动，配置是否正确
- **内存不足**：建议开发环境至少 8GB RAM
- **Docker 构建慢**：使用多阶段构建和镜像缓存优化

---

## 贡献指南

- 欢迎提交 issue 和 PR
- 建议遵循分支管理规范（如 feature/xxx, fix/xxx）
- 代码需通过所有 CI 检查
- 提交前请运行本地测试：`./scripts/test-all.sh`
- 遵循代码规范：后端使用 Google Java Style，前端使用 Prettier

---

## License

- 本项目采用 MIT License
- 详见：`LICENSE` 文件