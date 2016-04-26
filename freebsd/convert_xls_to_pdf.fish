#!/usr/local/bin/fish

################################################################################
# Author: Andy Nagels
# Date: 2016-04-26
#
# convert_xls_to_pdf.fish:
# Script that uses libreoffice in headless mode,
# to convert all xls files in the current directory, to pdf.
################################################################################

echo "Have you set the xls page settings to landscape?"
echo "This can not be done automatically (yet)..."

set FILES (ls *.xls)
for zFile in $FILES
    echo "Converting $zFile to pdf..."
    libreoffice --headless --convert-to pdf $zFile
end
echo "Done."

echo "Please remove the xls files manually..."
