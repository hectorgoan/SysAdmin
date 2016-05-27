#!/bin/bash
#Purpose = Backup of Users Data
#Created on 20-5-2016
#Author = AHSoftSol
#Version 1.0
#START
TIME=`date +%b-%d-%y`
FILENAME=backup-$TIME.tar.gz
SRCDIR=/home
DESDIR=/root/backups
tar -cpzf $DESDIR/$FILENAME $SRCDIR
#END