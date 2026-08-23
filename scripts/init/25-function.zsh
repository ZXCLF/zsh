# =========================================================
# 函数定义
# =========================================================

# Yazi 文件管理器 + 自动 cd
yz() {
    local tmp="$(mktemp /tmp/yazi-cwd.XXXXXX)"
    command yazi --cwd-file="$tmp" "$@"

    if [ -f "$tmp" ] && [ -s "$tmp" ]; then
        local dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ] && [ "$dir" != "$(pwd)" ]; then
            cd "$dir"
        fi
    else
        rm -f "$tmp"
    fi
}

# 智能激活 Python 虚拟环境（在当前 shell 中 source，避免子 shell 丢失激活状态）
venv() {
    if [ -f "venv/bin/activate" ]; then
        source venv/bin/activate
    elif [ -f ".venv/bin/activate" ]; then
        source .venv/bin/activate
    elif [ -f "env/bin/activate" ]; then
        source env/bin/activate
    else
        echo "未找到虚拟环境" >&2
        return 1
    fi
}

# 创建并激活 Python 虚拟环境（在当前 shell 中 source，避免子 shell 丢失激活状态）
mkva() {
    python -m venv venv && source venv/bin/activate
}

# DNS 重置函数
dnsreset() {
    local dns="${1:-127.0.0.1 8.8.8.8}"
    sudo nmcli connection modify "Wired connection 1" ipv4.dns "$dns" && \
    sudo nmcli connection down "Wired connection 1" && \
    sudo nmcli connection up "Wired connection 1"
}

# Waydroid 挂载
waymount() {
    sudo mount --bind ~/Downloads/share ~/.local/share/waydroid/data/media/0/Download
}

# Waydroid 卸载
wayumount() {
    sudo umount /home/zxclf/.local/share/waydroid/data/media/0/Download 2>/dev/null
}

# 日志清理
cleanlog() {
    echo "即将清理 coredump 和日志文件，确认？(y/N)"
    read -r confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        sudo rm -rf /var/lib/systemd/coredump/* && \
        sudo journalctl --rotate && \
        sudo journalctl --vacuum-size=1M
        echo "清理完成！"
    else
        echo "已取消"
    fi
}
