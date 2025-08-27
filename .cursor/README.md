# Cursor 编辑器配置

这个目录包含了为 Replicad 项目优化的 Cursor 编辑器配置。

## 文件说明

### 📋 `rules`
- 定义项目的代码风格和开发规范
- 包含命名约定、文件组织、导入规范等
- 确保团队成员遵循一致的编码标准

### ⚙️ `settings.json`
- 项目特定的编辑器设置
- 配置 TypeScript、ESLint、Prettier 等工具
- 优化开发体验和代码质量

### 🚀 `tasks.json`
- 预定义的开发任务
- 包含构建、测试、启动等常用命令
- 可通过 `Ctrl+Shift+P` → "Tasks: Run Task" 执行

### 🐛 `launch.json`
- 调试配置
- 支持测试、Web 应用和 Node.js 调试
- 配置了 Chrome 调试器用于前端应用

### 🔌 `extensions.json`
- 推荐的扩展列表
- 包含 TypeScript、React、Git 等开发必需扩展
- 新团队成员打开项目时会自动提示安装

### 📝 `snippets/typescript.json`
- 代码片段模板
- 包含 Replicad 相关的常用代码模式
- 提高开发效率，减少重复代码

## 使用方法

### 1. 安装推荐扩展
打开项目后，Cursor 会提示安装推荐的扩展，点击安装即可。

### 2. 运行任务
- 按 `Ctrl+Shift+P` 打开命令面板
- 输入 "Tasks: Run Task"
- 选择需要的任务执行

### 3. 使用代码片段
在 TypeScript 文件中输入片段前缀（如 `replicad-sketcher`），按 Tab 键展开。

### 4. 调试应用
- 在调试面板选择相应的调试配置
- 按 F5 开始调试
- 支持断点、变量查看等调试功能

## 自定义配置

如需修改配置：
1. 编辑相应的配置文件
2. 重启 Cursor 编辑器
3. 配置会立即生效

## 注意事项

- 确保已安装 Node.js v20.12.1
- 使用 pnpm 作为包管理器
- 遵循项目的代码风格规范
- 提交前运行代码检查任务

## 常见问题

### Q: 任务执行失败？
A: 检查是否正确安装了依赖，运行 `pnpm install`

### Q: 调试器无法连接？
A: 确保目标应用已启动，检查端口配置

### Q: 代码片段不生效？
A: 确认文件类型为 TypeScript，重启编辑器

## 技术支持

如有配置问题，请参考：
- [Cursor 官方文档](https://cursor.sh/docs)
- [VS Code 配置指南](https://code.visualstudio.com/docs)
- 项目 README 和开发文档
