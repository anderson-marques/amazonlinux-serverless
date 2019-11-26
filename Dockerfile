FROM amazonlinux:2018.03.0.20191014.0
LABEL author=anderson.mo.carvalho@gmail.com

# Install python 3, pip3 and unzip
RUN yum install python36 unzip -y &&\
  # Downloads AWS CLI
  curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" &&\
  # Unzip the budle
  unzip awscli-bundle.zip &&\
  # Install without using SUDO
  ./awscli-bundle/install -b ~/bin/aws &&\
  # Add $HOME/bin to PATH
  PATH=$HOME/bin:$PATH &&\
  # Update Yum
  yum update -y

# Install homebrew and adds aws/tap
RUN yum groupinstall 'Development Tools' -y &&\
  yum install curl file git -y &&\
  git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew &&\
  mkdir ~/.linuxbrew/bin &&\
  ln -s ../Homebrew/bin/brew ~/.linuxbrew/bin &&\
  eval $(~/.linuxbrew/bin/brew shellenv) &&\
  brew tap aws/tap

# Sets the PATH
ENV PATH=/root/.linuxbrew/Homebrew/Library/Homebrew/vendor/portable-ruby/current/bin:\
/root/.linuxbrew/bin:\
/root/.linuxbrew/sbin:\
/root/bin:\
/usr/local/sbin:\
/usr/local/bin:\
/usr/sbin:\
/usr/bin:\
/sbin:/bin\
/home/homebrew/.homebrew/bin/sam

# Install AWS SAM CLI
RUN brew tap aws/tap && brew install aws-sam-cli

WORKDIR /app
