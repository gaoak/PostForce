for((n=50;n<=64;++n))
do
sed -i '2d' layout.lay
sed -i -e "2i\$!VarSet |LFDSFN1| = \'\"sdata${n}.plt\"\'"   layout.lay
sed -i '4d' layout.lay
sed -i -e "4i\$!VarSet |LFDSFN2| = \'\"coresdata${n}.dat\"\'"   layout.lay
sed -i '3d' plot.mcr
sed -i -e "3i\$!VarSet |FILEN| = \'${n}\'"   plot.mcr
tec360 -b -p plot.mcr 
done
