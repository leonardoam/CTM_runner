#!/bin/bash

# Cleaning files used

# cleaner.R
#	input: <inputdir> <outputdir>
#	output: write in <outputdir>
#		a raw cleaned version of <inputdir> data.
# raw version: all lowercase, without numbers, punctuation and stopwords

# cleaner.cpp
#	input: <dictname> <inputdir> <outputdir>
#	output: write in <outputdir>
#		a fully cleaned version of <inputdir> data
#		using <dictname> for cleaning.
# cleaned version: raw version with just valid words from <dictname>

# ctmrunner.cpp
#	input: <inputdir> <outputfile> <numbertopics>
#	output: write in <outputfile>
#		a .RData file with a topic model object trained over
#		of <inputdir> data using <numbertopics>.

# CONSTANTS
PKGNAM=diabtxt
DICTIO=american-english-large
RAWDIR=raw
CLNDIR=cleaned
CLEANR=cleaner
RUNNER=ctmrunner

# MAIN
#if [ $1 == "clean" ]; then
# 	[ -d data/$RAWDIR ] && rm -rf data/$RAWDIR
#	[ -d data/$CLNDIR ] && rm -rf data/$CLNDIR
#	rm -rf cleaner/build/*
#elif [ $1 == "run" ]; then
#	if [ $2 == "0" ]; then
#		echo "Usage: ./CTM_run_all.sh [clean|run] <number of topics>"
#		exit 1
#	fi
#	[ ! -d data/$DATDIR ] && echo "Cannot find data directory"
#	echo "CLEANING DATA"
#	mkdir data/$RAWDIR
#	for DIR in $(ls -d data/$PKGNAM/*/)
#	do
#		echo "cleaning directory $DIR"
#		Rscript $CLEANR.R $DIR data/$RAWDIR &> /dev/null
#	done
#	echo "APPLYING DICTIONARY CHECK"
#	mkdir -p data/$CLNDIR
#	g++ $CLEANR.cpp -o $CLEANR -O2
#	./$CLEANR dict/$DICTIO data/$RAWDIR data/$CLNDIR
	echo "RUNNING CTM"
	Rscript $RUNNER.R data/$CLNDIR $PKGNAM-$2 $2 &> log-$PKGNAM-$2
#else
#	echo "Usage: ./CTM_run_all.sh [clean|run] <number of topics>"
#	exit 1
#fi
