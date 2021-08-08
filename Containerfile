FROM registry.fedoraproject.org/fedora:latest

RUN --mount=type=secret,id=vault cat /run/secrets/vault

# Install some packages
RUN dnf install -y python python3-pip python-devel gcc git ansible
RUN pip install homeassistant
RUN timeout 30s hass; exit 0

#create configs for HA
RUN git clone https://github.com/elajoie/halocal.git
RUN ansible-playbook --vault-password-file /run/secrets/vault halocal/main.yml

#Install MQTT Borker
#RUN dnf install -y mosquitto
#RUN

#Clean out unneeded storage
RUN dnf clean all

#Good moquitto intro: https://nullr0ute.com/2016/05/getting-started-with-mqtt-using-the-mosquitto-broker-on-fedora/

#expose 8123/tcp for ha and 1883&8883/tcp&udp for mqtt
EXPOSE 8123 1883 8883

WORKDIR /root/.homeassistant
CMD ["hass"]