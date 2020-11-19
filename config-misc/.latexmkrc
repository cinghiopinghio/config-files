## latexmk options

$dvips_pdf_switch='';
#output is pdf through ps2pdf
# $pdf_mode=2;

#use this pdf previewer
$pdf_previewer="start zathura %O %S";

#try to continue compiling if there is some minor error
$force_mode=1;

#use shell escape
$latex = 'latex --shell-escape %O %S';
$pdflatex = 'pdflatex --shell-escape %O %S';
