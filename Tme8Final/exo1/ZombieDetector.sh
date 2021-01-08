#!/bin/bash
#ZombieDetector.sh
if [ !-e $1 ] || [ !-f '/proc/$1/exe' ]; then
    ./myZombie >> result.txt &
fi
for i in {1..60}; do
        ps o pid,ppid,state,command $1 >> result.txt
sleep 1
done
for pid in $(awk '$3~/^Z/{ print;exit }' result.txt); do
 echo "le processus est devenue zombie!!"
exit
done
