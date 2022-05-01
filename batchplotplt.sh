#!/bin/bash
count=1
echo '${date +"%c"}' | tee plotlog
ls -l ./ | awk '{if($NF~/.plt/) print $NF}' | while read frqcase
do
  filename="${frqcase}"
  echo processing file $count: $filename ${filename%.plt}.png
  sed -i '2d' plot.lay
  sed -i -e "2i\$!VarSet |LFDSFN1| = \'\"${filename}\"\'"   plot.lay
  tecplotbash.sh plot.lay ${filename%.plt}.png
  count=$((count+1))
done
