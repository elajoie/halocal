h1. Install Fedora 34

firewall-cmd --permanent--zone=FedoraServer --add-port=8123/tcp 

firewall-cmd --permanent --zone=FedoraServer --add-port=1883/tcp

firewall-cmd --permanent --zone=FedoraServer --add-port=1883/udp

firewall-cmd --reload

dnf install -y git podman

git clone https://github.com/elajoie/halocal.git

cd halocal/configs

make sure you create your own vault file simular to below and put it into the hass folder in your git repo:
```yaml
elevation: 123
latitude: 40.111111
longitude: 20.111111
mqttpassword: 123
stream_img: https://1.1.1.1/snap.jpeg
stream_url: rtsp://xyz
```

ansible-playbook --ask-vault-pass main.yml 

h1. Build images

podman build --rm -t homeassistant -f hass/Containerfile

podman build --rm -t mosquitto -f mosquitto/Containerfile

podman pod create --name ha -p 8123:8123 -p 1883:1883 -p 8883:8883

podman run -dt --rm -p 1883:1883 --name mosquitto -v /etc/mosquitto:/etc/mosquitto:Z localhost/mosquitto 

podman run -dt --rm -p 8123:8123 --name homeassistant -v /root/.homeassistant:/root/.homeassistant:Z localhost/homeassistant

podman generate systemd --new --name mosquitto > /etc/systemd/system/mosquitto.service

podman generate systemd --new --name homeassistant > /etc/systemd/system/homeassistant.service

systemctl enable --now mosquitto.service

systemctl enable --now homeassistant.service

Again, looking for feedback from your own experiance and ways to make this easier to have an offline HA which you as the user control the OS and image used to run HA.

Enjoy,
Eric
