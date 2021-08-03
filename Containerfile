FROM registry.fedoraproject.org/fedora:latest

# Install some packages
RUN dnf install -y python python3-pip python-devel gcc
RUN pip install homeassistant
RUN timeout 30s hass
RUN ansible-playbook
RUN dnf clean all

#expose 8123/tcp for ha
EXPOSE: 8123

#expose 1887/tcp for mqtt
EXPOSE: 1887

# Create validation user
RUN useradd -c "Home Assistant" -m -s /bin/sh -u 1000 ha
USER ha
COPY inventory.yaml /home/ha/inventory.yaml
WORKDIR /root/.homeassistant
CMD ["/init.sh"]
