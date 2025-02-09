# ---------------------------------------
# Generic Wine image based on Wine stable 
# ---------------------------------------
FROM ghcr.io/parkervcp/yolks:debian

LABEL author="Michael Parker" maintainer="parker@pterodactyl.io"

## install required packages
RUN dpkg --add-architecture i386 \
    && apt update -y \
    && apt install -y --no-install-recommends gnupg2 tzdata software-properties-common libntlm0 winbind xvfb xauth python3 libncurses5:i386 libncurses6:i386

# Install winehq-stable and with recommends
RUN sudo mkdir -pm755 /etc/apt/keyrings
    && wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo gpg --dearmor -o /etc/apt/keyrings/winehq-archive.key - \
    && sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources
    && apt update \
    && apt install -y --install-recommends winehq-stable cabextract xvfb

# Set up Winetricks
RUN	wget -q -O /usr/sbin/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks \
    && chmod +x /usr/sbin/winetricks

#
ENV HOME=/home/container
ENV WINEPREFIX=/home/container/.wine
ENV DISPLAY=:0
ENV DISPLAY_WIDTH=1024
ENV DISPLAY_HEIGHT=768
ENV DISPLAY_DEPTH=16
ENV AUTO_UPDATE=1
ENV XVFB=1

USER container
WORKDIR	/home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD	["/bin/bash", "/entrypoint.sh"]