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
  node
  tree
  the_silver_searcher
  hub
  git
)

echo "installing binaries..."
brew install ${binaries[@]}
brew cleanup

# brew cask
brew install caskroom/cask/brew-cask

apps=(
  dropbox
  google-chrome
  firefox
  appcleaner
  vlc
)
# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}