# vivaldi

sudo pacman -S vivaldi-ffmpeg-codecs
paru -S vivaldi-widevine
sudo pacman -S libva-intel-driver libva-utils
sudo pacman -S intel-media-driver
sed -i 's/"use_native_decoration":false/"use_native_decoration":true/' \
	~/.config/vivaldi/Default/Preferences
