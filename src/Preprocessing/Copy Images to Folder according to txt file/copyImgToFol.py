import shutil 
import os
import sys

sourceFolder = sys.argv[1]
destFolder   = sys.argv[2]
mapFile      = sys.argv[3]

file_handle = open(mapFile, 'r+')

with open(mapFile) as file_handle:
  lineTemp = file_handle.readlines()
  for listTemp in lineTemp:
    print listTemp
    splitStr = listTemp.split()
    if(len(splitStr)==2):
      src = sourceFolder + '/' + splitStr[0]
      dst = destFolder   + '/' + splitStr[1] + '/' + splitStr[0]
      print src + '\n' + dst
      shutil.copyfile(src, dst)




# src = '/home/mallikarjun/Documents/data/courses/SMAI/Project/Sign Image Data/imageClass.txt'
# dst = '/home/mallikarjun/Documents/data/courses/SMAI/Project/Sign Image Data/testing/imageClass.txt'
# shutil.copyfile(src, dst)
