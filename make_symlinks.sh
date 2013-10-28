#!/bin/bash

shopt -s dotglob

DIR=/home/irri/.dotfiles

mkdir -p ~/dotfiles_old

cd $DIR
for i in *
do
    if [[ "$i" != "make_symlinks.sh" && "$i" != ".git" ]]
    then
        #echo "$i"
        mv ~/$i ~/dotfiles_old/
        ln -s $DIR/$i ~/$i
    fi
done
