#!/bin/sh

################################################################################
# Author: Andy Nagels
# Date: 2015-03-04
#
# fullcompile.sh:
# Compiles a latex document, twice.
# Note: the parameter should be the name of the document, without the extension!
################################################################################

pdflatex --shell-escape $1.tex
pdflatex --shell-escape $1.tex
#dvips -Ppdf -G0 $1.dvi -o $1.ps 
##G0: bug in Ghostscript ontwijken
#ps2pdf -dPDFsettings=/prepress $1.ps $1.pdf
##dPDFsettings=/.. => eps geen kwaliteitsverlies bij omzetting naar pdf
