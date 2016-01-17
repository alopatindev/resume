#!/bin/bash
#
# optpdf file.pdf
#   This script will attempt to optimize the given pdf
#   Looped version of https://tex.stackexchange.com/questions/18987/how-to-make-the-pdfs-produced-by-pdflatex-smaller/199150#199150
#   and merged with http://www.alfredklomp.com/programming/shrinkpdf/

file=$1
filebase=$(basename $file .pdf)
optfile=/tmp/$$-${filebase}_opt.pdf

while :
do
    gs \
      -q -dNOPAUSE -dBATCH -dSAFER         \
      -sDEVICE=pdfwrite                    \
      -dCompatibilityLevel=1.3             \
      -dPDFSETTINGS=/screen                \
      -dEmbedAllFonts=true                 \
      -dSubsetFonts=true                   \
      -dColorImageDownsampleType=/Bicubic  \
      -dColorImageResolution=72            \
      -dGrayImageDownsampleType=/Bicubic   \
      -dGrayImageResolution=72             \
      -dMonoImageDownsampleType=/Bicubic   \
      -dMonoImageResolution=72             \
      -sOutputFile=${optfile} ${file}

    if [ $? == '0' ]; then
        optsize=$(stat -c "%s" ${optfile})
        orgsize=$(stat -c "%s" ${file})
        if [ "${optsize}" -eq 0 ]; then
            echo "No output!  Keeping original"
            rm -f ${optfile}
            break;
        fi
        if [ ${optsize} -ge ${orgsize} ]; then
            echo "Didn't make it smaller! Keeping original"
            rm -f ${optfile}
            break;
        fi
        bytesSaved=$(expr $orgsize - $optsize)
        percent=$(expr $optsize '*' 100 / $orgsize)
        echo Saving $bytesSaved bytes \(now ${percent}% of old\)
        rm ${file}
        mv ${optfile} ${file}
    fi
done
