# Replicad 项目开发指南

## 🚀 快速开始

### 环境要求
- **Node.js**: v20.12.1 (使用 .nvmrc 文件)
- **包管理器**: pnpm 9.13.2+
- **编辑器**: Cursor 或 VS Code

### 安装依赖
```bash
# 安装 pnpm (如果未安装)
npm install -g pnpm

# 安装项目依赖
pnpm install
```

### 开发流程
1. **启动开发环境**
   ```bash
   # 启动 Studio 应用
   cd packages/studio && pnpm run start
   
   # 启动文档
   cd packages/replicad-docs && pnpm run start
   ```

2. **构建项目**
   ```bash
   # 构建所有包
   pnpm run prepare-packages
   
   # 构建特定包
   cd packages/replicad && pnpm run build
   ```

3. **运行测试**
   ```bash
   cd packages/replicad && pnpm run test
   ```

## 🏗️ 项目结构

```
replicad/
├── packages/
│   ├── replicad/              # 核心 3D 建模库
│   ├── replicad-opencascadejs/ # OpenCascadeJS 绑定
│   ├── replicad-threejs-helper/ # Three.js 渲染助手
│   ├── studio/                 # Web 编辑器应用
│   ├── replicad-docs/          # 文档网站
│   └── replicad-app-example/   # 示例应用
├── .cursor/                    # Cursor 编辑器配置
└── 配置文件...
```

## 📝 开发规范

### 代码风格
- 使用 **中文注释** 说明代码逻辑
- 可展示内容使用 **英文** (变量名、函数名、UI文本)
- 遵循 TypeScript 严格模式
- 使用 ESLint + Prettier 保持一致性

### 命名约定
- **类名**: PascalCase (`Sketcher`, `FaceSketcher`)
- **函数/变量**: camelCase (`movePointerTo`, `firstPoint`)
- **常量**: UPPER_SNAKE_CASE (`DEG2RAD`, `RAD2DEG`)
- **文件名**: kebab-case (`shape-helpers.ts`, `sketcher-lib.ts`)

### 文件组织
- **核心逻辑**: `src/` 目录
- **测试文件**: `__tests__/` 目录
- **类型定义**: `.d.ts` 文件
- **配置文件**: 项目根目录

## 🔧 开发工具

### Cursor 编辑器配置
- **任务系统**: 预定义常用开发任务
- **调试配置**: 支持测试和 Web 应用调试
- **代码片段**: Replicad 相关代码模板
- **扩展推荐**: 开发必需的工具扩展

### 常用快捷键
- `Ctrl+Shift+P`: 命令面板
- `Ctrl+Shift+T`: 运行任务
- `F5`: 开始调试
- `Ctrl+Shift+F`: 全局搜索

## 🧪 测试指南

### 测试框架
- **Vitest**: 单元测试
- **Jest**: 快照测试
- **测试位置**: `__tests__/` 目录

### 编写测试
```typescript
import { describe, it, expect } from 'vitest';
import { Sketcher } from 'replicad';

describe('Sketcher 功能测试', () => {
  it('应该能够创建基本形状', () => {
    const sketcher = new Sketcher('XY');
    const shape = sketcher
      .movePointerTo([0, 0])
      .lineTo([10, 0])
      .lineTo([10, 10])
      .close()
      .extrude(5);
    
    expect(shape).toBeDefined();
    
    // 清理资源
    sketcher.delete();
    shape.delete();
  });
});
```

### 运行测试
```bash
# 运行所有测试
pnpm test

# 监听模式
pnpm test --watch

# 生成覆盖率报告
pnpm test --coverage
```

## 📦 包管理

### Monorepo 结构
- 使用 **Lerna** 管理多包项目
- 使用 **pnpm** 作为包管理器
- 工作区配置在 `pnpm-workspace.yaml`

### 包依赖关系
```
replicad (核心库)
├── replicad-opencascadejs
└── replicad-threejs-helper

studio (Web 应用)
├── replicad
├── replicad-opencascadejs
└── replicad-threejs-helper

replicad-app-example
├── replicad
├── replicad-opencascadejs
└── replicad-threejs-helper
```

### 添加新依赖
```bash
# 添加到特定包
cd packages/replicad
pnpm add package-name

# 添加到根目录 (开发依赖)
pnpm add -D package-name -w
```

## 🚀 构建和部署

### 构建流程
1. **TypeScript 编译**: 生成 JavaScript 代码
2. **打包优化**: 使用 Rollup/Vite 打包
3. **类型生成**: 生成 TypeScript 声明文件
4. **资源处理**: 处理静态资源和依赖

### 构建命令
```bash
# 构建所有包
pnpm run prepare-packages

# 构建特定包
cd packages/replicad && pnpm run build

# 构建文档
cd packages/replicad-docs && pnpm run build
```

### 发布流程
```bash
# 发布所有包
pnpm run publish-packages

# 发布特定包
cd packages/replicad
pnpm publish
```

## 🐛 调试指南

### 浏览器调试
- 使用 Chrome DevTools
- 配置 source map
- 设置断点调试

### Node.js 调试
- 使用 Cursor 内置调试器
- 配置 launch.json
- 支持断点和变量查看

### 常见问题
1. **构建失败**: 检查依赖和配置
2. **类型错误**: 运行 TypeScript 检查
3. **运行时错误**: 查看控制台日志
4. **性能问题**: 使用性能分析工具

## 📚 学习资源

### 官方文档
- [Replicad 官网](https://replicad.xyz)
- [API 文档](https://replicad.xyz/docs)
- [示例代码](https://studio.replicad.xyz)

### 技术栈
- **3D 建模**: OpenCascadeJS
- **Web 渲染**: Three.js
- **前端框架**: React 18
- **构建工具**: Vite, Rollup
- **开发语言**: TypeScript

### 社区资源
- [GitHub 仓库](https://github.com/sgenoud/replicad)
- [问题反馈](https://github.com/sgenoud/replicad/issues)
- [讨论区](https://github.com/sgenoud/replicad/discussions)

## 🤝 贡献指南

### 开发流程
1. Fork 项目仓库
2. 创建功能分支
3. 编写代码和测试
4. 提交 Pull Request
5. 代码审查和合并

### 代码审查标准
- 代码风格一致
- 功能测试通过
- 文档更新完整
- 性能影响评估

### 提交规范
```
feat: 添加新功能
fix: 修复 bug
docs: 更新文档
style: 代码格式调整
refactor: 代码重构
test: 添加测试
chore: 构建过程或辅助工具的变动
```

## 📞 获取帮助

- **技术问题**: 查看文档和示例
- **Bug 报告**: 提交 GitHub Issue
- **功能请求**: 在讨论区提出
- **开发支持**: 联系项目维护者

---

*最后更新: 2024年*
