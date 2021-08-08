FROM registry.fedoraproject.org/fedora:latest

# Install some packages
RUN dnf install -y python python3-pip python-devel gcc git ansible && pip install homeassistant
RUN timeout 30s hass; exit 0
#create configs for HA
RUN git clone https://github.com/elajoie/halocal.git
RUN --mount=type=secret,id=vault ansible-playbook --vault-password-file /run/secrets/vault halocal/main.yml

#Install MQTT Borker
#RUN dnf install -y mosquitto
#RUN

#expose 8123/tcp for ha and 1883&8883/tcp&udp for mqtt
EXPOSE 8123 1883 8883

WORKDIR /root/.homeassistant
CMD ["hass"]