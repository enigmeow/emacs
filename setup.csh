#!/bin/csh -f
set verbose

cd ~
rm -rf .subversion .cshrc .emacs .ssh .Xdefaults
ln -s repos/emacs/jsiegel/.cshrc
ln -s repos/emacs/jsiegel/.Xdefaults
ln -s repos/emacs/jsiegel/.subversion
ln -s repos/emacs/jsiegel/dotemacs .emacs
mkdir .ssh
cp ~/repos/emacs/jsiegel/ssh_config .ssh/config
cp ~/repos/emacs/jsiegel/id_dsa.pub .ssh/authorized_keys
cp ~/repos/emacs/jsiegel/id_dsa.pub .ssh
chmod 700 ~/.ssh
