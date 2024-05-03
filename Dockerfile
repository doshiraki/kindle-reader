FROM ubuntu:22.04
WORKDIR /root
RUN apt-get -y update
RUN apt-get install -y language-pack-ja-base language-pack-ja ibus-mozc
RUN echo LANG=ja_JP.utf8 > /etc/default/locale
RUN apt-get -y install  xserver-xorg wget winbind
RUN apt-get install -y winetricks
RUN wget -nc -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
RUN wget -nc -P /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources
ARG WINEVERSION=7.0.2~jammy-1
RUN dpkg --add-architecture i386
RUN apt update && apt-get install -y winehq-stable=${WINEVERSION} wine-stable=${WINEVERSION} wine-stable-i386=${WINEVERSION} wine-stable-amd64=${WINEVERSION}
RUN winetricks -q cjkfonts
RUN winetricks -q allfonts
RUN winetricks -q glut
RUN winetricks -v win7
COPY installer .
RUN chmod u+x login.sh .bash_profile
ENTRYPOINT ["./login.sh"]
CMD [ "su", "-" ]
