#!/usr/bin/bash

ext=$([ $1 ] && echo $1 || echo "png")
splash=(logo.$ext fastboot.$ext)

main() {
  for x in "${splash[@]}"; do
    debug 'g' "convert $x to ${x%.*}.raw ... "
    ffmpeg -hide_banner -loglevel error -i images/$x -f rawvideo -vcodec rawvideo -pix_fmt bgr24 ${x%.*}.raw
    echo 'OK'
  done

  debug 'g' "creating splash... "
  cat extra/header.img logo.raw extra/header.img fastboot.raw extra/header.img logo.raw > output/splash.img
  echo 'OK'
  debug 'g' "remove temp file... "
  rm logo.raw fastboot.raw
  echo 'OK'
}

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

check_exist() {
  for x in "${splash[@]}"; do
    image_exist=$([ -f images/$x ] && echo true || echo false)
  done

  if ! $image_exist; then
    debug 'r' "some image doesn't exists\n"
  fi

  if ! command -v ffmpeg &> /dev/null; then
    ffmpeg_exist=false
    debug 'r' "ffmpeg not installed"
  else
    ffmpeg_exist=true
  fi

  if ! $image_exist || ! $ffmpeg_exist; then
    exit
  fi
}

banner() {
  clear
  sep
  echo -e "\x1b[1;32mSplash Ma\x1b[1;36mker v1.3"
  echo -e "\x1b[1;32mDevice: \x1b[1;36mRedmi 4A\x1b[1;31m(rolex)"
  echo -e "\x1b[1;32mCoder: \x1b[1;36m_Reduce"
  echo -e "\x1b[1;32mffmpeg: \x1b[1;36m$(command -v ffmpeg || echo 'Not Installed')"
  sep
}

banner
check_exist
main