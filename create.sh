#!/usr/bin/bash

if ! command -v ffmpeg &> /dev/null; then
  echo "ffmpeg not installed"
  exit
fi

ext=$([ $1 ] && echo $1 || echo "png")
splash=(logo.$ext fastboot.$ext)

sep() {
  for x in $(seq 1 33); do
    echo -en "\x1b[1;0m="
  done
  
  echo
}

debug() {
  d='\x1b[1;0m'
  if [ $1 == 'r' ]; then
    a='\x1b[1;31m'; b='\x1b[1;33m'; c='!'
  elif [ $1 == 'g' ]; then
    a='\x1b[1;32m'; b='\x1b[1;36m'; c='*'
  fi

  echo -en "$d[$a$c$d] $b$2$d"
}

check_splash() {
  for x in "${splash[@]}"; do
    exist=$([ -f images/$x ] && echo true || echo false)
  done

  if ! $exist; then
    debug 'r' "some image doesn't exists\n"
    exit
  fi
}

banner() {
  clear
  sep
  echo -e "\x1b[1;32mSplash Ma\x1b[1;36mker v1.3"
  echo -e "\x1b[1;32mDevice: \x1b[1;36mRedmi 4A\x1b[1;31m(rolex)"
  echo -e "\x1b[1;32mCoder: \x1b[1;36m_Reduce"
  echo -e "\x1b[1;32mffmpeg: \x1b[1;36m$(which ffmpeg)"
  sep
}

banner
check_splash