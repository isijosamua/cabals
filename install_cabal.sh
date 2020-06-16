#!/bin/bash
#
# cabals.sh
# ver 0.1.1
# Modified: 03-06-2020

. common.lib

clear
FILE="install_cabal.sh"

## Start Header ##
flogo
printf "» URL: https://cabals.web.app" && f2baris
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
## End Header ##
f1baris
echo -e "${LCYAN}i  ${DEF}Dowloading data files. Please wait..."
wget https://circlehostingnet.b-cdn.net/cabal/cabal_ep8_repack.tar.gz && tar xzvf cabal*
f1baris
echo -e "\nEpisode 8 Server Installation"
echo -e "${LRED}\nWARNING: Your old server files will be removed!"
echo -e "${DEF}Do you want to continue [Y/n]?"
read ready

if [[ -z $ready || $ready == "n" || $ready == "N" ]]; then
  exit
fi

echo -e "${LCYAN}i  ${DEF}Preparing..."
sleep 1

echo -e "${LCYAN}i  ${DEF}Checking for old installations..."
sleep 1

if [ -d /etc/cabal ]; then
  echo "Found! Cleaning up..."
  rm -rf /etc/cabal
  rm -rf /home/cabal
  rm -rf /var/log/cabal
  rm -rf /usr/bin/AgentShop*
  rm -rf /usr/bin/AuthDBAgent
  rm -rf /usr/bin/CashDBAgent
  rm -rf /usr/bin/ChatNode*
  rm -rf /usr/bin/DBAgent*
  rm -rf /usr/bin/EventDBAgent
  rm -rf /usr/bin/EventMgrSvr
  rm -rf /usr/bin/GlobalDBAgent
  rm -rf /usr/bin/GlobalMgrSvr
  rm -rf /usr/bin/LoginSvr*
  rm -rf /usr/bin/PartySvr*
  rm -rf /usr/bin/PCBangDBAgent
  rm -rf /usr/bin/RockAndRollITS
  rm -rf /usr/bin/WorldSvr*
fi

echo -e "${LCYAN}i  ${DEF}Updating your system..."
sleep 1
yum update -y

echo -e "${LCYAN}i  ${DEF}Installing dependencies..."
sleep 1
yum install -y glibc.i686 libgcc.i686 libstdc++.i686 openssl-devel.i686

echo -e "${LCYAN}i  ${DEF}Creating symlinks for dependencies..."
sleep 1
if [ ! -f /usr/lib/libcrypto.so ]; then
  echo "${LRED}Fatal error! Couldn't find libcrypto.so library. Exiting..."
  exit
fi

if [ ! -f /usr/lib/libcrypto.so.4 ]; then
  ln -s /usr/lib/libcrypto.so /usr/lib/libcrypto.so.4
fi

if [ ! -f /usr/lib/libcrypto.so.6 ]; then
  ln -s /usr/lib/libcrypto.so /usr/lib/libcrypto.so.6
fi

echo -e "${LCYAN}i  ${DEF}Unpacking archive..."
sleep 1
tar xzf ./cabal_ep8.tar.gz -C /

echo -e "${LCYAN}i  ${DEF}Setting up permissions and creating symlinks..."
sleep 1
ln -s /etc/cabal/Template/sh/cabal_config.sh /usr/bin/cabal_config
ln -s /etc/cabal/Template/sh/cabal_create.sh /usr/bin/cabal_create
ln -s /etc/cabal/Template/sh/cabal_restart.sh /usr/bin/cabal_restart
ln -s /etc/cabal/Template/sh/cabal_start.sh /usr/bin/cabal_start
ln -s /etc/cabal/Template/sh/cabal_status.sh /usr/bin/cabal_status
ln -s /etc/cabal/Template/sh/cabal_stop.sh /usr/bin/cabal_stop
ln -s /etc/cabal/Template/sh/cabal_reload.sh /usr/bin/cabal_reload

chmod +x /usr/bin/cabal_config
chmod +x /usr/bin/cabal_create
chmod +x /usr/bin/cabal_restart
chmod +x /usr/bin/cabal_start
chmod +x /usr/bin/cabal_status
chmod +x /usr/bin/cabal_stop
chmod +x /usr/bin/cabal_reload

echo "Done! Now create servers and channels with cabal_create."
echo "Example: cabal_create -s 2"
echo "This will create 2 servers."