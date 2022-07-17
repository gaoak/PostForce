for num in 0.5 1
do
  if [ ! -d K${num} ]; then
    cp -r template K${num}
    cd K${num}
    sed -i '32d' inFlow.dat
    sed -i -e "32i\ ${num}d+0   1.000d+3                 read(111,*)     (KB, KS)/(ERatio,tcR)" inFlow.dat
    bash cleanfiles.sh
    qsub job.pbs
    cd ..
  fi
done
