while true;
do
	echo $(date)
	echo "Archiving $1 as $2.tar"
	tar -cvf "$2.tar" "$1"
	echo 
	sleep $3
done

