#Networking
#tcp: 8888,udp:8888

##https://cloud.google.com/compute/docs/gpus/add-gpus (Ubuntu script for adding gpu drivers)

: <<'END'
#!/bin/bash
echo "Checking for CUDA and installing."
# Check for CUDA and try to install.
if ! dpkg-query -W cuda; then
  # The 16.04 installer works with 16.10.
  curl -O http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
  dpkg -i ./cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
  apt-get update
  apt-get install cuda -y
fi
END

## Update and upgrade ubuntu
sudo apt-get update && sudo apt-get -y upgrade

## Launch Jupyter
##sudo jupyter notebook --ip 0.0.0.0 --port 8888 --allow-root
###########################
#Install python 3 64bit from Anaconda
cd ~
#wget https://www.dropbox.com/s/hcodoobmrtby8dh/cudnn-8.0-linux-x64-v5.1.tgz?dl=0
wget https://www.dropbox.com/s/nt35tcihm5lc4s9/cudnn-8.0-linux-x64-v6.0.tgz?dl=0
tar -xzvf cudnn-8.0-linux-x64-v6.0.tgz
sudo cp cuda/include/cudnn.h /usr/local/cuda/include
sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn.h 


cd ~
wget https://repo.continuum.io/archive/Anaconda3-4.3.1-Linux-x86_64.sh
bash Anaconda3-4.3.1-Linux-x86_64.sh -b
#echo 'PATH="/home/ubuntu/anaconda3/bin:$PATH"' >> .bashrc
echo 'PATH="'$HOME'/anaconda3/bin:$PATH"' >> .bashrc


echo 'export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64"' >> .bashrc

echo 'export CUDA_HOME=/usr/local/cuda' >> .bashrc

source ~/.bashrc

echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add -
cd ~
pip install --ignore-installed --upgrade https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.1.0-cp36-cp36m-linux_x86_64.whl
#sudo apt-get update && sudo apt-get install bazel
#sudo apt-get upgrade bazel

