# ============================================================
#  命令历史配置
# ============================================================

HISTFILE="$XDG_STATE_HOME/zsh/history"      # 历史记录文件位置
HISTSIZE=100000                              # 内存中保留的最大历史条目数
SAVEHIST=100000                              # 历史文件中保存的最大条目数


setopt APPEND_HISTORY        # 追加历史而非覆盖（多个终端会话共享）
setopt SHARE_HISTORY         # 在所有终端会话间实时共享历史
setopt HIST_IGNORE_DUPS      # 忽略连续重复的命令
setopt HIST_IGNORE_SPACE     # 不记录以空格开头的命令
setopt HIST_EXPIRE_DUPS_FIRST # 去重时优先删除重复项
setopt HIST_FIND_NO_DUPS     # 搜索历史时不显示重复项
setopt HIST_REDUCE_BLANKS  # 删除多余空格

# ============================================================
#  Shell 行为设置
# ============================================================

setopt AUTOCD                # 直接输入目录名即可进入（无需 cd 命令）
setopt NOBEEP                # 关闭错误提示音（哔哔声）
setopt NUMERIC_GLOB_SORT     # 数字排序更智能：file10 排在 file9 后面，而非 file1 后面

# ============================================================
#  智能目录导航
# ============================================================

# 初始化 zoxide（智能 cd 工具，记住你常去的目录）
eval "$(zoxide init zsh)"

# ============================================================
#  命令补全系统
# ============================================================

# # 加载补全系统模块
autoload -Uz compinit
#
# # 初始化补全，使用缓存文件加速
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"



# 启用交互式补全菜单
zstyle ':completion:*' menu select

# 让补全忽略大小写
# 示例：输入 "doc" 可以补全到 "Documents"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'   # 小写输入可匹配大写和小写

# ============================================================
#  Fuzzy Finder（模糊查找器）
# ============================================================

# 加载 fzf 的按键绑定和补全功能

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# ============================================================
#  模块化配置文件加载
# ============================================================

for file in $ZDOTDIR/scripts/init/*.zsh(N); do
    # echo "正在加载: $(basename $file)"
    source "$file"
done


# 将自定义命令目录加入 PATH
export PATH="$ZDOTDIR/scripts/bin:$PATH"

# 加载 fnm
eval "$(fnm env --use-on-cd)"

# ============================================================
#  加载用户配置
# ============================================================

if [[ -f "$ZDOTDIR/local.zsh" ]]; then
  source "$ZDOTDIR/local.zsh"
fi
