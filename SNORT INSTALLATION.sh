sudo apt-get update && sudo apt-get dist-upgrade -y

sudo apt install build-essential libpcap-dev libpcre3-dev libnet1-dev zlib1g-dev luajit hwloc libdnet-dev libdumbnet-dev bison flex liblzma-dev openssl libssl-dev pkg-config libhwloc-dev cmake cpputest libsqlite3-dev uuid-dev libcmocka-dev libnetfilter-queue-dev libmnl-dev autotools-dev libluajit-5.1-dev libunwind-dev libfl-dev -y


mkdir ~/snort_src && cd ~/snort_src

sudo git clone https://github.com/snort3/libdaq.git
cd libdaq
sudo ./bootstrap
sudo ./configure
sudo make
sudo make install

cd ../
sudo wget https://github.com/gperftools/gperftools/releases/download/gperftools-2.9.1/gperftools-2.9.1.tar.gz
sudo tar xzf gperftools-2.9.1.tar.gz
cd gperftools-2.9.1/
sudo ./configure
sudo make
sudo make install

cd..
sudo wget https://github.com/snort3/snort3/archive/refs/heads/master.zip
sudo unzip master.zip
cd snort3-master
sudo ./configure_cmake.sh --prefix=/usr/local --enable-tcmalloc


cd build
sudo make
sudo make install

sudo ldconfig

snort -V

snort -c /usr/local/etc/snort/snort.lua


snort --help



snort -?

sudo apt update
sudo apt install snort -y

ip address show

sudo ip link set dev ens18 promisc on # ens18 SET ACCORDING TO YOUR DEVICE

ethtool -k ens18 | grep receive-offload # SET YOUR ens here


sudo ethtool -K ens18 gro off lro off # SET YOUR ens here

# CONFIGURE THE FOLLOWING
sudo su 
cat > /etc/systemd/system/snort3-nic.service << 'EOL'
> [Unit]
Description=Set Snort 3 NIC in promiscuous mode and Disable GRO, LRO on boot
After=network.target
[Service]
Type=oneshot
ExecStart=/usr/sbin/ip link set dev ens18 promisc on
ExecStart=/usr/sbin/ethtool -K ens18 gro off lro off
TimeoutStartSec=0
RemainAfterExit=yes
[Install]
WantedBy=default.target
EOL


sudo systemctl daemon-reload


sudo systemctl enable --now snort3-nic.service


sudo service snort3-nic status

sudo mkdir /usr/local/etc/rules
sudo mkdir /usr/local/etc/so_rules/
sudo mkdir /usr/local/etc/lists/
sudo touch /usr/local/etc/rules/local.rules
sudo touch /usr/local/etc/lists/default.blocklist
sudo mkdir /var/log/snort


# SET RULES 
-----USE OLD RULES --------

sudo snort -c /usr/local/etc/snort/snort.lua -R /usr/local/etc/rules/local.rules

			OR

snort‬‬ ‫‪-dev‬‬ ‫‪-i‬‬ ‫‪wlan0‬‬ ‫‪-c‬‬ ‫‪/etc/snort/snort.conf‬‬ ‫‪-l‬‬ ‫‪/var/log/snort/‬‬ ‫‪-A‬‬ ‫‪full


