#!/usr/bin/bash

###################
# extension image
# default .png
ext=$([ $1 ] && echo $1 || echo "png")
###################

###################
# splash image
# only 2 image
splash=(logo.$ext fastboot.$ext)
###################

# main function to create splash.img
main() {
  for x in "${splash[@]}"; do
    debug 'g' "convert $x to ${x%.*}.raw ... "
    ffmpeg -hide_banner -loglevel error -i images/$x -f rawvideo -vcodec rawvideo -pix_fmt bgr24 ${x%.*}.raw
    echo 'OK'
  done

  debug 'g' "creating splash... "
  # splash.img: bootlocked_logo fastboot_logo bootunlocked_logo
  cat extra/header.img logo.raw extra/header.img fastboot.raw extra/header.img logo.raw > splash.img
  zip -uq extra/updater.zip splash.img -O output/splash_recovery.zip
  mv splash.img output/splash_image.img
  echo 'OK'
  debug 'g' "remove temp file... "
  rm logo.raw fastboot.raw
  echo 'OK'
}

# idk
sep() {
  for x in $(seq 1 33); do
    echo -en "\x1b[1;0m="
  done
  
  echo
}

# its just `echo` with extra steps
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
  # check if bootlogo & fastboot is exist
  for x in "${splash[@]}"; do
    image_exist=$([ -f images/$x ] && echo true || echo false)
  done

  if ! $image_exist; then
    debug 'r' "some image(s) doesn't exist\n"
  fi

  # check if ffmpeg is installed
  if ! command -v ffmpeg &> /dev/null; then
    ffmpeg_exist=false
    debug 'r' "ffmpeg not installed\n"
  else
    ffmpeg_exist=true
  fi

  # exit program if image(s) not exist or ffmpeg not installed
  if ! $image_exist || ! $ffmpeg_exist; then
    exit
  fi
}

banner() {
  clear
  sep
  echo -e "\x1b[1;32mSplash Ma\x1b[1;36mker v3.\x1b[1;31m2"
  echo -e "\x1b[1;32mCoder: _R\x1b[1;36meduce"
  echo -e "\x1b[1;32mMade\x1b[1;36m with Hand b\x1b[1;31my _Reduce"
  sep
}

banner
check_exist
main