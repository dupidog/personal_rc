#! /bin/bash

cp _vimrc ~/.vimrc
cp _screenrc ~/.screenrc
cp _gitconfig ~/.gitconfig

mkdir -p ~/.vim/plugin
cp _vim/plugin/* ~/.vim/plugin
