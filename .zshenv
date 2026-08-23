# ~/.config/zsh/.zshenv

# ---------- XDG 基础目录 ----------
# 集中管理配置、缓存、数据等目录位置
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# ---------- 编辑器 ----------
# Git、crontab 等工具默认使用的编辑器
export EDITOR="nvim"
export VISUAL="nvim"

# ---------- 分页器 ----------
# 使用 bat 美化 man 手册页显示
if command -v bat >/dev/null 2>&1; then
  export MANPAGER="bat -l man -p"
elif command -v batcat >/dev/null 2>&1; then
  export MANPAGER="batcat -l man -p"
fi

# 使用 bat 美化 PARU 显示
export PARU_PAGER="bat"

# ---------- GPG ----------
# 设置 GPG 终端，用于密码输入等交互操作
export GPG_TTY=$(tty)

# ---------- Starship ----------
# 指定 Starship 提示符的配置文件位置
export STARSHIP_CONFIG="$ZDOTDIR/starship.toml"

# ---------- PATH ----------
# 添加个人脚本和可执行文件目录到 PATH
export PATH="$HOME/.local/bin:$PATH"
