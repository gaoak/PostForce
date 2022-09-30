#!/bin/bash
count=1
echo '${date +"%c"}' | tee plotlog
ls -l ./ | awk '{if($NF~/.png/) print $NF}' | while read frqcase
do
  filename="${frqcase}"
  number=${filename%.png}
  echo processing file $count: $filename ${number}
  if [ ${#number} -lt 2 ];
  then
    mv ${filename} 00${filename}
  fi
  if [ ${#number} -lt 3 ];
  then
    mv ${filename} 0${filename}
  fi
done
