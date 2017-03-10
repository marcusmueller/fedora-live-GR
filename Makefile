all: iso

iso: GNU_Radio-Live.iso

GNU_Radio-Live.iso: fedora-live-gnuradio.ks
	sudo livecd-creator --verbose --config=$(pwd)/fedora-live-gnuradio.ks --fslabel=GNU_Radio-Live-`git describe --tags`
	ln -s GNU_Radio-Live-`git describe --tags`.iso GNU_Radio-Live.iso

torrent: GNU_Radio-Live.iso
	mktorrent -o GNU_Radio-Live-`git describe --tags`.torrent -n GNU_Radio-Live-`git describe --tags`.iso GNU_Radio-Live-`git describe --tags`.iso
