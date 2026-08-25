# Zsh

一套适用与Arch Linux的 Zsh 配置，让终端焕然一新。


## 致谢 / 参考

本配置基于以下项目构建：

- **[radleylewis/zsh](https://github.com/radleylewis/zsh)** — 整体配置框架、加载机制
- **[shorin-contrib-git](https://github.com/SHORiN-KiWATA/shorin-contrib)** — `scripts/bin/` 下部分实用命令工具（ `paci`、`pacr`、`pacc`、`pak`、`anews` ）


## 安装步骤

### 依赖安装

> **注意**：终端需要安装 [Nerd Font](https://www.nerdfonts.com)（如 JetBrains Mono Nerd Font）才能正确显示图标。

#### Arch Linux

```bash
paru -S --needed zsh neovim eza bat fd fzf zoxide starship ripgrep yazi \
  unrar 7zip zstd tree curl git fnm tmux\
  file ffmpegthumbnailer poppler imagemagick resvg chafa glow mediainfo
```

### 克隆配置仓库

```bash
git clone https://github.com/zxclf/zsh ~/.config/zsh
```

### 配置 Zsh 使用该目录

将以下内容添加到 `/etc/zsh/zshenv`（系统级）或 `~/.zshenv`（用户级）：

```bash
if [[ -z "$XDG_CONFIG_HOME" ]]; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi

if [[ -d "$XDG_CONFIG_HOME/zsh" ]]; then
    export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
fi
```

### 将 Zsh 设为默认 Shell

```bash
chsh -s $(which zsh)
```

### 创建必要目录

```bash
mkdir -p ~/.local/state/zsh   # 历史记录
mkdir -p ~/.cache/zsh         # 补全缓存
mkdir -p ~/.config/zsh/.cache/themes
chmod +x ~/.config/zsh/scripts/bin/*
```

### 启动新 Shell

```bash
zsh
```

**首次启动会自动安装所有插件**，无需额外操作。

## 配置结构

```
$ZDOTDIR/
├── .gitignore                 # 忽略 plugins/、local.zsh、编译文件
├── .zshenv                    # 环境变量（所有 Zsh 会话加载）
├── .zshrc                     # 交互式 Shell 配置
├── README.md
├── local.zsh                  # [gitignored] 本地机器覆盖配置
├── plugins/                   # [gitignored] 自动克隆的插件
├── themes/
│   └── secondary_theme.zsh   # fast-syntax-highlighting 配色主题
├── starship.toml              # Starship 提示符配置
└── scripts/
    ├── bin/                   # 可执行脚本（自动加入 PATH）
    └── init/
        ├── 00-plugins.zsh     # 插件管理器（自动克隆 + 加载）
        ├── 10-fzf.zsh         # fzf 配置
        ├── 20-aliases.zsh     # 命令别名
        ├── 25-function.zsh    # 函数定义
        ├── 30-bindings.zsh    # 按键绑定
        └── 40-prompt.zsh      # 提示符/主题
```

### 加载顺序说明

使用两位数编号，方便后续插入：

- **00-09**: 核心/基础配置（插件管理器）
- **10-19**: 工具配置（fzf 等）
- **20-29**: 别名和函数
- **30-39**: 按键绑定
- **40-49**: UI/主题（prompt、colors）
- **50-59**: 其他自定义配置
- **90-99**: 调试或测试配置

添加新配置只需放入 `scripts/init/` 目录并按编号命名即可。

## 环境变量

以下变量在 `.zshenv` 中设置（所有 Zsh 会话均生效，**不要**在 `.zshrc` 中重复设置）：

| 变量 | 值 | 说明 |
|------|------|------|
| `XDG_CONFIG_HOME` | `$HOME/.config` | 用户配置目录 |
| `XDG_CACHE_HOME` | `$HOME/.cache` | 缓存目录 |
| `XDG_DATA_HOME` | `$HOME/.local/share` | 数据目录 |
| `XDG_STATE_HOME` | `$HOME/.local/state` | 状态数据目录 |
| `EDITOR` / `VISUAL` | `nvim` | 默认编辑器 |
| `MANPAGER` | `bat -l man -p` | man 手册分页器 |
| `PARU_PAGER` | `bat` | paru 输出分页器 |
| `STARSHIP_CONFIG` | `$ZDOTDIR/starship.toml` | Starship 配置文件路径 |
| `GPG_TTY` | `$(tty)` | GPG 终端 |

以下变量在 `.zshrc` 或 init 脚本中设置：

| 变量 | 值 | 说明 |
|------|------|------|
| `HISTFILE` | `$XDG_STATE_HOME/zsh/history` | 历史记录文件 |
| `HISTSIZE` / `SAVEHIST` | `100000` | 历史记录条数 |
| `FAST_WORK_DIR` | `$XDG_CONFIG_HOME/zsh/themes` | 语法高亮主题目录 |
| `FZF_DEFAULT_COMMAND` | `fd --type f --hidden --strip-cwd-prefix` | fzf 默认搜索命令 |
| `FZF_DEFAULT_OPTS` | `--height=60% --layout=reverse ...` | fzf 界面选项 |
| `VIRTUAL_ENV_DISABLE_PROMPT` | `1` | 禁止 Python 虚拟环境修改提示符 |

## 命令替代

本配置使用现代化工具替代传统命令，在命令前加 `\` 即可使用原命令：

| 原命令 | 替代命令 | 优势 |
|--------|----------|------|
| `ls` | `eza` | 彩色输出、图标显示、Git 状态集成、树形视图 |
| `cat` | `bat` | 语法高亮、Git 集成 |
| `vim` | `nvim` | 更可扩展、Lua 配置、性能更好 |
| `pacman` | `smart-pacman` | 自动判断是否需要 sudo |

### 使用示例

```bash
cat file.txt            # 自动使用 bat（语法高亮）
\cat file.txt           # 使用原始 cat 命令

ls                      # 使用 eza（带图标）
\ls                     # 使用原始 ls
```

## 别名

### 文件管理

| 别名 | 实际命令 | 说明 |
|------|----------|------|
| `ls` | `eza --icons=auto` | 彩色列表（仅交互式 Shell） |
| `ll` | `eza -lh --icons=auto --git` | 详细列表（含 Git 状态） |
| `la` | `eza -lah --icons=auto --git` | 详细列表（含隐藏文件） |
| `tree` | `eza --tree --icons=auto` | 树形目录结构（仅交互式 Shell） |
| `cat` | `bat --paging=never --style=plain` | 语法高亮文件查看 |

### 工具替代

| 别名 | 实际命令 | 说明 |
|------|----------|------|
| `rgrep` | `rg --color=auto` | 使用 ripgrep 替代 grep |
| `diff` | `diff --color=auto` | 彩色 diff 输出 |
| `df` | `df -h` | 人类可读磁盘空间 |

### 系统管理

| 别名 | 实际命令 | 说明 |
|------|----------|------|
| `suspend` | `sudo systemctl suspend` | 休眠 |
| `daemon` | `sudo systemctl daemon-reload` | 重载 systemd |
| `rtlog` | `journalctl -f -o short-iso` | 实时日志 |
| `logerr` | `journalctl -p err -b` | 本次启动错误 |
| `logk` | `journalctl -k -f` | 内核实时日志 |

### 包管理

| 别名 | 实际命令 | 说明 |
|------|----------|------|
| `pacman` | `smart-pacman` | 智能 pacman（自动 sudo） |

### Git

| 别名 | 实际命令 | 说明 |
|------|----------|------|
| `glog` | `PAGER="less -F -X" git log` | Git 日志（一屏退出） |
| `gadog` | `PAGER="less -F -X" git log --all --decorate --oneline --graph` | 分支图日志 |

### Python 开发

| 别名 | 实际命令 | 说明 |
|------|----------|------|
| `pi` | `pip install` | 安装包 |
| `pir` | `pip install -r requirements.txt` | 安装依赖 |
| `pfr` | `pip freeze > requirements.txt` | 导出依赖 |
| `pls` | `pip list` | 列出包 |
| `pyserve` | `python -m http.server` | 启动 HTTP 服务器 |

### 杂项

| 别名 | 实际命令 | 说明 |
|------|----------|------|
| `weather` | `curl wttr.in` | 命令行天气 |
| `path` | `echo -e ${PATH//:/\\n}` | 每行显示一个 PATH 路径 |
| `tmux` | `tmux -f "$XDG_CONFIG_HOME"/tmux/tmux.conf` | 使用 XDG 配置的 tmux |
| `-` | `cd -` | 返回上一个目录 |

## 函数

| 函数 | 说明 | 用法 |
|------|------|------|
| `yz` | 启动 Yazi 文件管理器，退出后自动 cd 到最后浏览的目录 | `yz` |
| `venv` | 智能激活 Python 虚拟环境（自动检测 venv/.venv/env） | `venv` |
| `mkva` | 创建并激活 Python 虚拟环境 | `mkva` |
| `dnsreset` | 重置 DNS（通过 nmcli） | `dnsreset [DNS]` |
| `waymount` | 挂载 Waydroid 共享目录 | `waymount` |
| `wayumount` | 卸载 Waydroid 共享目录 | `wayumount` |
| `cleanlog` | 清理 coredump 和 journal 日志 | `cleanlog` |

## 自定义脚本

所有脚本位于 `scripts/bin/`，已自动加入 `PATH`，可直接在终端使用。需确保 `chmod +x`。

## 插件

插件会在首次启动时自动克隆到 `$ZDOTDIR/plugins/`：

| 插件 | 功能 |
|------|------|
| [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) | 实时语法高亮（通过 `themes/secondary_theme.zsh` 自定义配色） |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Fish 风格的命令建议（灰色提示） |
| [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search) | 按输入内容过滤历史记录 |
| [zsh-vi-mode](https://github.com/jeffreytse/zsh-vi-mode) | Vi/Vim 风格的键位绑定 |

### 更新插件

```bash
zplugin-update
```

## 快捷键

### 命令行编辑

| 快捷键 | 功能 | 场景 |
|--------|------|------|
| `Ctrl + →` | 向前跳一个单词 | 快速移动光标 |
| `Ctrl + ←` | 向后跳一个单词 | 快速移动光标 |
| `↑` / `↓` | 按输入内容过滤历史 | 查找历史命令 |
| `Ctrl + \` | 开关自动建议 | 录制屏幕时临时关闭 |

### fzf 搜索

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `Ctrl + F` | 搜索文件（不含隐藏） | 日常使用 |
| `Ctrl + T` | 搜索文件（含隐藏） | 需要查找隐藏文件时 |
| `Ctrl + R` | 搜索历史命令 | 快速找到之前执行的命令 |

### Vi 模式快捷键

按 `ESC` 进入普通模式，使用 Vim 风格键位：

| 模式 | 按键 | 功能 |
|------|------|------|
| 普通 | `h` / `j` / `k` / `l` | 左 / 下 / 上 / 右移动 |
| 普通 | `w` / `b` | 向前 / 向后跳一个单词 |
| 普通 | `0` / `$` | 跳到行首 / 行尾 |
| 普通 | `dd` | 删除整行 |
| 普通 | `dw` | 删除一个单词 |
| 普通 | `u` | 撤销 |
| 普通 | `Ctrl + R` | 重做 |
| 普通 | `i` / `a` | 进入插入模式（光标前 / 后） |
| 普通 | `I` / `A` | 进入插入模式（行首 / 行尾） |
| 普通 | `v` | 进入可视模式 |
| 普通 | `/` | 在命令行中搜索 |

**光标形状指示**：
- 插入模式：竖线 `|`
- 普通模式：方块 `█`
- 可视模式：方块 `█`

## 自定义指南

### 添加新的 init 脚本

按编号放入 `scripts/init/` 即可：

```bash
touch scripts/init/50-myconfig.zsh
chmod +x scripts/init/50-myconfig.zsh
```

编号范围参考：50-59 适合自定义配置，90-99 适合调试/测试。

### 本地覆盖（local.zsh）

`local.zsh` 是 gitignored 的，适合存放每台机器特有的配置：

```bash
touch local.zsh # zshrc 会自动 source 它
```

### 修改插件配置

不要直接修改 `plugins/` 下的文件（会被 git 忽略且更新时覆盖）。在 `00-plugins.zsh` 中设置插件的环境变量，例如：

```bash
# 在 source 之前设置配置变量
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
```

### 切换 Starship 调色板

编辑 `starship.toml`，修改 `palette` 字段：

```toml
palette = 'catppuccin_mocha'    # 可用：mocha, frappe, latte, macchiato
```

## 故障排查

### 插件未自动安装
首次启动时插件自动克隆。如果网络问题导致失败，手动运行：

```bash
cd ~/.config/zsh
source scripts/init/00-plugins.zsh
```

### 补全不工作
检查缓存文件路径是否匹配：

```bash
ls -la $XDG_CACHE_HOME/zsh/zcompdump
# 如不存在，运行：
rm -f $XDG_CACHE_HOME/zsh/zcompdump*
exec zsh
```

### 图标或提示符显示异常
确保安装了 Nerd Font 并在终端设置中启用。Starship 配置使用 Catppuccin Mocha 调色板。

### 更新所有插件

```bash
zplugin-update
```

### 查看所有别名和函数

```bash
alias | bat              # 查看所有别名
alias | grep '^ll'       # 搜索特定别名
functions | bat          # 查看所有函数
functions yz             # 查看特定函数定义
```

### 自定义绑定的 Vi 模式不生效
zsh-vi-mode 插件在初始化时会重置所有绑定。自定义绑定**必须**放在 `zvm_after_init()` 钩子中（在 `30-bindings.zsh` 中已定义此钩子）。

### 首次启动目录创建失败
确保以下目录存在：

```bash
mkdir -p ~/.local/state/zsh
mkdir -p ~/.cache/zsh
chmod +x ~/.config/zsh/scripts/bin/*
```