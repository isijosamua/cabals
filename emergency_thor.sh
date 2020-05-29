#!/bin/bash
#
# emergency_thor.sh
# ver 0.1.0

. common.lib

FILE="emergency_thor.sh"

/etc/init.d/webmin stop && sleep 3
/etc/init.d/usermin stop && sleep 3
cabal_stop && sleep 3
service mssql-server stop
echo -e "${LGREN}✔  ${ULINE}Semua service sudah berhenti.${DEF}${CDEF}" && sleep 10
f1baris
echo -e "${LCYAN}[${BOT}]:${CDEF} Ingin menjalankannya kembali?"
select yn in "YA" "Jangan dulu"; do
    case $yn in
        YA ) 
            f1baris
            rm -f /var/log/cabal/*.trc && sleep 3;
            rm -f /var/log/cabal/*.txt;
            echo -e "${LGREN}✔  Semua file *.trc and *.txt pada path ${ULINE}/var/log/cabal/${DEF} sudah dihapus.${CDEF}";
            f1baris && sleep 3;
            service mssql-server start && sleep 3;
            cabal_restart -d;
            echo -e "${LGREN}✔  Server CABAL sudah berjalan. Semua file log sudah kosong.${CDEF}";
            f1baris && sleep 30;
            sh stop_war;
            echo -e "${LGREN}✔  Channel NationWar sudah ${BOLD}berhenti${DEF}.${CDEF}";
            f1baris && sleep 3;
            /etc/init.d/webmin start && sleep 3;
            /etc/init.d/usermin start && sleep 3;
            echo -e "${LGREN}✔  Webmin dan Usermin sudah aktif.${CDEF}";
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