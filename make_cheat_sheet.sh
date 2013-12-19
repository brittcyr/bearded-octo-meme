#!/bin/bash

# Get the site to wget
echo "What is the site with the notes?"
read SITE

mkdir temp_dir
cd temp_dir

# Go to the site with the problem set answers and get them
wget -A.pdf -L -r --random-wait --tries=10 -q -nd $SITE

# Combine all them into one pdf
pdfunite *sol*pdf combined_pdf.pdf

# Convert to postscript format
pdftops combined_pdf.pdf

# Compress so that 15 fit on one page
psnup -15 -q combined_pdf.ps > combined_pdf_compressed.ps 

# Convert to pdf and do not show output to user
touch temp
pstopdf combined_pdf_compressed.ps > temp

# Move the result back to original directory
mv combined_pdf_compressed.ps ../cheat_sheet.pdf
cd ..

# Cleanup temp files
rm -rf temp_dir

# Ask if user wants to print
read -p "Want to print? (y/n) " RESP
if [ "$RESP" = "y" ]; then
    echo "Printing double sided with lpr"
    lpr cheat_sheet.pdf sides=two-sided-long-edge
else
    echo "Your cheat sheet is cheat_sheet.pdf"
fi
