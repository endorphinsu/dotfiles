if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin()

Plug 'vim-airline/vim-airline'

Plug 'dense-analysis/ale'

Plug 'SirVer/ultisnips'

Plug 'honza/vim-snippets'

Plug 'dylanaraps/wal.vim'

Plug 'tpope/vim-commentary'

call plug#end()

" Yank is "+y

set viminfo='10,\"100,:20,%,n~/.config/nvim/nviminfo

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
   endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

colorscheme wal

set background=dark

set nohlsearch
set hidden
set ignorecase
set nobackup

" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufRead,BufNewFile xresources,xdefaults set filetype=xdefaults
autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb %

autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e
autocmd BufWritePre *.[ch] %s/\%$/\r/e
