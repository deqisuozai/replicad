#!/bin/bash

# Replicad 项目快速启动脚本
# 自动完成开发环境的启动

echo "🚀 Replicad 项目快速启动..."
echo "=================================="

# 检查是否在项目根目录
if [ ! -f "package.json" ] || [ ! -f "lerna.json" ]; then
    echo "❌ 请在项目根目录运行此脚本"
    exit 1
fi

# 检查依赖是否安装
if [ ! -d "node_modules" ]; then
    echo "📦 安装项目依赖..."
    pnpm install
    if [ $? -ne 0 ]; then
        echo "❌ 依赖安装失败"
        exit 1
    fi
    echo "✅ 依赖安装完成"
else
    echo "✅ 依赖已安装"
fi

# 构建核心包
echo "🏗️ 构建核心包..."
cd packages/replicad
pnpm run build
if [ $? -ne 0 ]; then
    echo "❌ 核心包构建失败"
    exit 1
fi
echo "✅ 核心包构建完成"
cd ../..

# 启动开发服务
echo "🌐 启动开发服务..."
echo ""
echo "选择要启动的服务:"
echo "1) Studio (Web 编辑器)"
echo "2) 文档网站"
echo "3) 示例应用"
echo "4) 所有服务"
echo "5) 退出"
echo ""
read -p "请输入选择 (1-5): " choice

case $choice in
    1)
        echo "🚀 启动 Studio..."
        cd packages/studio
        pnpm run start &
        STUDIO_PID=$!
        echo "✅ Studio 已启动 (PID: $STUDIO_PID)"
        echo "🌐 访问地址: http://localhost:5173"
        echo "按 Ctrl+C 停止服务"
        wait $STUDIO_PID
        ;;
    2)
        echo "🚀 启动文档网站..."
        cd packages/replicad-docs
        pnpm run start &
        DOCS_PID=$!
        echo "✅ 文档网站已启动 (PID: $DOCS_PID)"
        echo "🌐 访问地址: http://localhost:3333"
        echo "按 Ctrl+C 停止服务"
        wait $DOCS_PID
        ;;
    3)
        echo "🚀 启动示例应用..."
        cd packages/replicad-app-example
        pnpm run start &
        EXAMPLE_PID=$!
        echo "✅ 示例应用已启动 (PID: $EXAMPLE_PID)"
        echo "🌐 访问地址: http://localhost:5173"
        echo "按 Ctrl+C 停止服务"
        wait $EXAMPLE_PID
        ;;
    4)
        echo "🚀 启动所有服务..."
        
        # 启动 Studio
        cd packages/studio
        pnpm run start &
        STUDIO_PID=$!
        echo "✅ Studio 已启动 (PID: $STUDIO_PID) - http://localhost:5173"
        cd ../..
        
        # 启动文档
        cd packages/replicad-docs
        pnpm run start &
        DOCS_PID=$!
        echo "✅ 文档网站已启动 (PID: $DOCS_PID) - http://localhost:3333"
        cd ../..
        
        # 启动示例应用 (使用不同端口)
        cd packages/replicad-app-example
        PORT=5174 pnpm run start &
        EXAMPLE_PID=$!
        echo "✅ 示例应用已启动 (PID: $EXAMPLE_PID) - http://localhost:5174"
        cd ../..
        
        echo ""
        echo "🎉 所有服务已启动！"
        echo "🌐 Studio: http://localhost:5173"
        echo "🌐 文档: http://localhost:3333"
        echo "🌐 示例: http://localhost:5174"
        echo ""
        echo "按 Ctrl+C 停止所有服务"
        
        # 等待用户中断
        trap "echo '🛑 停止所有服务...'; kill $STUDIO_PID $DOCS_PID $EXAMPLE_PID 2>/dev/null; exit" INT
        wait
        ;;
    5)
        echo "👋 退出"
        exit 0
        ;;
    *)
        echo "❌ 无效选择"
        exit 1
        ;;
esac

echo ""
echo "=================================="
echo "🎉 开发环境启动完成！"
echo ""
echo "💡 提示:"
echo "   - 使用 .cursor/check-config.sh 检查配置"
echo "   - 查看 .cursor/DEVELOPMENT.md 了解开发流程"
echo "   - 使用 Cursor 编辑器的任务系统运行命令"
echo ""
echo "🚀 开始编码吧！"
