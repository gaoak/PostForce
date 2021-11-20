export layoutfile=`pwd`/$1
export pngfilename=`pwd`/$2
echo "$layoutfile"
echo "${pngfilename}"
if test -f ${pngfilename}.png; then
    echo "file ${pngfilename}.png already exists" | tee -a plotlog
else
    tec360 -b -p /home/agao/testcode/PostForce/plot.mcr
fi
