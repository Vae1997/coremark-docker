#!/bin/sh
TotalScore=0
ITERATIONS=130000
TestCount=20
echo "TestCount:$TestCount,ITERATIONS:$ITERATIONS"
#for((num = 0; num < 20; num++)),c type of for is not suit in alpine
for num in $(seq 1 20)
do
    file='r'$num'.log'
    # echo $file
    ../coremark.exe  0x0 0x0 0x66 130000 7 1 2000 > ./$file
    echo "$file got score is: $(cat $file | awk 'NR==5 {print $3}')"
    TotalScore=$(echo "$TotalScore+$(cat $file | awk 'NR==5 {print $3}')"|bc)
done
# echo $TotalScore
echo "AVRScore is:$(awk 'BEGIN{printf "%.6f\n",'$TotalScore'/'$num'}')"
