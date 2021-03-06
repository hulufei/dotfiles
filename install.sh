#!/usr/bin/env bash
DOTFILES=$PWD

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
elif [[ $CURRENT_OS == 'Linux' ]]; then
  [ -e "${DOTFILES}/ubuntu.sh" ] && source "${DOTFILES}/ubuntu.sh"
fi

rm -f ~/.vimrc.orig
mv ~/.vimrc ~/.vimrc.orig
ln -s "$DOTFILES/.vimrc" ~/

rm -f ~/.gvimrc.orig
mv ~/.gvimrc ~/.gvimrc.orig
ln -s "$DOTFILES/.gvimrc" ~/

rm -f ~/.tmux.conf.orig
mv ~/.tmux.conf ~/.tmux.conf.orig
ln -s "$DOTFILES/.tmux.conf" ~/

# Tmux plugins(tpm)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Zsh and Antigen
mkdir -p ~/.antigen
curl -L git.io/antigen > ~/.antigen/antigen.zsh
ln -s "$DOTFILES/.zshrc" ~/
ln -s "$DOTFILES/.zshrc_local" ~/
chsh -s $(which zsh)

# vim-plug
echo "Setup neovim"
echo "Install vim-plug..."
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p ~/.config/nvim
mv ~/.config/nvim/init.vim ~/.config/nvim/init.vim.orig
ln -s "$DOTFILES/init.vim" ~/.config/nvim
nvim +PlugInstall +qall

ln -s "$DOTFILES/coc-settings.json" ~/.config/nvim/
ln -s "$PWD/snippets" ~/.local/share/nvim/plugged/

# mkdir -p ~/.vim/backups
# mkdir -p ~/.vim/swaps
# git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# vim +PluginInstall +qall

# Toolbox
# https://github.com/tldr-pages/tldr
# npm i -g tldr
# tldr --update

# Manually install nvm
# git clone https://github.com/creationix/nvm.git ~/.nvm && cd ~/.nvm && git checkout `git describe --abbrev=0 --tags`
# source nvm.sh
# nvm install stable
# nvm alias default stable

# fasd, install manually: `cd fasd && sudo make install`
# Then `antigen bundle fasd` worked
git clone https://github.com/clvv/fasd.git
cd fasd && sudo make install

# Git
git config --global user.email 'ihulufei@icloud.com'
git config --global user.name 'hulufei'
# Github: generating ssh keys
# http://goo.gl/lyu73
# ssh-keygen -f ~/.ssh/id_rsa -t rsa -C 'ihulufei@icloud.com' -N ''
# start the ssh-agent in the background
# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/id_rsa
# Next: Step 3

