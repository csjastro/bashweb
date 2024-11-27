#!/bin/bash

echo start GUIPROC:
for word in $*; do echo "$word" >> guiout.txt; done
echo end GUIPROC
