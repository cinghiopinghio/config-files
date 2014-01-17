"user filetype file
if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect

au! BufNewFile,BufRead *.plot,*.gnuplot,*.plt setf gnuplot
au! BufNewFile,BufRead *.m,*.mat setf matlab
au! BufNewFile,BufRead *.tex setf tex
au! BufNewFile,BufRead *.oct,*.octave setf octave
au! BufNewFile,BufRead *.markdown,*.mdown,*.md,README.md setf markdown
au! BufNewFile,BufRead alot.*,mutt* setf mail

augroup END
 
