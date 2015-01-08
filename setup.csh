#!/bin/csh -f
set verbose

cd ~
rm -rf .subversion .cshrc .emacs .ssh .Xdefaults
ln -s repos/emacs/.cshrc
ln -s repos/emacs/.gitconfig
ln -s repos/emacs/.Xdefaults
ln -s repos/emacs/.subversion
ln -s repos/emacs/dotemacs .emacs
