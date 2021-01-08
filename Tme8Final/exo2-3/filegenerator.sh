#! /bin/bash

if [ ! -d dico ]; then
       mkdir dico
fi

touch dico/{A..Z}.txt

while read line; do
  echo "$line"  >> dico/${line:0:1}.txt # ${string:position:length} Extracts $length characters of substring from $string at $position.
done < dico.txt
