# xiaozhi-mcp-music 桥接进程 —— Railway 云端部署
# 用法：把这个文件 + railway.json 提交到你 fork 的仓库根目录，Railway 从 GitHub 构建
FROM python:3.13-slim

WORKDIR /app

# 复制仓库全部代码（fork 后仓库根目录就是构建上下文）
COPY . .

# 安装依赖（与项目 README 一致）
RUN pip install --no-cache-dir -r requirements-dev.txt

# 生成桥接配置（真实密钥一律走 Railway Variables 注入，不要提交 .env）
RUN cp mcp_config.example.json mcp_config.json 2>/dev/null || true

# 常驻连接小智官方控制台的 MCP 接入点，断线自动重连
CMD ["python", "bridge.py"]
