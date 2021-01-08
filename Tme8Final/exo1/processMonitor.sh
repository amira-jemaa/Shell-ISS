#!/bin/bash
#processMonitor.sh
if [ !-e $1 ] || [ !-f '/proc/$1/exe' ]; then
    ./myZombie &
fi
for i in {1..60}; do
        ps o pid,ppid,state $1 
sleep 1
echo "---entrain de surveiller le zombie $1---"
done
