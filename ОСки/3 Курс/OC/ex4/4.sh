#! /bin/bash
cd $1
for file in *;
do
	stat --format='file name %n, size %s, attributes %A' $file >> test1.txt
done
cd ../$2
for file in *;
do
	stat --format='file name %n, size %s, attributes %A' $file >> test2.txt
done
cd ../
ls -l $1
echo "-------------------"
ls -l $2
echo "Diff:"
diff $1/test1.txt $2/test2.txt
rm $1/test1.txt $2/test2.txt

