#! /bin/bash

# vim
cp _vimrc ~/.vimrc

mkdir -p ~/.vim
cp -rf _vim/* ~/.vim/

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
echo "Installation aborted."
fi
fi
