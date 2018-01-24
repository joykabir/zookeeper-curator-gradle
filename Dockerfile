FROM ubuntu:16.04
MAINTAINER ZIA KAB, zkabir@protonmail.com


RUN apt-get update \
    && apt-get install -y software-properties-common curl \
    && add-apt-repository ppa:jonathonf/python-3.6 \
    && apt-get remove -y software-properties-common \
    && apt autoremove -y \
    && apt-get update \
    && apt-get install -y python3.6 \
    && apt-get install -y python-virtualenv\
    && curl -o /tmp/get-pip.py "https://bootstrap.pypa.io/get-pip.py" \
    && python3.6 /tmp/get-pip.py \
    && apt-get remove -y curl \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# update pip
RUN python3.6 -m pip install pip --upgrade
RUN python3.6 -m pip install wheel

#RUN ln -sfn /usr/bin/python3.6 /usr/bin/python3 \
#    && ln -sfn /usr/bin/python3 /usr/bin/python \
#    && ln -sfn /usr/bin/pip3 /usr/bin/pip

#RUN useradd app

RUN mkdir -p /scripts
ADD start.sh /scripts/start.sh
RUN chmod +x /scripts/start.sh

#ADD maintenance.sh /srv/maintenance.sh
#RUN chmod +x /srv/maintenance.sh

#RUN chown -R app:app /srv
#USER app

ENTRYPOINT ["/bin/bash", "/srv/start.sh"]