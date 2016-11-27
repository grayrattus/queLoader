#!/bin/bash

myCat=`cat questions.txt`
echo "Wypisanie pliku"
echo $myCat

quest=()
answ=()

oldIFS=$IFS
IFS=?
i=0

echo "Wypisanie pytan i odpowiedzi"
for q in $myCat;
do
	if [[ $IFS == ? ]];
	then
		quest[$i]=$q
		echo Przypisuje pytanie ${quest[$i]}
		IFS=::
	elif [[ $IFS == :: ]];
	then
		answ[$i]=$q
		echo Przypisuje odpowiedz ${answ[$i]}
		IFS=?
	fi
	let i++
done


echo "Pytania"

for item in ${quest[*]};
do
	echo $item
done

echo "Odpowiedzi"

for item in ${answ[*]};
do
	echo $item
done
IFS=$oldIFS
