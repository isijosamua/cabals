#!/bin/bash
#
# cabals.sh
# ver 0.2.0
# Modified: 02-06-2020

. common.lib

clear
FILE="cabals.sh"
VER="0.2.0"

## Start Header ##
flogo
echo -e "» VERSI: ${INV} ${VER} ${DEF}" && f1baris
printf "» URL: https://cabals.web.app" && f2baris
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
## End Header ##

function fwork() {
    echo -e "${CDEF}"
    echo -e "${LCYAN}[${BOT}]:${CDEF} Apa yang akan dikerjakan?"
    select yn in "Install CABAL EP8"\
     "Emergency Stop/Restart"\
     "Server Status"\
     "Exit"; do
        case $yn in
            "Install CABAL EP8" ) 
                VARI="install_cabal.sh";
                fwget "${VARI} -O ${VARI}";  # wget FILE01
                fchmodx "${VARI}" && ./${VARI}; # chmod dan eksekusi FILE01
                frmfile; # remove related files
                break;;
            "Emergency Stop/Restart" ) 
                VARE="emergency.sh";
                fwget "${VARE} -O ${VARE}";  # wget FILE01
                fchmodx "${VARE}" && ./${VARE}; # chmod dan eksekusi FILE01
                frmfile; # remove related files
                break;;
            "Server Status" ) 
                bash /etc/cabal/Template/sh/cabal_status.sh
                frmall; # remove related files
                break;;
            "Exit" )
                fbye; # Bye message from Cortana
                frmall; # remove all downloaded files
                exit;;
        esac
    done
}

function fchkhost() {
    FQDN=$(hostname)

    if [ "$FQDN" = 'thor.ertomedia.net' ]
    then
        fwork
    
    elif [ "$FQDN" = 'thor' ]
    then
        fwork

    else
        echo -e "${LCYAN}[${BOT}]:${CDEF} Maaf, ini bukan server CABAL."
        fbye
        frmall
    fi
}

f1baris
fwork
# fchkhost