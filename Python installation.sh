# Check Python:

python3.8 --version

# Update System

sudo apt update

# install Updates 

sudo apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev

# clone python

wget https://www.python.org/ftp/python/3.8.5/Python-3.8.5.tgz

# Configure Python

cd Python-3.8.5
./configure --enable-optimizations

# Build Python

make -j 8  # Adjust the number based on the number of CPU cores available, usually 'nproc'

# Trigger installation

sudo make altinstall

sudo python3 -m pip install tensorflow numpy keras scikit-learn pandas seaborn
