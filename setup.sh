#!/usr/bin/env bash

# .vimrc
if [ -f ~/.vimrc ]; then
  mv ~/.vimrc{,.bak}
fi
ln -s ~/dotfiles/.vimrc ~/.vimrc

# .tmux.conf
if [ -f ~/.tmux.conf ]; then
  mv ~/.tmux.conf{,.bak}
fi
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf

# neovim
if [ -d ~/.config/nvim ]; then
  mv ~/.config/nvim{,.bak}
else
  mkdir -p ~/.config
fi
ln -s ~/dotfiles/.config/nvim ~/.config/nvim
