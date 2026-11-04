# xiaozhi-mcp-music 桥接进程 —— Railway 云端部署
FROM python:3.13-slim

WORKDIR /app

COPY . .

RUN pip install --no-cache-dir -r requirements-dev.txt

# 生成 Linux 版 mcp_config.json（仓库 example 写死 Windows 路径，容器不可用）。
# 注意：env 里不要写死 MUSIC_SOURCES —— mcp_pipe 启动子进程时 config.env 会覆盖
# Railway Variables，导致改音源开关无效；音源统一走 Railway Variables 继承。
RUN printf '%s\n' \
    '{' \
    '  "mcpServers": {' \
    '    "xiaozhi-music": {' \
    '      "type": "stdio",' \
    '      "command": "python",' \
    '      "args": ["-m", "music_mcp"],' \
    '      "env": {' \
    '        "LOG_LEVEL": "INFO"' \
    '      }' \
    '    }' \
    '  }' \
    '}' > mcp_config.json

CMD ["python", "bridge.py"]
