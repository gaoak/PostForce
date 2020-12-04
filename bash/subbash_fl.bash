#!/bin/bash
  for((lz=24;lz<=24;))
  do
    njob=$(qstat -u agao1 | grep agao1  | wc -l)
    if [ $njob -eq 16 ]; then
      echo "job queue full, exit 1"
      exit 1
    fi
      dirname="lz${lz}_floq"
      if [ ! -d "${dirname}" ]; then
        mkdir ${dirname}
        cd ${dirname}
        cp ../tempfl/* ./
        sed -i '30d' airfoilc.xml
        sed -i -e "30i\            <P> LZ            = ${lz}/10. </P>"  airfoilc.xml
      else
        cd ${dirname}
      fi
      if [ ! -f "solver_out.txt" ]; then
        head -30 airfoilc.xml | tail -1
        head -32 airfoilc.xml | tail -1
        qsub job.pbs
      fi
      lz=$(( $lz + 5 ))
      cd ../
  done
