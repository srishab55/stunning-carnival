#!/bin/bash
while [ "1" == "1" ]
do
op1="I know the file name "
op2="I know the extension "
res=$( zenity --list --radiolist --title="Full File search tool"\
    --text="Select search type"\
    --column="Option"\
    --column="Select type"\
    --extra-button Exit \
    False "$op1"\
    False "$op2"\ 
	)
rc=$?
 if [ "$rc" == "1" ]
 then
	exit 
 fi

if [ "$res" == "$op1" ] 
then
	re=$(zenity --forms --title="Create user" --text="Add new user" \
  	 	--add-entry="Enter file name (full /partial)" )
	find .  -type f -iname "$re*" > f1.txt
	sort f1.txt >f2.txt
	rm f1.txt
	file1="f2.txt"
	count=$(cat f2.txt | wc -l)
	(
  echo "10" ; 
  echo "# Loading please wait" ; sleep 1
  echo "20" ; 
  echo "# Loading please wait." ; sleep 1
  echo "50" ; 
  echo "#Loading please wait.." ; sleep 1
  echo "75" ; 
  echo "# Loading please wait..." ; sleep 1
  echo "100" ; 
	) |
zenity --progress \
  --percentage=0 --auto-close
	echo $count
	    res=$(for((i=1;i<=count;i++))
	     do
		 IFS= read "line" 
		echo "dummy"
		echo "$line" | awk -F[/] '{print $(NF)}'
	    done <"$file1"  | zenity --list --radiolist --title="Select File to open" --text="Text" --column="Select File name" --column="Filename" --height=400 --width=400 )
 	filename=$(find . -type f -iname "$res"	)
	echo $filename
	
else
	re=$(zenity --forms --title="Search by extension" --text= "Enter details" \
		--add-entry="Enter Entension" )
	find .  -type f -iname "*.$re" > f1.txt
	sort f1.txt >f2.txt
	rm f1.txt
	file1="f2.txt"
	count=$(cat f2.txt | wc -l)
	echo $count
	(
  echo "10" ; 
  echo "# Loading please wait" ; sleep 1
  echo "20" ; 
  echo "# Loading please wait." ; sleep 1
  echo "50" ; 
  echo "#Loading please wait.." ; sleep 1
  echo "75" ; 
  echo "# Loading please wait..." ; sleep 1
  echo "100" ; 
	) |
zenity --progress \
  --percentage=0 --auto-close
	    res=$(for((i=1;i<=count;i++))
	     do
		 IFS= read "line" 
		echo "dummy"
		echo "$line" | awk -F[/] '{print $(NF)}'
	    done <"$file1"  | zenity --list --radiolist --title="Select File to open" --text="Text" --column="Select File name" --column="Filename" --height=400 --width=400 )
 	filename=$(find . -type f -iname "$res"	)
	echo $filename

fi
	ext=$(echo $filename |awk -F[..] '{print $(NF)}')
	if [ "$ext" == "" ] ; then
		echo "No file"
		exit
	else
		case $ext in 
		pdf) 
			evince $filename
			;;
		jpg)
			eof $filename
			;;
		jpeg)
			eof $filename
			;;
		*) 
			gedit $filename
		esac
	fi
done	


