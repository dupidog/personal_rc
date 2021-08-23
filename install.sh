#! /bin/bash

cp _vimrc ~/.vimrc
cp _screenrc ~/.screenrc

mkdir -p ~/.vim/plugin
cp _vim/plugin/* ~/.vim/plugin
