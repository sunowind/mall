// Mall Blog MongoDB 初始化脚本
// 创建集合和索引

// 切换到 mall 数据库
db = db.getSiblingDB('mall');

// 创建文章内容集合（存储富文本内容）
db.createCollection('post_contents');

// 创建用户行为日志集合
db.createCollection('user_logs');

// 创建系统配置集合
db.createCollection('system_configs');

// 创建文件元数据集合
db.createCollection('file_metadata');

// 插入一些示例数据
db.post_contents.insertMany([
  {
    post_id: 1,
    content_html: '<h1>欢迎来到Mall Blog</h1><p>这是一个示例文章内容。</p>',
    content_markdown: '# 欢迎来到Mall Blog\n\n这是一个示例文章内容。',
    created_at: new Date(),
    updated_at: new Date()
  }
]);

db.system_configs.insertMany([
  {
    key: 'site_name',
    value: 'Mall Blog',
    description: '网站名称',
    created_at: new Date()
  },
  {
    key: 'site_description',
    value: '一个现代化的博客系统',
    description: '网站描述',
    created_at: new Date()
  }
]);

// 创建索引
db.post_contents.createIndex({ "post_id": 1 }, { unique: true });
db.user_logs.createIndex({ "user_id": 1, "created_at": -1 });
db.system_configs.createIndex({ "key": 1 }, { unique: true });
db.file_metadata.createIndex({ "file_hash": 1 }, { unique: true });

print("MongoDB 初始化完成"); 