
export HOMEBREW_NO_AUTO_UPDATE=1

brew install portaudio || exit 1 
brew install qt        || exit 1 
brew install wget      || exit 1 



mkdir ../qt00-build
cd ../qt00-build
cmake ../qt00 || exit 1 
make -j3 || exit 1 



############  sanity check  ############




####### make artifact
pwd
ls -lh
cd ../ && mv qt00-build qt00.app
/usr/local/opt/qt/bin/macdeployqt qt00.app || exit 1 
cd qt00.app
mkdir Contents/MacOS
mv qt00 Contents/MacOS/Qt00
rm -rf CMakeFiles
rm -rf client_qt5_autogen
rm -f  Makefile
rm -f  cmake_install.cmake
cd ../qt00/build-scripts/appdmg/

cp ../../misc/Icon.png Icon.png
mkdir MyIcon.iconset
sips -z 16 16     Icon.png --out MyIcon.iconset/icon_16x16.png
sips -z 32 32     Icon.png --out MyIcon.iconset/icon_16x16@2x.png
sips -z 32 32     Icon.png --out MyIcon.iconset/icon_32x32.png
sips -z 64 64     Icon.png --out MyIcon.iconset/icon_32x32@2x.png
sips -z 128 128   Icon.png --out MyIcon.iconset/icon_128x128.png
sips -z 256 256   Icon.png --out MyIcon.iconset/icon_128x128@2x.png
sips -z 256 256   Icon.png --out MyIcon.iconset/icon_256x256.png
sips -z 512 512   Icon.png --out MyIcon.iconset/icon_256x256@2x.png
sips -z 512 512   Icon.png --out MyIcon.iconset/icon_512x512.png
cp Icon.png MyIcon.iconset/icon_512x512@2x.png
iconutil -c icns MyIcon.iconset


mv ../../../qt00.app Qt00.app
cp Info.plist  Qt00.app/Contents/
cp PkgInfo     Qt00.app/Contents/
cp MyIcon.icns Qt00.app/Contents/Resources/
npm install -g appdmg || exit 1 
ls -lh
appdmg spec.json Qt00.dmg # || exit 1 
ls -lh
#mv Qt00.dmg ../../../Qt00.Client.macOS.dmg || exit 1 


############ extra sanity check  ############
#open ../../../Qt00.Client.macOS.dmg      || exit 1
#open Qt00.app                            || exit 1
