#!/usr/bin/env bash

if [ "$#" -eq 0 ] ; then
	echo "Please add commit message"
	exit 1
else
	cp -r /etc/nixos .
	git add nixos/*
	git commit -m "$1"
	git push
fi

