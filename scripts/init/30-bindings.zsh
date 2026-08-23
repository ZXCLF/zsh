# ============================================================
#  按键绑定配置
# ============================================================

# ---------- 根据 Vi 模式切换光标形状 ----------
# 插入模式：使用竖线光标（便于输入）
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
# 普通模式：使用方块光标（更醒目）
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
# 可视模式：使用方块光标
ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK

# ---------- 禁用 Vi 模式下的命令行高亮 ----------
# 关闭 zsh-vi-mode 插件的背景高亮（保持简洁外观）
ZVM_VI_HIGHLIGHT_BACKGROUND=none
ZVM_VI_HIGHLIGHT_FOREGROUND=none
ZVM_VI_HIGHLIGHT_EXTRASTYLE=none

# ---------- 自定义按键绑定（在 Vi 模式初始化后执行） ----------
# zsh-vi-mode 插件在启动时会重置所有绑定，
# 因此必须通过这个钩子函数来注册自定义绑定，确保它们生效。
zvm_after_init() {
  # Ctrl + →（右箭头）：向前跳一个单词
  bindkey '^[[1;5C' forward-word

  # Ctrl + ←（左箭头）：向后跳一个单词
  bindkey '^[[1;5D' backward-word

  # Ctrl + F ：打开 fzf 文件选择器（不显示隐藏文件）
  bindkey '^F' _fzf_file_no_hidden

  # Ctrl + \（反斜杠）：切换自动建议的开关
  bindkey '^\' autosuggest-toggle

  # ↑（上箭头）：按输入的子串搜索历史（向上翻找）
  bindkey '^[[A' history-substring-search-up

  # ↓（下箭头）：按输入的子串搜索历史（向下翻找）
  bindkey '^[[B' history-substring-search-down

  # Ctrl + L：清屏
  bindkey '^L' clear-screen
}
