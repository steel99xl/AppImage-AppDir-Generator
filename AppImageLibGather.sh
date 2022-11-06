#!/bin/bash

if [ -z "$1" ]
 then
    	echo "Error No File Specified"
	exit 1;
fi


In=$(ldd $1 | awk -F" " '{print$3}' | awk /./)

echo "Making Dirs"

mkdir $1.AppDir
cd $1.AppDir
mkdir usr
mkdir usr/lib
mkdir usr/lib64
mkdir usr/bin


echo "Coping App"

cp ../$1 usr/bin/


echo "Copying Libs"

for X in $In; do
Y=$(echo $X | awk -F"/" '{print$2 "/" $3 "" }')
 cp $X $Y

done 

echo "Linking App"

ln -s  usr/bin/$1 AppRun

echo "Makgin .desktop file"

touch $1.desktop

echo "[Desktop Entry]
Name="$1"
Exec="$1"
Icon="$1"
Type=Application
Categories=Utility;
" >> $1.desktop

echo "Setting Default Icon"

touch $1.png


cd ..
