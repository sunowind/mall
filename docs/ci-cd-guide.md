# CI/CD 流程指南

## 🔄 工作流概述

Mall Blog 项目使用 GitHub Actions 实现自动化的 CI/CD 流程，确保代码质量和快速部署。

## 📋 流水线阶段

### 1. 代码质量检查 (Code Quality)
- **触发条件**: 每次 push 和 PR
- **检查内容**:
  - 代码格式检查 (Lint)
  - 依赖缓存优化
  - 基础构建验证

### 2. 自动化测试 (Testing)
- **后端测试**:
  - 单元测试 (JUnit 5)
  - 集成测试 (Testcontainers)
  - 测试覆盖率报告
- **前端测试**:
  - 组件测试 (Vitest)
  - 类型检查 (TypeScript)
  - 测试结果上传

### 3. 安全扫描 (Security)
- **漏洞扫描**: Trivy 扫描代码和依赖
- **安全报告**: 自动上传到 GitHub Security 标签
- **阻断策略**: 高危漏洞将阻止部署

### 4. Docker 构建 (Build)
- **多阶段构建**: 优化镜像大小
- **镜像推送**: 推送到 GitHub Container Registry
- **标签管理**: latest + commit hash
- **缓存优化**: GitHub Actions 缓存

### 5. 部署 (Deploy)
- **测试环境**: main 分支自动部署
- **生产环境**: 手动触发或 tag 部署
- **烟雾测试**: 部署后自动验证

## 🚀 分支策略

### 分支命名规范
```
feature/TASK-123-add-user-auth    # 新功能
fix/TASK-456-login-bug           # 问题修复  
hotfix/TASK-789-critical-error   # 热修复
release/v1.2.0                   # 发布准备
```

### 工作流程
```
feature/* → PR → main → deploy to staging
main → tag → deploy to production
```

## 📝 PR 规范

### PR 标题格式
```
feat: add user authentication
fix: resolve login redirect issue
docs: update API documentation
refactor: optimize database queries
test: add integration tests for auth
```

### PR 自动检查
- ✅ 分支命名规范
- ✅ PR 标题语义化
- ✅ 合并冲突检测
- ✅ 快速构建验证
- ✅ 自动请求代码审查

## 🔧 本地开发流程

### 1. 创建功能分支
```bash
git checkout -b feature/TASK-123-add-feature
```

### 2. 本地验证
```bash
# 运行测试
cd server && mvn test
cd ui && npm test

# 代码格式检查
cd server && mvn spotless:apply
cd ui && npm run lint:fix

# 本地构建
docker build -t mall-backend server/
docker build -t mall-frontend ui/
```

### 3. 提交代码
```bash
git add .
git commit -m "feat: add new feature"
git push origin feature/TASK-123-add-feature
```

### 4. 创建 PR
- 填写 PR 描述模板
- 等待自动检查完成
- 请求代码审查
- 合并到 main 分支

## 🎯 状态检查

### 必须通过的检查
- [ ] Code Quality Check
- [ ] Backend Tests  
- [ ] Frontend Tests
- [ ] Security Scan
- [ ] Docker Build

### 可选检查
- [ ] Performance Tests
- [ ] E2E Tests
- [ ] Accessibility Tests

## 🔍 故障排除

### 常见问题

**1. 测试失败**
```bash
# 查看测试日志
gh run view --log

# 本地复现
mvn test -Dtest=FailedTestName
```

**2. Docker 构建失败**
```bash
# 本地构建调试
docker build --no-cache -t debug-image .

# 检查 Dockerfile
docker run -it debug-image sh
```

**3. 依赖问题**
```bash
# 清理缓存
mvn dependency:purge-local-repository
npm ci --cache .npm --prefer-offline
```

### 调试工具
- **GitHub Actions**: `gh run view --log`
- **Docker**: `docker logs container_name`
- **Maven**: `mvn -X` (调试模式)
- **npm**: `npm run test -- --verbose`

## 📊 监控和指标

### 构建指标
- 构建时间趋势
- 测试覆盖率变化
- 部署成功率
- 失败原因统计

### 质量指标
- 代码覆盖率: 目标 >80%
- 安全漏洞: 零高危漏洞
- 构建时间: <10分钟
- 部署时间: <5分钟

## 🔐 环境变量和密钥

### GitHub Secrets
```
GITHUB_TOKEN          # 自动生成
DOCKER_REGISTRY_TOKEN # Container Registry 访问
STAGING_DEPLOY_KEY    # 测试环境部署密钥
PROD_DEPLOY_KEY       # 生产环境部署密钥
```

### 环境配置
```yaml
# staging 环境
DATABASE_URL: staging-db-url
REDIS_URL: staging-redis-url

# production 环境  
DATABASE_URL: prod-db-url
REDIS_URL: prod-redis-url
```

## 📚 相关文档

- [开发环境搭建](./development-setup.md)
- [Docker 部署指南](./deployment.md)
- [API 文档](./api-documentation.md)
- [测试指南](./testing-guide.md) 