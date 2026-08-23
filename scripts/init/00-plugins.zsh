# ============================================================
#  插件管理
# ============================================================


# ---------- 插件安装目录 ----------
# 所有 Zsh 插件都存放在这个目录下
ZPLUGINDIR="${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}/plugins"
export FAST_WORK_DIR="$XDG_CONFIG_HOME/zsh/themes"

# ---------- 插件加载函数 ----------
# 功能：自动从 GitHub 克隆插件（如果尚未安装），然后加载它
# 参数：$1 = GitHub 用户名，$2 = 仓库名
# 示例：_zplugin_load zsh-users zsh-autosuggestions
_zplugin_load() {
  local plugin_path="${ZPLUGINDIR}/${2}"          # 插件本地路径

  # 如果插件目录不存在，则自动克隆
  if [[ ! -d "$plugin_path" ]]; then
    mkdir -p "$ZPLUGINDIR"                        # 确保插件目录存在
    echo "正在安装 ${2}..."
    git clone --depth=1 "https://github.com/${1}/${2}" "$plugin_path" \
      || { echo "错误：安装 ${2} 失败" >&2; return 1; }
  fi

  source "${plugin_path}/${2}.plugin.zsh"
}

# ---------- 批量更新所有插件 ----------
zplugin-update() {
  local dir
  for dir in "${ZPLUGINDIR}"/*/; do
    echo "正在更新 ${dir:t}..."
    git -C "$dir" pull --ff-only                 # 仅快进合并，避免冲突
  done
}

# ============================================================
#  加载具体插件
# ============================================================

# ---------- zsh-history-substring-search ----------
# 按子串搜索历史记录
_zplugin_load zsh-users zsh-history-substring-search

# ---------- zsh-autosuggestions ----------
# 结合历史记录和命令补全
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
_zplugin_load zsh-users zsh-autosuggestions

# ---------- zsh-vi-mode ----------
# Vi 风格的命令行编辑模式
_zplugin_load jeffreytse zsh-vi-mode

# ---------- fast-syntax-highlighting ----------
# 命令语法高亮

_zplugin_load zdharma-continuum fast-syntax-highlighting
