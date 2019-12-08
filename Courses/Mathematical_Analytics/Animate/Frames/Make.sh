#!/bin/bash
for i in {0..20}; do pdflatex Frame$i.tex; done
rm *.tex *.eps *.aux *.log *to.pdf
