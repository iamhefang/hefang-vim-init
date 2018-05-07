#!/bin/bash
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

echo '正在安装插件'
vim +PlugInstall +qall

echo "
\"更改主题
colorscheme molokai

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

	何方博客: https://hefang.link

" > ~/.vim/README

cd ~/

vim -R ~/.vim/README
