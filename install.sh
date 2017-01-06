# sudo -s ./install.sh
ln -vnfs `pwd`/.bashrc ~/.bashrc
ln -vnfs `pwd`/.ctags ~/.ctags
ln -vnfs `pwd`/.gitignore_global ~/.gitignore_global
ln -vnfs `pwd`/.tmux.conf ~/buoby/.tmux.conf
ln -vnfs `pwd`/.vimrc ~/.vimrc
apt-get install curl
./powerline-install
