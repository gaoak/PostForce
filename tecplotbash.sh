export layoutfile=`pwd`/$1
export pngfilename=`pwd`/$2
echo "$layoutfile"
echo "${pngfilename}"
if test -f ${pngfilename}; then
    echo "file ${pngfilename} already exists" | tee -a plotlog
else
    tec360 -b -p /home/gaoak/testcode/PostForce/plot.mcr --osmesa
fi
