FROM registry.fedoraproject.org/fedora:latest

# Install some packages
RUN dnf install -y python python3-pip python-devel gcc ansible
RUN pip install homeassistant
COPY init.sh /init.sh


RUN mkdir /root/.homeassistant/
RUN wget (git repo) -O /root/.homeassistant/configuration.yaml
RUN hass -c /root/.homeassistant
RUN dnf clean all


RUN chmod 0755 /init.sh

#expose port 8123/tcp
EXPOSE: 8123

# Create validation user
RUN useradd -c "Home Assistant" -m -s /bin/sh -u 1000 ha
USER ha
COPY inventory.yaml /home/ha/inventory.yaml
WORKDIR /root/.homeassistant
CMD ["/init.sh"]
