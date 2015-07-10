#!/usr/bin/env bash
rm -f ~/.vimrc.orig
mv ~/.vimrc ~/.vimrc.orig
ln -s "$PWD/.vimrc" ~/

rm -f ~/.gvimrc.orig
mv ~/.gvimrc ~/.gvimrc.orig
ln -s "$PWD/.gvimrc" ~/

rm -f ~/.tmux.conf.orig
mv ~/.tmux.conf ~/.tmux.conf.orig
ln -s "$PWD/.tmux.conf" ~/

mkdir -p ~/.vim/backups
mkdir -p ~/.vim/swaps
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Zsh and Antigen
ln -s "$PWD/antigen" ~/.antigen
ln -s "$PWD/.zshrc" ~/
ln -s "$PWD/.zshrc_local" ~/
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
  [ -e "${PWD}/osx.sh" ] && source "${PWD}/osx.sh"
# elif [[ $CURRENT_OS == 'Linux' ]]; then
#   # None so far...
#
#   if [[ $DISTRO == 'CentOS' ]]; then
#     # None so far...
#   fi
fi

