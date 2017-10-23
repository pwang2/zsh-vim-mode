# Updates editor information when the keymap changes.
function zle-keymap-select() {
  zle reset-prompt
  zle -R

  if [ "$TERM" = "xterm-256color" ]; then
      if [ $KEYMAP = vicmd ]; then
          # the command mode for vi
          echo -ne "\e[2 q"
      else
          # the insert mode for vi
          echo -ne "\e[5 q"
      fi
  fi
}

zle-line-init () {
    echo -ne "\e[5 q"
}

zle-line-finish () {
    echo -ne "\e[2 q"
}

# Ensure that the prompt is redrawn when the terminal size changes.
TRAPWINCH() {
  zle &&  zle -R
}

zle -N zle-keymap-select
zle -N edit-command-line

autoload -Uz edit-command-line

bindkey -v
bindkey '^f' vi-forward-word

# allow v to edit the command line (standard behaviour)
bindkey -M vicmd 'v' edit-command-line

# allow ctrl-p, ctrl-n for navigate history (standard behaviour)
bindkey '^P' up-history
bindkey '^N' down-history

# allow ctrl-h, ctrl-w, ctrl-? for char and word deletion (standard behaviour)
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

# allow ctrl-r to perform backward search in history
bindkey '^r' history-incremental-search-backward

# allow ctrl-a and ctrl-e to move to beginning/end of line
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

