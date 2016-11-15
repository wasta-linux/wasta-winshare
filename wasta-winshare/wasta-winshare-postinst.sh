#!/bin/bash

# ==============================================================================
# wasta-winshare: wasta-winshare-postinst.sh
#
# 2016-11-06 rik: initial script
#
# ==============================================================================

# ------------------------------------------------------------------------------
# Check to ensure running as root
# ------------------------------------------------------------------------------
#   No fancy "double click" here because normal user should never need to run
if [ $(id -u) -ne 0 ]
then
	echo
	echo "You must run this script with sudo." >&2
	echo "Exiting...."
	sleep 5s
	exit 1
fi

# ------------------------------------------------------------------------------
# Main Processing
# ------------------------------------------------------------------------------
DIR=/usr/share/wasta-winshare

# add lightdm login script to make sure mounts happen at login
# note: 16.04 with systemd is unstable using x-systemd.automount, so that is
#   why manually triggering mounts this way...
# note: will be removed by prerm

echo
echo "*** Adding 'mount -a' to /etc/crontab"
echo

# add "mount -a" to /etc/crontab
# note: "#wasta-winshare" added to end of line so can later modify easily
sed -i -e '$a '$(date +%S)' *    * * *   root    /bin/mount -a #wasta-winshare' \
       -e '\@mount -a.*#wasta-winshare@d' \
       /etc/crontab

echo
echo "*** Enabling wasta-winshare systemd service"
echo
systemctl enable wasta-winshare

# ------------------------------------------------------------------------------
#LEGACY: remove any lightdm login script
# ------------------------------------------------------------------------------
if [ -e /etc/lightdm/lightdm.conf.d/*wasta-winshare* ];
then
    echo
    echo "*** Legacy: removing lightdm script triggers"
    echo
    rm -f /etc/lightdm/lightdm.conf.d/*wasta-winshare*
fi
# ------------------------------------------------------------------------------
# Finished
# ------------------------------------------------------------------------------
echo
echo "*** Finished with wasta-winshare-postinst.sh"
echo

exit 0
