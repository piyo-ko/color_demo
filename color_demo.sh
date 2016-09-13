#!/bin/sh

echo '<attribute background foreground>'
echo "\nSpecifying the background color"
for bg in 40 41 42 43 44 45 46 47
do
  for att in 0 1 2 5 7 4
  do
    for fg in 30 31 32 33 34 35 36 37
    do
      # -n option is not valid here.  Instead, \c is used.
      echo "\033[${att};${bg};${fg}m<${att} ${bg} ${fg}> \033[0m\c"
    done
    echo " "
  done
  echo " "
done

echo '\nNot specifying the background color'
for att in 0 1 2 5 7 4
do
  for fg in 30 31 32 33 34 35 36 37
  do
    echo "\033[${att};${fg}m<${att} NA ${fg}> \033[0m\c"
  done
    echo " "
done

echo "\nTesting 256 colors"

i=0
while [ $i -lt 16 ]
do
  j=0
  while [ $j -lt 16 ]
  do
    n=$(( i * 16 + j))
    ns=$(printf "%03d" $n)
    echo "\033[48;5;${n}m ${ns} \033[0m\c"
    j=$(( j + 1 ))
  done
  i=$(( i + 1))
  echo " "
done

echo "   *   *   *   *"
i=0
while [ $i -lt 16 ]
do
  j=0
  while [ $j -lt 16 ]
  do
    n=$(( i * 16 + j))
    ns=$(printf "%03d" $n)
    echo "\033[4;38;5;${n}m ${ns} \033[0m\c"
    j=$(( j + 1 ))
  done
  i=$(( i + 1))
  echo " "
done

echo "Bye!"

