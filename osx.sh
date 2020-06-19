# Fix brew install neovim without python3 provider
sudo pip3 install neovim --upgrade

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

binaries=(
  trash
  the_silver_searcher
  homebrew/cask-cask
  tig
  tmux
  node
)

echo "installing binaries..."
brew install ${binaries[@]}
brew cleanup

# brew cask
brew tap homebrew/cask-fonts
brew cask install font-fira-cod

apps=(
  alfred
  dropbox
  iterm2
  rectangle
  google-chrome
  firefox
  # appcleaner
  # vlc
)
# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}
