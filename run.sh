#!/bin/bash
#
# run.sh
# ver 0.2.1
# Modified: 17-06-2020

FILE="run.sh"
CDEF="\e[39m"
LCYAN="\e[96m"
LRED="\e[91m"

# Pre-check
fdistrochk() {
    TITLE="${LCYAN}i  Pre-check:${CDEF}"
    osrhel=$(grep -w ID /etc/os-release | cut -d '"' -f 2)

    if [[ "$osrhel" = 'centos' ]]
    then
        PKG="yum"

    else
        printf "\n"
        echo -e "${LRED}Sorry, your Distro is not supported yet. Exiting now.${CDEF}"
        echo -e "${LCYAN}See you later.${CDEF}" # Bye message from Cortana
        rm -fR $FILE # remove all downloaded files
        exit
    fi
}
fdistrochk

## Check dependecies if exist
if [ ! -f /usr/bin/tar ]; then
    echo "${TITLE} TAR not found. Installing..."
    ${PKG} -y -q install tar
fi

## Fetching required files to run
sudo wget -q https://cabals.web.app/common.lib
sudo wget -q https://cabals.web.app/cabals.sh
sudo chmod +x cabals.sh
./cabals.sh