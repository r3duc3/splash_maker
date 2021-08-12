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