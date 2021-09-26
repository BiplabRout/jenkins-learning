#!/bin/bash

counter=0

while [ $counter -lt 2 ]; do
	let counter=counter+1
	name=$(nl ./people.txt | grep -w $counter | awk '{print $2}' | awk -F ',' '{print $1}')
	age=$(shuf -i 20-25 -n 1)
	/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "" -d sqldbl -Q "insert into register values ($counter,'$name',$age)"
done	
