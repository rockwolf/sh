#!/bin/sh
latex $1.tex
latex $1.tex
dvips -Ppdf -G0 $1.dvi -o $1.ps 
##G0: bug in Ghostscript ontwijken
ps2pdf -dPDFsettings=/prepress $1.ps $1.pdf
##dPDFsettings=/.. => eps geen kwaliteitsverlies bij omzetting naar pdf
