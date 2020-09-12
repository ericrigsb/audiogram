FROM ubuntu:16.04

# Install dependencies
RUN apt-get update --yes && apt-get upgrade --yes
RUN apt-get install git nodejs npm \
libcairo2-dev libjpeg8-dev libpango1.0-dev libgif-dev libpng-dev build-essential g++ \
ffmpeg \
redis-server --yes

RUN ln -s `which nodejs` /usr/bin/node

# Non-privileged user
RUN useradd -m audiogram
USER audiogram
WORKDIR /home/audiogram

# Clone repo
RUN git clone https://github.com/nypublicradio/audiogram.git
WORKDIR /home/audiogram/audiogram

# Add my theme
COPY settings/backgrounds/BITL-640x640.png settings/backgrounds/
COPY settings/themes.json settings/

# Install dependencies
RUN npm install
