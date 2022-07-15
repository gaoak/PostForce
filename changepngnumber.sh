#!/bin/bash
count=1
echo '${date +"%c"}' | tee plotlog
ls -l ./ | awk '{if($NF~/.png/) print $NF}' | while read frqcase
do
  filename="${frqcase}"
  echo processing file $count: $filename ${filename%.png}.png
  if [ ${#${filename%.png}} -lt 2 ];
  then
    mv ${filename} 00${filename}
  fi
  if [ ${#${filename%.png}} -lt 3 ];
  then
    mv ${filename} 0${filename}
  fi
done
