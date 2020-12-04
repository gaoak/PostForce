for((n=0;n<=6;++n))
do
sed -i '2d' evolution.lay
sed -i -e "2i\$!VarSet |LFDSFN1| = \'\"${n}.plt\"\'"   evolution.lay
sed -i '3d' plot.mcr
sed -i -e "3i\$!VarSet |FILEN| = \'${n}\'"   plot.mcr
tec360 -b -p plot.mcr 
done
