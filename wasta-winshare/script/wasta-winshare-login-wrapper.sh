#!/bin/bash

# ==============================================================================
# Wasta-Linux Login Wrapper Script
#
#   This wrapper allows normal login process to continue since this script  will finish
#       immediately due to "at" or "&".
#
#   2016-11-06 rik: initial script
#
# ==============================================================================

if ! [ -e /var/spool/cron/atjobs/.SEQ ]; then
  /bin/bash -c "/usr/share/wasta-winshare/script/wasta-winshare-login.sh $*" &
else
  echo "/usr/share/wasta-winshare/script/wasta-winshare-login.sh $*" | at now
fi

exit 0
