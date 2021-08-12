# Splash Maker
create splash screen

### Requirements
- ffmpeg
- 2 image for bootlogo and fastboot
- your phone LOL

### How to Use
copy your image to _images/_ folder,

then run create.sh file `./create.sh`.

png is default image, if you're using different image, just add image format as parameter

example: jpg file => `./create.sh jpg`

the output is in _output/_ folder

then change splash screen with `dd`:

`dd if=/path/of/splash.img of=/dev/block/bootdevice/by-name/splash`

for example:

`dd if=/sdcard/splash.img of=/dev/block/bootdevice/by-name/splash`

I recommend to backup your stock image:

example: `dd if=/dev/block/bootdevice/by-name/splash of=/sdcard/splash.bak`

### Tested device
- Redmi 4a ( rolex )

Made with Hand by **_Reduce**