FROM debian:8
MAINTAINER sukumargv <vgurugubelli@umassd.com>
ENTRYPOINT ["vistrails"]
# http.debian.net seems to contain bad mirrors, use something else
RUN \
  sh -c 'echo "deb http://ftp.us.debian.org/debian jessie main" > /etc/apt/sources.list' && \
  sh -c 'echo "deb http://ftp.us.debian.org/debian jessie-updates main" >> /etc/apt/sources.list' && \
  sh -c 'echo "deb http://security.debian.org jessie/updates main" >> /etc/apt/sources.list'
# Install VisTrails deps from distrib
RUN \
  apt-get update && \
  apt-get install -y python python-dateutil python-dev \
    python-numpy python-paramiko \
    python-pip python-scipy \
    python-tz git

RUN \
  pip install git+https://github.com/vistrails/vistrails.git@v2.2

ADD startup.xml /root/.vistrails/startup.xml

ADD nigeria-vt.vt nigeria-vt.vt

ADD run_workflow.py run_workflow.py

CMD python run_workflow.py nigeria-vt.vt nigeria-avg