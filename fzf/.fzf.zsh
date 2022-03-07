# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$(brew --prefix)/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"

# fzf
export FZF_DEFAULT_COMMAND="fd --hidden --follow -I --exclude={Pods,.DS_Store,.git,.idea,.sass-cache,node_modules,build,Music,Movies} --type f"
export FZF_DEFAULT_OPTS="
--color=dark
--color=fg:#707a8c,bg:-1,hl:#3e9831,fg+:#cbccc6,bg+:#434c5e,hl+:#5fff87
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
--height 60%
--layout reverse
--preview-window 'hidden:right:60%'
--preview '(highlight -O ansi -l {} 2> /dev/null || bat --color=always --style=numbers --line-range=:500 {} || tree -N -C {}) 2> /dev/null | head -500'
--bind ',:toggle-preview,ctrl-j:preview-up,ctrl-k:preview-down,ctrl-b:preview-page-up,ctrl-f:preview-page-down,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' 
--border
--cycle
"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_T_OPTS=$FZF_DEFAULT_OPTS
export FZF_CTRL_R_OPTS="
--layout=reverse
--sort
--exact
--preview 'echo {}'
--preview-window down:3:hidden:wrap
--bind ',:toggle-preview'
--border
--cycle
"
export FZF_ALT_C_OPTS="--preview 'tree -N -C {} | head -500'"
export FZF_TMUX_OPTS="-d 60%"
export FZF_COMPLETION_TRIGGER='**'

####
fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept

####
j() {
    if [[ "$#" -ne 0 ]]; then
        cd $(autojump $@)
        return
    fi
    cd "$(autojump -s | sort -k1gr | awk '$1 ~ /[0-9]:/ && $2 ~ /^\// { for (i=2; i<=NF; i++) { print $(i) } }' |  fzf --height 40% --reverse --inline-info)" 
}
