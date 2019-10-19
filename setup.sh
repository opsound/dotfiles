# vim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

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
fi
ln -s ~/dotfiles/.config/nvim ~/.config/nvim
