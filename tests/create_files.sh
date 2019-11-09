## define end value ##
END=50
x=$END
while [ $x -gt 0 ];
do
  echo hello > "File${x}.txt"
  x=$(($x-1))
done
