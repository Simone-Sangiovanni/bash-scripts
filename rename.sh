#!/bin/bash

# read all the file contained in the directory specified in "input" variable and rename them with numbers from 1 to "x", where "x" depends on the number of file contained in the directory

input="/home/name/Desktop/OneDrive_2023-05-23/Compitini esami precedenti"
i=1
while IFS= read -r line
do
  mv "/home/name/Desktop/OneDrive_2023-05-23/Compitini esami precedenti/$line" "/home/name/Desktop/OneDrive_2023-05-23/Compitini esami precedenti/$i"
  ((i=i+1))
done < "$input"
