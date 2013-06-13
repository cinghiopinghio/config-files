"user filetype file
if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect

au! BufNewFile,BufRead *.plot,*.gnuplot,*.plt setf gnuplot
au! BufNewFile,BufRead *.m,*.mat setf matlab
au! BufNewFile,BufRead *.oct,*.octave setf octave

augroup END
 
