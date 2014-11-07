#!/bin/bash

for i in `perl -e '$,=" ";print +(A..Z)'`
do
  mkdir -p "$i"
done
