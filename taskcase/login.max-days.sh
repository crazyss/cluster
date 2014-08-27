#!/bin/bash

A="PASS_MAX_DAYS.*99999"
B="PASS_MAX_DAYS   "
cat login.defs | sed s/"$A"/"$B$1"/g