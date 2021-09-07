#! /bin/bash

cp _vimrc ~/.vimrc
cp _screenrc ~/.screenrc
cp _gitconfig ~/.gitconfig
cp _git-completion.bash ~/.git-completion.bash

mkdir -p ~/.vim/plugin
cp _vim/plugin/* ~/.vim/plugin

if [ -z "`grep '\.git-completion\.bash' ~/.bashrc`" ]; then
cat >> ~/.bashrc <<EOF

# Add git completion script
if [ -f ~/.git-completion.bash ]; then 
  . ~/.git-completion.bash 
fi 
EOF
fi
