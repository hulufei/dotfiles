[ -e "${HOME}/.zshrc_local" ] && source "${HOME}/.zshrc_local"

# Enable vi mode shortcuts(ESC to start)
# set -o vi

#source $HOME/.nvm/nvm.sh
source $HOME/.antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle common-aliases
antigen bundle git
# alias npmD = 'npm i -D'
# alias npmS = 'npm i -S'
antigen bundle npm
antigen bundle akoenig/npm-run.plugin.zsh
# aliases: h for history, hsi for grepping history
antigen bundle history
# Run `vundle` `vundle-clean` immediately etc
antigen bundle vundle
antigen bundle tmux
antigen bundle tmuxinator
antigen bundle fasd
# antigen bundle nojhan/liquidprompt
antigen bundle tarruda/zsh-autosuggestions
antigen bundle Tarrasch/zsh-autoenv
antigen bundle taskwarrior

# Enable autosuggestions automatically.
zle-line-init() {
  # zle autosuggest-start
}
zle -N zle-line-init

# antigen theme ys

antigen apply

export PATH="/usr/local/sbin:$PATH"
export TIMEWARRIORDB="~/Dropbox/timewarrior"
export TASKDATA="~/Dropbox/task"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag -g ""'

eval "$(starship init zsh)"
