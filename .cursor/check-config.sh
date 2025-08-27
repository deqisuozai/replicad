#!/bin/bash

# Replicad 项目配置检查脚本
# 用于验证开发环境配置是否正确

echo "🔍 检查 Replicad 项目配置..."
echo "=================================="

# 检查 Node.js 版本
echo "📦 检查 Node.js 版本..."
NODE_VERSION=$(node --version)
REQUIRED_VERSION="v20.12.1"

if [ "$NODE_VERSION" = "$REQUIRED_VERSION" ]; then
    echo "✅ Node.js 版本正确: $NODE_VERSION"
else
    echo "❌ Node.js 版本不匹配"
    echo "   当前版本: $NODE_VERSION"
    echo "   需要版本: $REQUIRED_VERSION"
    echo "   请运行: nvm use"
fi

# 检查 pnpm 版本
echo -e "\n📦 检查 pnpm 版本..."
if command -v pnpm &> /dev/null; then
    PNPM_VERSION=$(pnpm --version)
    echo "✅ pnpm 已安装: $PNPM_VERSION"
else
    echo "❌ pnpm 未安装"
    echo "   请运行: npm install -g pnpm"
fi

# 检查依赖是否安装
echo -e "\n📦 检查项目依赖..."
if [ -d "node_modules" ]; then
    echo "✅ 根目录依赖已安装"
else
    echo "❌ 根目录依赖未安装"
    echo "   请运行: pnpm install"
fi

# 检查各个包的依赖
echo -e "\n📦 检查包依赖..."
PACKAGES=("replicad" "studio" "replicad-docs" "replicad-app-example")

for package in "${PACKAGES[@]}"; do
    if [ -d "packages/$package/node_modules" ]; then
        echo "✅ $package 依赖已安装"
    else
        echo "❌ $package 依赖未安装"
    fi
done

# 检查构建输出
echo -e "\n🏗️ 检查构建输出..."
if [ -d "packages/replicad/dist" ]; then
    echo "✅ replicad 核心包已构建"
else
    echo "❌ replicad 核心包未构建"
    echo "   请运行: cd packages/replicad && pnpm run build"
fi

# 检查配置文件
echo -e "\n⚙️ 检查配置文件..."
CONFIG_FILES=(".nvmrc" "package.json" "lerna.json" "pnpm-workspace.yaml")

for config in "${CONFIG_FILES[@]}"; do
    if [ -f "$config" ]; then
        echo "✅ $config 存在"
    else
        echo "❌ $config 缺失"
    fi
done

# 检查 Cursor 配置
echo -e "\n🎯 检查 Cursor 配置..."
CURSOR_FILES=(".cursor/rules" ".cursor/settings.json" ".cursor/tasks.json" ".cursor/launch.json")

for config in "${CURSOR_FILES[@]}"; do
    if [ -f "$config" ]; then
        echo "✅ $config 存在"
    else
        echo "❌ $config 缺失"
    fi
done

# 检查端口占用
echo -e "\n🌐 检查端口占用..."
PORTS=("5173" "3333")

for port in "${PORTS[@]}"; do
    if lsof -Pi :$port -sTCP:LISTEN -t >/dev/null ; then
        echo "⚠️  端口 $port 已被占用"
    else
        echo "✅ 端口 $port 可用"
    fi
done

# 检查 Git 状态
echo -e "\n📝 检查 Git 状态..."
if [ -d ".git" ]; then
    echo "✅ Git 仓库已初始化"
    
    # 检查是否有未提交的更改
    if [ -n "$(git status --porcelain)" ]; then
        echo "⚠️  有未提交的更改"
        git status --short
    else
        echo "✅ 工作目录干净"
    fi
else
    echo "❌ Git 仓库未初始化"
fi

echo -e "\n=================================="
echo "🎉 配置检查完成！"
echo ""
echo "💡 提示:"
echo "   - 使用 'pnpm install' 安装依赖"
echo "   - 使用 'pnpm run prepare-packages' 构建所有包"
echo "   - 使用 'cd packages/studio && pnpm run start' 启动 Studio"
echo "   - 使用 'cd packages/replicad-docs && pnpm run start' 启动文档"
echo ""
echo "📚 更多信息请查看 .cursor/DEVELOPMENT.md"
