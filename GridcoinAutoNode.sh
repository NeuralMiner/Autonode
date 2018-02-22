#!/bin/bash
cd ~

#Installing/upgrading necessary packages.
apt-get -y update && apt-get -y upgrade; apt-get -y install software-properties-common && apt-get -y install sudo && apt-get -y install unzip && apt-get -y install curl

#Figuring out distribution/installing distribution specific packages.
dist=$(lsb_release -ds 2>/dev/null || cat /etc/*release 2>/dev/null | head || uname -om)
if echo $dist | grep -q "jessie"; then echo "deb https://dl.bintray.com/gridcoin/deb jessie stable" >> /etc/apt/sources.list && apt-get install -y --force-yes apt-transport-https && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 379CE192D401AB61;
elif echo $dist | grep -q "stretch"; then echo "deb https://dl.bintray.com/gridcoin/deb stretch stable" >> /etc/apt/sources.list && apt-get install -y --force-yes apt-transport-https && curl -o Bintray.asc https://bintray.com/user/downloadSubjectPublicKey?username=bintray && apt-key add Bintray.asc && rm Bintray.asc;
elif echo $dist | grep -q "Ubuntu"; then add-apt-repository -y ppa:gridcoin/gridcoin-stable;
else echo "DISTRO NOT SUPPORTED" && exit
fi

#Installing Gridcoin daemon.
apt-get -y update && apt-get -y upgrade; apt-get -y install gridcoinresearchd

#Creating gridcoin user.
useradd -m gridcoin

#Creating gridcoinresearch.conf file.
cd ~gridcoin
sudo -u gridcoin mkdir .GridcoinResearch
cd /home/gridcoin/.GridcoinResearch/

#Pulling official snapshot.
sudo -u gridcoin curl -O https://download.gridcoin.us/download/downloadstake/signed/snapshot.zip
unzip snapshot.zip

chown -R gridcoin:gridcoin /home/gridcoin/.GridcoinResearch/*
config="gridcoinresearch.conf"
sudo -u gridcoin touch $config
echo "server=1" > $config
echo "daemon=1" >> $config
echo "rpcport=9332" >> $config
echo "listen=1" >> $config
echo "addnode=grcnode.tahvok.com" >> $config
echo "addnode=grcexplorer.neuralminer.io" >> $config
echo "addnode=grcnode01.neuralminer.io" >> $config
echo "addnode=grcnode02.neuralminer.io" >> $config
echo "addnode=grcnode03.neuralminer.io" >> $config
echo "addnode=grcnode04.neuralminer.io" >> $config
echo "addnode=grcnode05.neuralminer.io" >> $config
echo "addnode=gridcoin.bunnyfeet.fi" >> $config
echo "addnode=gridcoin.certic.info" >> $config
echo "addnode=gridcoin.crypto.fans" >> $config
echo "addnode=gridcoin.hopto.org" >> $config
echo "addnode=ils.gridcoin.co.il" >> $config
echo "addnode=la.grcnode.co.uk" >> $config
echo "addnode=london.grcnode.co.uk" >> $config
echo "addnode=miami.grcnode.co.uk" >> $config
echo "addnode=node.gridcoin.network" >> $config
echo "addnode=node.gridcoin.us" >> $config
echo "addnode=node1.gridcoin.xyz" >> $config
echo "addnode=node1.chick3nman.com" >> $config
echo "addnode=nuad.de" >> $config
echo "addnode=quebec.gridcoin.co.il" >> $config
echo "addnode=seeds.gridcoin.ifoggz-network.xyz" >> $config
echo "addnode=singapore.grcnode.co.uk" >> $config
echo "addnode=toronto01.gridcoin.ifoggz-network.xzy" >> $config
echo "addnode=vancouver01.gridcoin.ifoggz-network.xzy" >> $config
echo "addnode=www.grcpool.com" >> $config

randUser=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
randPass=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
echo "rpcuser=$randUser" >> $config
echo "rpcpassword=$randPass" >> $config

#Adding an alias.
echo "alias grc='sudo -u gridcoin gridcoinresearchd -datadir=/home/gridcoin/.GridcoinResearch/'" >> ~/.bashrc

#All done! Thank you for supporting the Gridcoin network!
sudo -u gridcoin gridcoinresearchd -datadir=/home/gridcoin/.GridcoinResearch/
