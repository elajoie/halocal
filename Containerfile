FROM registry.fedoraproject.org/fedora:latest

# Install some packages
RUN dnf install -y python python3-pip python-devel gcc ansible
RUN pip install homeassistant
RUN timeout 30s hass

#create configs for HA
RUN git clone git@github.com:elajoie/halocal.git
ADD pass.yml
ADD vault
RUN ansible-playbook --vault-password-file halocal/pass.yml halocal/main.yml

#Install MQTT Borker
RUN dnf install -y mosquitto
RUN

#Clean out unneeded storage
RUN dnf clean all

#Good moquitto intro: https://nullr0ute.com/2016/05/getting-started-with-mqtt-using-the-mosquitto-broker-on-fedora/

#expose 8123/tcp for ha and 1883&8883/tcp&udp for mqtt
EXPOSE 8123 1883 8883

COPY inventory.yaml /home/ha/inventory.yaml
WORKDIR /root/.homeassistant
CMD ["/init.sh"]