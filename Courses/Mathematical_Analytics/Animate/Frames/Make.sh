#!/bin/bash
for i in {0..145}; do pdflatex FakeFrame$i.tex; done
rm *.tex *.eps *.aux *.log *to.pdf
