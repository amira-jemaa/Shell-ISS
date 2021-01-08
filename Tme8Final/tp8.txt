--- TP8 : JEMAA Amira-----
/-----Exercice 1:-----/ 
Question 1: 
  desktop % sleep 30 &                  
[1] 6986
 desktop % ps o pid,ppid,state $!      
  PID  PPID STAT
 6986  5543 SN  
desktop % 
[1]  + done       sleep 30

En lançant la commande sleep 30 & , puis en observant les informations sur le processus
 on peut voir qu'il est dans l'état SN qui signifie que le processus est endormi (le S).

Question 2: 
#!/bin/bash
#adopt.sh
 sleep 60 &
echo "*----informations sur le processus courrant de pid "$$"----*"
ps o pid,ppid,state $$
echo "je suis $$ je termine avant mon fils $!"
echo "mon fils $! est maintenant adopté par init de ppid 1"
ps o pid,ppid,state $! &
Question 3:
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
Question 4:
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
Exercice 2: 
Question 1:
wget http://julien.sopena.fr/dico.txt
##Question 2: 
#! /bin/bash

if [ ! -d dico ]; then
       mkdir dico
fi

touch dico/{A..Z}.txt

while read line; do
  echo "$line"  >> dico/${line:0:1}.txt
done < dico.txt
Exercice 3: 
Question 1: 
#! /bin/bash
#longest.sh
longest=""
max=0

if [ ! -e $1 ] && [ ! -f $1 ]; then
        echo "Usage : $0 <nom_fichier>"
        exit
fi

while read line ;do 
        if [ $max -lt ${#line} ]; then
                longest =$line
                max=${#line}
        fi
done < $1

echo $longest > $1.tmp

====> Le mot le plus long que nous ayons trouvé est CINEMATOGRAPHIASSIONS
Question 2 : 
#!/usr/bin/bash
#paraLongest.sh
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <dirname>"
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "err:can't open dir $1 !"
    exit 1
fi

for file in "$1"/*; do
    ./longest.sh "$file" &
done
wait $!
longest=0
for file in "$1"/*.tmp; do
    word=$(cat "$file")
    l=${#word}
    if [ "$l" -gt $longest ]; then
        longest=$l
        longestword=$word
    fi
done
rm -f "$1"/*.tmp
echo "$longestword"
##Question 3: 
time ./longest.sh dico.txt
-real 0m2,110s
-user 0m1,797s
-sys 0m0,308s
time ./paraLongest.sh dico
-real 0m0,096s
-user 0m0,071s
-sys 0m0,012s
-> On remarque que le temps mis par le script paraLongest.sh est beaucoup plus rapide que longest.sh.

-Le temps d'execution a été divisé par 20
-Le temps d'utilisation du processeur en mode user a été divisé par plus de 100
-Le temps d'utilisation du processeur en mode systeme a été divisé par plus de 10 Cela prouve que paralelliser les taches optimise grandement le temps de recherche.
##Question 4: 
time ./longest.sh dico.txt
-real 0m2,110s
- user + sys = 0m1,797s + 0m0,308s = 0m2,105
time ./paraLongest.sh dico
-real 0m0,096s
- user + sys = 0m0,071s + 0m0,012 = 0m0,083
-> On remarque que la somme des temps user et sys sont tres proche des temps de real a 0,010s pres

Ce resultat s'explique parce que:

-Le temps real : correspond au temps ecoule entre le debut et la fin de l'appel comprenant temps utilisé par les processus et le temps en état bloqué

-Le temps user : correspond au temps ou le processus est en mode en mode utilisateur

-Le temps sys : correspond au temps le temps ou le processus est en code en mode systeme (super utilisateur)


##Question 5 : 
- taux de Parallelisme = (Temps real sans parallelisme)/(Temps real avec parallelisme)

- 2,110 / 0,096 = 21,98
