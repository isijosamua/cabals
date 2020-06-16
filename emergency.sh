#!/bin/bash
#
# emergency.sh
# ver 0.1.2
# Modified: 03-06-2020

. common.lib

FILE="emergency.sh"
if [ -d /etc/cabal ]; then
    /etc/init.d/webmin stop && sleep 3
    /etc/init.d/usermin stop && sleep 3
    cabal_stop && sleep 3
    service mssql-server stop
    echo -e "${LGREN}✔  Semua service sudah berhenti.${DEF}${CDEF}" && sleep 10
    f1baris
    echo -e "${LCYAN}[${BOT}]:${CDEF} Ingin menjalankannya kembali?"
    select yn in "YA" "Jangan dulu"; do
        case $yn in
            YA ) 
                f1baris
                rm -f /var/log/cabal/*.trc && sleep 3;
                rm -f /var/log/cabal/*.txt;
                echo -e "${LCYAN}i  Semua file *.trc and *.txt pada path ${ULINE}/var/log/cabal/${DEF} sudah dihapus.${CDEF}";
                f1baris && sleep 3;
                service mssql-server start && sleep 3;
                cabal_restart -d;
                echo -e "${LCYAN}i  Server CABAL sudah berjalan. Semua file log sudah kosong.${CDEF}";
                f1baris && sleep 30;
                sh stop_war;
                echo -e "${LCYAN}i  Channel NationWar sudah ${BOLD}berhenti${DEF}.${CDEF}";
                f1baris && sleep 3;
                /etc/init.d/webmin start && sleep 3;
                /etc/init.d/usermin start && sleep 3;
                echo -e "${LCYAN}i  Webmin dan Usermin sudah aktif.${CDEF}";
                f1baris;
                fselesai;
                f1baris;
                frmall; # remove all downloaded files
                break;;
            "Jangan dulu" )
                fbye;
                frmall; # remove all downloaded files
                exit;;
        esac
    done

else
    echo -e "${LCYAN}[${BOT}]:${CDEF} Sorry, CABAL folder didn't found. Aborting now."
    fbye
    frmall
fi