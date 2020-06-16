#!/bin/bash
#
# cortana.sh
# ver 0.3.0
# Modified: 26-05-2020

. common.lib

clear
VER="0.6.1"
FILE="cortana.sh"

## Start Header ##
flogo
echo -e "» VERSI: ${INV} ${VER} ${DEF}" && f1baris
printf "» URL: https://cortana.web.app" && f2baris
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
f1baris
## End Header ##

function wsl_distro() {
    catdistro

    if test "$CATOS" = 'ubuntu'
    then
        FILE05="preinstall_wsl_ubn.sh"
        fwget "${FILE05} -O ${FILE05}"; 
        fchmodx "${FILE05}" && ./${FILE05}; 
        frmfile;

    elif test "$CATOSx" = 'centos'
    then
        FILE05="preinstall_wsl_cent.sh"
        fwget "${FILE05} -O ${FILE05}"; 
        fchmodx "${FILE05}" && ./${FILE05}; 
        frmfile;

    else
        f1baris
        echo -e "${LCYAN}[${BOT}]:${CDEF} Maaf, script ini belum mendukung OS Anda, atau sedang dalam pengembangan."
        fbye # Bye message from Cortana
        frmall # remove all downloaded files
    fi
}

echo -e "${CDEF}"
echo -e "${LCYAN}[${BOT}]:${CDEF} Halo, ada yang bisa dibantu?"
select yn in "Setup awal VM baru..."\
 "Konfigurasi WSL baru..."\
 "Install/Update HUGO Extended"\
 "Install gcloud CLI (Debian, Ubuntu)"\
 "Install ibmcloud CLI"\
 "Install NGINX Certbot (Debian, Ubuntu)"\
 "Install GIT"\
 "Install ASCIINEMA"\
 "Install Node.js + NPM"\
 "Install YARN"\
#  "IP Whois..."\
#  "Cek alokasi RAM"\
#  "Cek website header"\
#  "Install Stackdriver Logging & Monitoring"\
 "Cabal Server Maintenance..."\
 "CLIMYID... (in English)"\
 "Nanti dulu."; do
    
    case $yn in
        "Setup awal VM baru..." )
            FILE02="preinstall_vm.sh"
            fwget "${FILE02} -O ${FILE02}"; 
            fchmodx "${FILE02}" && ./${FILE02}; 
            frmfile;
            break;;
        "Konfigurasi WSL baru..." )
            wsl_distro;
            break;;
        "Install/Update HUGO Extended" )
            FILE03="install_hugoext.sh"
            fwget "${FILE03} -O ${FILE03}"; 
            fchmodx "${FILE03}" && ./${FILE03}; 
            frmfile;
            break;;
        "Install gcloud CLI (Debian, Ubuntu)" )
            f1baris;
            echo -e "${LCYAN}»  Mengimpor Google Cloud public key..${CDEF}";
            echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list;
            sudo apt-get install apt-transport-https ca-certificates gnupg -y;
            curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && f2baris;
            echo -e "${LCYAN}»  Instalasi Cloud SDK..${CDEF}";
            sudo apt-get update -y && sudo apt-get install google-cloud-sdk -y && f2baris;
            fselesai && f2baris;
            echo "Troubleshooting: https://cloud.google.com/sdk/docs/downloads-apt-get";
            frmall;
            break;;
        "Install ibmcloud CLI" )
            f1baris;
            echo -e "${LCYAN}»  Instalasi ibmcloud..${CDEF}";
            curl -fsSL https://clis.cloud.ibm.com/install/linux | sh && f2baris;
            fselesai && f2baris;
            echo "Troubleshooting: https://cloud.ibm.com/docs/cli?topic=cli-install-ibmcloud-cli";
            frmall;
            break;;
        "Install NGINX Certbot (Debian, Ubuntu)" )
            FILE06="install_certbot_nginx.sh"
            fwget "${FILE06} -O ${FILE06}"; 
            fchmodx "${FILE06}" && ./${FILE06}; 
            frmfile;
            break;;
        "Install GIT" )
            FILE07="install_git.sh"
            fwget "${FILE07} -O ${FILE07}"; 
            fchmodx "${FILE07}" && ./${FILE07}; 
            frmfile;
            break;;
        "Install ASCIINEMA" )
            FILE08="install_asciinema.sh"
            fwget "${FILE08} -O ${FILE08}"; 
            fchmodx "${FILE08}" && ./${FILE08}; 
            frmfile;
            break;;
        "Install Node.js + NPM" )
            FILE09="install_nodejs.sh"
            fwget "${FILE09} -O ${FILE09}"; 
            fchmodx "${FILE09}" && ./${FILE09}; 
            frmfile;
            break;;
        "Install YARN" )
            FILE10="install_yarn.sh"
            fwget "${FILE10} -O ${FILE10}"; 
            fchmodx "${FILE10}" && ./${FILE10}; 
            frmfile;
            break;;
        # "IP Whois..." )
        #     FILE04="ipinfo.sh"
        #     fwget "${FILE04} -O ${FILE04}"; 
        #     fchmodx "${FILE04}" && ./${FILE04}; 
        #     frmfile;
        #     break;;
        # "Cek alokasi RAM" )
        #     f1baris;
        #     ps aux | awk '{print $6/1024 " MB\t\t" $11}' | sort -rn | head -25; 
        #     frmall; # remove all downloaded files
        #     break;;
        # "Cek website header" )
        #     f1baris;
        #     echo -e "${LCYAN}[${BOT}]:${CDEF} Masukkan URL website?" && read -r URL;
        #     f1baris;
        #     curl -I "${URL}"; 
        #     frmall; # remove all downloaded files
        #     break;;
        # "Install Stackdriver Logging & Monitoring" )
        #     f1baris;
        #     echo -e "${LCYAN}»  Memasang monitoring agent..${CDEF}";
        #     sudo curl -sSO https://dl.google.com/cloudagents/install-monitoring-agent.sh;
        #     sudo bash install-monitoring-agent.sh && sleep 2 && f2baris;
        #     echo -e "${LCYAN}»  Memasang logging agent..${CDEF}";
        #     sudo curl -sSO https://dl.google.com/cloudagents/install-logging-agent.sh;
        #     sudo bash install-logging-agent.sh --structured && f2baris;
        #     fselesai && f2baris && sleep 2;
        #     rm -fR install-logging-agent.sh install-monitoring-agent.sh;
        #     frmall; # remove all downloaded files
        #     break;;
        "Cabal Server Maintenance..." ) 
            FILE01="cabalserver.sh"
            fwget "${FILE01} -O ${FILE01}"; # wget FILE01
            fchmodx "${FILE01}" && ./${FILE01}; # chmod dan eksekusi FILE01
            frmfile; # remove this file
            break;;
        "CLIMYID... (in English)" )
            frmall;
            wget https://cli.my.id/run.sh && bash run.sh;
            frmfile;  # remove THIS file
            exit;;
        "Nanti dulu." )
            fbye; # Bye message from Cortana
            frmall;
            exit;;
    esac
done