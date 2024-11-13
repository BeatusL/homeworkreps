#!/bin/bash

get_man_section() {
    man $1 | awk -v chapter="$2" '$1 == chapter, /^$/ {print}' | sed '/^$/d'
}


read -p "Введите имя файла-копии: " FILE


read -p "Введите имя системной команды или утилиты (COMMAND): " COMMAND

CHAPTERS="NAME SYNOPSIS REPORTING\ BUGS COPYRIGHT"

touch $FILE

for CHAPTER in $CHAPTERS; do
    echo "-----------------------------------" >> $FILE
    echo "Раздел: $CHAPTER" >> $FILE
    echo "-----------------------------------" >> $FILE
    get_man_section $COMMAND $CHAPTER >> $FILE
    echo "" >> $FILE
done

cat $FILE
