#!/bin/bash

# ==============================================================================
# Wasta-Winshare Logout
#
#   Force unmount of any "wasta-winshare" cifs mounts
#
#   2016-11-06 rik: initial script
#
# ==============================================================================

WINSHARES=$(grep "#wasta-winshare" /etc/fstab | cut -d " " -f 2)

for SHARE in $WINSHARES;
do
    #force unmount of wasta-winshare mount: by the time we get here it needs
    # to unmount.

    umount -f $SHARE
done

exit 0
