#!/bin/bash
ls -l | awk '{if($NF~/^[b]/) print $NF}' | while read frqcase
do
  echo ${frqcase}
  xmlname="${frqcase}/airfoilc.xml"
  evlname="${frqcase}/airfoil.evl"
  cat ${xmlname} | awk '{if($2=="beta") print $4}' 
  cat ${evlname} | awk '{if($7<1E-4 && $1=="EV:") print $0}'
done
