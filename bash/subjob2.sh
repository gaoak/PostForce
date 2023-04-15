#!/bin/bash
for((DC=0;DC<20;++DC))
do
for K in 10 30
do
    filename=K${K}DC${DC}
    if test -d $filename ; then
      cd $filename
      echo processing $filename
      cp ../../template/* .
      sed -i '20d' inFlow.dat
      sed -i -e "20i\ ${DC}.000D-1                           read(111,*)     DC" inFlow.dat
      sed -i '39d' inFlow.dat
      sed -i -e "39i\ ${K}.00d+0   1.000d+3                read(111,*)     (KB, KS)/(ERatio,tcR)" inFlow.dat
      sed -i '45d' inFlow.dat
      sed -i -e "45i\ ${K}.00d+0   1.000d+3                read(111,*)     (KB, KS)/(ERatio,tcR)" inFlow.dat
      if [ ! -d DatFlow ]; then
        echo "start running ${filename}"
        diff inFlow.dat ../../template/
        bash clean.sh
        bash run.sh
        sleep 1h
      fi
      cd ..
    fi
done
done
