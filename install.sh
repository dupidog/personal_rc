#! /bin/bash

# vim
cp _vimrc ~/.vimrc

mkdir -p ~/.vim/plugin
cp _vim/plugin/* ~/.vim/plugin

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

