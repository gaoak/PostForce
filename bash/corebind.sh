#!/bin/bash
jobi=0
for((DC=4;DC<=16;DC+=2))
do
for K in 10 30
do
    filename=K${K}DC${DC}
    if test -d $filename ; then
        echo $filename, ' already exist'
        continue
    else
        mkdir $filename
    fi
    
    cd $filename
      echo processing $filename
      cp ../../template/* .
      sed -i '20d' inFlow.dat
      sed -i -e "20i\ ${DC}.000D-1                           read(111,*)     DC" inFlow.dat
      sed -i '39d' inFlow.dat
      sed -i -e "39i\ ${K}.00d+0   1.000d+3                read(111,*)     (KB, KS)/(ERatio,tcR)" inFlow.dat
      sed -i '45d' inFlow.dat
      sed -i -e "45i\ ${K}.00d+0   1.000d+3                read(111,*)     (KB, KS)/(ERatio,tcR)" inFlow.dat
      echo "start running ${filename}"
      diff inFlow.dat ../../template/
      bash clean.sh
      cs=$((jobi*8))
      ce=$((jobi*8+7))
      taskset -c ${cs}-${ce} bash ./run.sh &
      jobi=$((jobi+1))
    cd ..
done
done
