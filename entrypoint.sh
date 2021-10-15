#!/usr/bin/env bash

c_path=$1

enc_file() {
  echo "enc file ${1}";
  [ "${1: -4}" != '.enc' ] && { openssl enc  -in $1 -out "${1}.enc" -e -aes256 -k .private.pem && rm -f $1; } || {
    echo "enc file ${1} failure."; exit 1
  }
}

enc_dir() {
  find $1 -type f ! -name '*.enc' | while read line; do
    enc_file $line $2;
  done
}


# check
[ -e $c_path ] || { echo "$c_path not exist." ; exit 1; }
 
if [ -d $c_path ]; then 
  echo "action dir ${c_path}"
  enc_dir $c_path
else
  enc_file $c_path
fi
