#!/bin/bash

# Install ohmyzsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install ohmyzsh kube plugin
cp kube-ps1.sh ~/.kube-ps1.sh

# Install FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install


# Install Pip for System Python
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o ~/.get-pip.py
python ~/.get-pip.py
sudo python -m pip install virtualenvwrapper

# Install Pyenv
curl https://pyenv.run | bash

# Install pyenv-virtualenvwrapper
sudo git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $(pyenv root)/plugins/pyenv-virtualenvwrapper


# Install Kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/amd64/kubectl"
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl
chown root: /usr/local/bin/kubectl

# Speed up Key Repeat for Mac
if [ "$(uname)" == "Darwin" ]; then
    defaults write -g InitialKeyRepeat -int 15
    defaults write -g KeyRepeat -int 2

# AWS CLI Install
mkdir -p ~/.aws
if [ "$(uname)" == "Darwin" ]; then
    echo "Installing AWS CLI for Mac OSX"
    curl -o ~/.aws/AWSCLIV2.pkg https://awscli.amazonaws.com/AWSCLIV2.pkg
    sudo installer -pkg ~/.aws/AWSCLIV2.pkg -target /
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    echo "Installing AWS CLI for Linux"
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
fi

# Install AWS EKS IAM Authenticator
sudo curl -o /usr/local/bin/aws-iam-authenticator https://amazon-eks.s5.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/darwin/amd64/aws-iam-authenticator
sudo chmod +x /usr/local/bin/aws-iam-authenticator


# Copy zshrc over
cp my-zshrc ~/.zshrc
source ~/.zshrc

# Copy vimrc over
cp my-vimrc ~/.vimrc
