#!/bin/sh

# This scripts downloads the DAVIS data and unzips it.
# Adaptation of a script written in Faster R-CNN (Ross Girshick)

FILE=davis-data.zip
URL=https://graphics.ethz.ch/Downloads/Data/Davis
CHECKSUM=3396a9e5fbc2359d4661205295b44ef3
DIR=$(pwd)/$(dirname "$0")

if [ ! -f $FILE ]; then
	echo "Downloading DAVIS input (1.9GB)..."
	wget $URL/$FILE

else
	echo "File already exists. Checking md5..."
fi

# CHECKING MDS
os=`uname -s`
if [ "$os" = "Linux" ]; then
	checksum=`md5sum $FILE | awk '{ print $1 }'`
elif [ "$os" = "Darwin" ]; then
	checksum=`cat $FILE | md5`
fi
if [ "$checksum" = "$CHECKSUM" ]; then
	echo "Checksum is correct."
	echo "Unzipping..."
	unzip $FILE

	# Put in folder "davis"
	mkdir -p $DIR/davis && mv ${FILE%.*}/* $DIR/davis/ && rm -rf $FILE ${FILE%.*}
else
	echo "Checksum is incorrect. Need to download again."
fi
