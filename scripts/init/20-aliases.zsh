# =========================================================
# 别名定义
# =========================================================

if [[ -o interactive ]]; then
    # 更好的 ls
    alias ls='eza --icons=auto'
    # 树形目录结构
    alias tree='eza --tree --icons=auto'
fi

# 详细列表模式
alias ll='eza -lh --icons=auto --git'

# 详细列表模式（包含隐藏文件）
alias la='eza -lah --icons=auto --git'

# 复用 ls 的自动补全给 eza（避免单独定义补全函数）
compdef eza=ls

# =========================================================
# 更好的 cat
# =========================================================

alias cat='bat --paging=never --style=plain'

# =========================================================
# 核心工具
# =========================================================

alias rgrep='rg --color=auto'        # 使用 ripgrep 替代 grep
alias diff='diff --color=auto'      # diff 输出带颜色
alias df='df -h'                    # 磁盘空间以人类可读格式显示


# pacman 别名

alias pacman='smart-pacman'



# =========================================================
# 目录导航
# =========================================================

alias -- -='cd -'

# =========================================================
# 编辑器
# =========================================================

alias vim='nvim'  # 使用 Neovim 替代 Vim

# =========================================================
# Git
# =========================================================

alias glog='PAGER="less -F -X" git log'                              # -F 一屏内容则退出，-X 退出时不清屏
alias gadog='PAGER="less -F -X" git log --all --decorate --oneline --graph'  # 带分支图的完整日志

# =========================================================
# Python 开发
# =========================================================

# pip 常用操作
alias pi='pip install'
alias pir='pip install -r requirements.txt'
alias pfr='pip freeze > requirements.txt'
alias pls='pip list'


# 在当前目录启动 HTTP 服务器
alias pyserve='python -m http.server'

# =========================================================
# 系统管理
# =========================================================

alias suspend='sudo systemctl suspend'
alias daemon='sudo systemctl daemon-reload'           # 重载 systemd
alias rtlog='journalctl -f -o short-iso'               # 实时日志
alias logerr='journalctl -p err -b'                      # 本次启动的错误
alias logk='journalctl -k -f'                          # 内核实时日志

# =========================================================
# 杂项
# =========================================================

alias weather='curl wttr.in'              # 命令行天气
alias path='echo -e ${PATH//:/\\n}'       # 每行显示一个路径
alias tmux='tmux -f "$XDG_CONFIG_HOME"/tmux/tmux.conf'
