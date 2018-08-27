# Fedora-based Live GNU Radio environment

Highlights:

* Fedora 28 x86_64, MATE desktop (less confusing than Gnome 3, imho)
* GNU Radio 3.7.13.4 (as of writing, the version from my COPR)

## Getting an image
### Downloading a readily made image

Get the current release torrent from https://github.com/marcusmueller/fedora-live-GR/releases .

### Building an image yourself


<pre>
sudo dnf install mock
git clone https://github.com/marcusmueller/fedora-live-GR
cd fedora-live-GR
make iso
</pre>

## Burning an image to a stick

### Fedora, RedHat 7, derivatives

<pre>
sudo dnf install liveusb-creator
mediawriter
</pre>

and select the .iso from the previous step

### Windows, OS X

Get the mediawriter from https://github.com/MartinBriza/MediaWriter/releases

### Other systems

Unetbootin should work, or, in fact, dd.

## Usage

Applications → Programming → GRC

The rest should be covered under http://tutorials.gnuradio.org
