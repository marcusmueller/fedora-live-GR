# Desktop with customizations to fit in a CD (package removals, etc.)
# Maintained by the Fedora Desktop SIG:
# http://fedoraproject.org/wiki/SIGs/Desktop
# mailto:desktop@lists.fedoraproject.org

%include /usr/share/spin-kickstarts/fedora-live-base.ks
%include /usr/share/spin-kickstarts/fedora-live-minimization.ks

part / --size 6144

timezone Europe/Berlin

%packages
libcrypt-nss
-libcrypt
-PackageKit*                # we switched to yumex, so we don't need this
firefox
@mate
compiz
compiz-plugins-main
compiz-plugins-extra
compiz-manager
compizconfig-python
compiz-plugins-experimental
libcompizconfig
compiz-plugins-main
ccsm
simple-ccsm
emerald-themes
emerald
fusion-icon
@networkmanager-submodules
blueman

# some apps from mate-applications
caja-actions

# system tools
lightdm-gtk-greeter-settings

# audio video
parole
audacity
PackageKit-gstreamer-plugin

# GNU Radio stuff
gnuradio
gr-osmosdr
python2-matplotlib-qt4
git
gnuradio-devel
swig
cmake
gcc-c++
python2-devel
scipy
python2
python-pip




# blacklist applications which breaks mate-desktop
-audacious

# Drop things for size
-@3d-printing
-@dialup
-brasero
-colord
-fedora-icon-theme
-GConf2
-gnome-icon-theme
-gnome-icon-theme-symbolic
-gnome-themes
-gnome-themes-standard
-gnome-user-docs
-evolution


# Help and art can be big, too
-evolution-help

# TODO add customization package (background, blacklist, desktop links)

%end

%post
cat >> /etc/rc.d/init.d/livesys << EOF


# make the installer show up
if [ -f /usr/share/applications/liveinst.desktop ]; then
  # Show harddisk install in shell dash
  sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop ""
fi
mkdir /home/liveuser/Desktop
cp /usr/share/applications/liveinst.desktop /home/liveuser/Desktop

# rebuild schema cache with any overrides we installed
glib-compile-schemas /usr/share/glib-2.0/schemas

# set up lightdm autologin
sed -i 's/^#autologin-user=.*/autologin-user=liveuser/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-user-timeout=.*/autologin-user-timeout=0/' /etc/lightdm/lightdm.conf
#sed -i 's/^#show-language-selector=.*/show-language-selector=true/' /etc/lightdm/lightdm-gtk-greeter.conf

# set MATE as default session, otherwise login will fail
sed -i 's/^#user-session=.*/user-session=mate/' /etc/lightdm/lightdm.conf

# Turn off PackageKit-command-not-found while uninstalled
if [ -f /etc/PackageKit/CommandNotFound.conf ]; then
  sed -i -e 's/^SoftwareSourceSearch=true/SoftwareSourceSearch=false/' /etc/PackageKit/CommandNotFound.conf
fi

# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser/
restorecon -R /home/liveuser/

# Blacklist the rtl2823u kernel module (we don't want DVB, we want SDR)
# TODO: Move that into a customization package!
echo "blacklist dvb_usb_rtl28xxu\n" >> /etc/modprobe.d/blacklist.conf

EOF

%end