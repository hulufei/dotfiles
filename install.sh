#!/usr/bin/env bash
DOTFILES=$PWD

rm -f ~/.vimrc.orig
mv ~/.vimrc ~/.vimrc.orig
ln -s "$DOTFILES/.vimrc" ~/

rm -f ~/.gvimrc.orig
mv ~/.gvimrc ~/.gvimrc.orig
ln -s "$DOTFILES/.gvimrc" ~/

rm -f ~/.tmux.conf.orig
mv ~/.tmux.conf ~/.tmux.conf.orig
ln -s "$DOTFILES/.tmux.conf" ~/

mkdir -p ~/.vim/backups
mkdir -p ~/.vim/swaps
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Manually install nvm
git clone https://github.com/creationix/nvm.git ~/.nvm && cd ~/.nvm && git checkout `git describe --abbrev=0 --tags`
source nvm.sh
nvm install stable
nvm alias default stable

# Zsh and Antigen
ln -s "$DOTFILES/antigen" ~/.antigen
ln -s "$DOTFILES/.zshrc" ~/
ln -s "$DOTFILES/.zshrc_local" ~/
chsh -s $(which zsh)

# OS Detection

UNAME=`uname`

# Fallback info
CURRENT_OS='Linux'
DISTRO=''

if [[ $UNAME == 'Darwin' ]]; then
  CURRENT_OS='OS X'
else
  # Must be Linux, determine distro
  if [[ -f /etc/redhat-release ]]; then
    # CentOS or Redhat?
    if grep -q "CentOS" /etc/redhat-release; then
      DISTRO='CentOS'
    else
      DISTRO='RHEL'
    fi
  fi
fi

if [[ $CURRENT_OS == 'OS X' ]]; then
  [ -e "${DOTFILES}/osx.sh" ] && source "${DOTFILES}/osx.sh"
# elif [[ $CURRENT_OS == 'Linux' ]]; then
#   # None so far...
#
#   if [[ $DISTRO == 'CentOS' ]]; then
#     # None so far...
#   fi
fi
