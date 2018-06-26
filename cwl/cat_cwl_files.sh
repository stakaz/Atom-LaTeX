#!/bin/bash

# leave_out_array=(
# )

cwl_array=( 
latex-document
tex
multicol
# graphicx
# scrdate
# supertabular
# rotating
class-beamer
# esint
# multido
# beamertexpower
# mdwlist
# pst-plot
# latex-l2tabu
# beamerfoils
fontspec
subfig
# setspace
# glosstex
# acronym
# siunitx
# babel
listings
# pst-eps
# amsopn
latex-dev
# afterpage
csquotes
cleveref
# nicefrac
# siunitx-special
# scrlfile
# cancel
mathtools
# etoolbox
# fancyunits_medium-fractions
longtable
fancyhdr
# soul
pdfpages
# svninfo
logsys
tabularx
# virginialake
import
# pst-tree
ifthen
# cyrillic
enumerate
# class-scrlttr2
# coordsys
# doi
color
# fancyunits-base
# luacode
# units
# beamerseminar
url
# pst-coil
# braket
# jurabib
# ifplatform
scraddr
# xtab
biblatex
fancyref
layout
amsmath
# varioref
# attachfile
# fancybox
# fancyunits_big-fractions
# xifthen
# minted
# latex-209
# context-document
nomencl
# beamerprosper
colortbl
# scrtime
hyperref
calc
# yfonts
amsthm
# bm
# pst-char
# class-letter
# pst-text
latex-mathsymbols
amssymb
# fancyunits-np
# scrpage2
# pstricks
# fancyunits_small-fractions
# pst-blur
# psfrag
# csquotes-dev
# pst-3d
amsfonts
# diagxy
# biblatex-dev
# manyfoot
# pst-node
# todonotes
# xltxtra
# array
# gauss
# float
# booktabs
# fancyvrb
# verse
# svn-multi
# currvita
# fancyunits-per
# lscape
# textcomp
# amsbsy
# pst-fill
# allrunes
"class-scrartcl,scrreprt,scrbook"
# fastex
# example
# kile-abbrevs
)

cwl_out="test.cwl"
cwl_dir="./complete/tex/"

echo "" > $cwl_out

for i in "${cwl_array[@]}"
do
filename="${cwl_dir}$i.cwl"
	echo $filename
	cat "${filename}" >> $cwl_out
done

# while read p; do
#   echo $p
# done < $cwl_out
