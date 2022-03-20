vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200}) 
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd = 
  augroup end

  autocmd VimEnter,VimResume * set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175

  autocmd FileType alpha set laststatus=0 | set noruler
  autocmd BufUnload <buffer> set laststatus=3 | set ruler

  autocmd VimLeave,VimSuspend * set guicursor=a:hor20-blinkon215

  autocmd BufWritePost ~/.local/share/chezmoi/* silent !chezmoi apply --source-path "%"
]])
