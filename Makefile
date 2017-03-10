DESC=$(shell git describe --tags)
BASENAME=GNU_Radio-Live-${DESC}

all: iso

test:
	echo ${BASENAME}
iso: ${BASENAME}.iso

${BASENAME}.iso: fedora-live-gnuradio.ks
	sudo livecd-creator --verbose --config=$(pwd)/fedora-live-gnuradio.ks --fslabel=${BASENAME}
	ln -s ${BASENAME}.iso GNU_Radio-Live.iso

torrent: ${BASENAME}.torrent

${BASENAME}.torrent: ${BASENAME}.iso
	mktorrent -o ${BASENAME}.torrent ${BASENAME}.iso -a udp://tracker.openbittorrent.com:80 -a  udp://tracker.opentrackr.org:1337 -a  udp://zer0day.ch:1337 -c "Fedora-Based GNU Radio Live Environment version ${DESC}" -w http://inpha.se/${BASENAME}.iso
