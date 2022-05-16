augroup dbui
  autocmd!
  autocmd BufRead,BufNewFile *.dbout set filetype=dbout
  autocmd BufReadPost *.dbout nested call db_ui#save_dbout(expand('<afile>'))
  autocmd FileType dbout,dbui autocmd BufEnter,WinEnter <buffer> stopinsert
augroup END
