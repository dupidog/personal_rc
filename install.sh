#! /bin/bash

# vim version
VIM_VERSION=`vim --version | grep -o "[0-9]\.[0-9]" | head -1 | cut -c 1`

# vim
cp _vimrc ~/.vimrc

mkdir -p ~/.vim
cp -rf _vim/* ~/.vim/

if [ "$VIM_VERSION" -ge "8" ]; then
cp -rf _vim8/* ~/.vim/
fi

# screen
cp _screenrc ~/.screenrc

# git
GIT_USER_NAME=`git config --global user.name`
GIT_USER_EMAIL=`git config --global user.email`

cp _gitconfig ~/.gitconfig

if [ ! -z "$GIT_USER_NAME" ]; then
git config --global user.name "$GIT_USER_NAME"
fi
if [ ! -z "$GIT_USER_EMAIL" ]; then
git config --global user.email "$GIT_USER_EMAIL"
fi

cp _git-completion.bash ~/.git-completion.bash

if [ -z "`grep '\.git-completion\.bash' ~/.bashrc`" ]; then
cat >> ~/.bashrc <<EOF

# Add git completion script
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
EOF
fi

# Ingore X server check for vim
if [ -z "`grep 'vim -X' ~/.bashrc`" ]; then
cat >> ~/.bashrc <<EOF

# Ingore X server check for vim
alias vim='vim -X'
EOF
fi

# bash-completion
BASH_COMPLETION_INSTALLED=`apt list bash-completion 2>/dev/null | grep -o 'installed'`
if [ -z "$BASH_COMPLETION_INSTALLED" ]; then
read -p "Package bash-completion not installed, install it? [y/N] " PROMPT
if [ "$PROMPT" = "y" -o "$PROMPT" = "Y" ]; then
sudo apt-get install bash-completion -y
if [ $? -ne 0 ]; then
echo "Installation failed, check source and run 'apt-get update'"
elif [ -z "`grep '/etc/bash_completion' ~/.bashrc`" ]; then
cat >> ~/.bashrc <<EOF

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
EOF
fi
else
echo "Package bash-completion installation skipped."
fi
fi

# vim-gutentags
if [ "$VIM_VERSION" -ge "8" ]; then
GTAGS_INSTALLED=`apt list global 2>/dev/null | grep -o 'installed'`
CTAGS_INSTALLED=`apt list exuberant-ctags 2>/dev/null | grep -o 'installed'`
if [ -z "$GTAGS_INSTALLED" -o -z "$CTAGS_INSTALLED" ]; then
read -p "Package ctags/gtags not installed, install it? [y/N] " PROMPT
if [ "$PROMPT" = "y" -o "$PROMPT" = "Y" ]; then
sudo apt-get install exuberant-ctags global -y
if [ $? -ne 0 ]; then
echo "Installation failed, check source and run 'apt-get update'"
fi
else
echo "Package ctags/gtags installation skipped."
fi
fi
else
echo "Vim version is lower than 8, vim-gutentags installation skipped."
fi
