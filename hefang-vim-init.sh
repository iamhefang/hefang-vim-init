#!/bin/bash

command -v vim >/dev/null 2>&1 || { echo >&2 "未发现vim, 请先安装vim"; exit 1; }
command -v git >/dev/null 2>&1 || { echo >&2 "未发现git, 请先安装git"; exit 1; }

if [ -e ~/.vimrc ]; then
	mv ~/.vimrc ~/.vimrc.bak
	echo '正在备份已存在的.vimrc文件'
fi

if [ -e ~/.vim ]; then
	mv ~/.vim ~/.vim.bak
	echo '正在备份已存在的.vim目录'
fi

echo '正在安装插件管理器 Plug'

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo '正在新建配置文件'

echo "
call plug#begin('~/.vim/plugins')
Plug 'junegunn/vim-easy-align'
\"状态栏
Plug 'vim-airline/vim-airline'
\"状态栏主题管理器
Plug 'vim-airline/vim-airline-themes'
\"主题管理器
Plug 'flazz/vim-colorschemes'
\"文件树
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()
" > ~/.vimrc

echo "

正在安装插件,当前插件安装目录为${HOME}/.vim/plugins 
请先不要操作vim
安装完成后会自动操作下一步操作

何方博客 https://hefang.link
" > ~/.vim/README
vim +PlugInstall +qall +set\ nu -R ~/.vim/README

echo "
\"更改主题
colorscheme molokai
\"显示行号
set nu
\"启用鼠标
set mouse=a
\"代码折叠
set foldenable
set fdm=indent
\"设置缩进
set ts=4
set sw=4
\"set expandtab
set smartindent
\"在插入模式下启动backspace键
set backspace=2

\"vim启动时自动打开文件树
autocmd vimenter * NERDTree
\"关闭正在编辑的文件时不保留文件树
autocmd bufenter * if (winnr(\"$\") == 1 && exists(\"b:NERDTree\") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
" >> ~/.vimrc

echo "
vim 已初始化完成
左侧为文件树,用回车键或鼠标双击可以打开目录和文件

配置文件为${HOME}/.vimrc
您可以自行编辑配置文件进行自定义配置

何方博客: https://hefang.link
" > ~/.vim/README

cd ~/

vim -R ~/.vim/README
