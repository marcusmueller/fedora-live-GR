# Fedora-based Live GNU Radio environment

Contents:

* Fedora 25 x86_64
* GNU Radio 3.7.10.1 (as of writing, the version from F25)
* gr-osmosdr
* rtl-sdr
* hackrf
* uhd 3.10.1.0

## Downloading a readily made image

to be announced

## Building an image yourself

I've not tested this in mock (though I should have), so for now, you'll need a machine running Fedora 25.

<pre>
sudo dnf install livecd-tools spin-kickstarts 
git clone https://github.com/marcusmueller/fedora-live-GR
cd fedora-live-GR
sudo livecd-creator --verbose \
  --config=$(pwd)/fedora-live-gnuradio.ks \
  --fslabel=GNU_Radio-Live
</pre>
