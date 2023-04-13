# Install latest fedora

```
sudo dnf install -y git podman ansible python3-pip

sudo pip install ansible-navigator

git clone https://github.com/elajoie/halocal.git

cd halocal/configs

update host IP in inventory as 127.0.0.1 is the EE and the IP you put in will be what the EE SSHes into.

add local file called pass with the password for sudo in it

ansible-navigator run -m stdout main.yml --become-pass-file pass



```

make sure you create your own vault file simular to below and put it into the hass folder in your git repo:
```yaml
elevation: 123
latitude: 40.111111
longitude: 20.111111
mqttpassword: 123
stream_img: https://1.1.1.1/snap.jpeg
stream_url: rtsp://xyz
```

```

```

# Build images

```
podman build --rm -t homeassistant -f hass/Containerfile

podman build --rm -t mosquitto -f mosquitto/Containerfile

podman run -dt --rm -p 1883:1883 --name mosquitto -v /etc/mosquitto:/etc/mosquitto:Z localhost/mosquitto:latest

podman run -dt --rm -p 8123:8123 --name homeassistant -v /home/admin/.homeassistant:/root/.homeassistant:Z localhost/homeassistant:latest

podman generate systemd --new --name mosquitto > /etc/systemd/system/mosquitto.service

podman generate systemd --new --name homeassistant > /etc/systemd/system/homeassistant.service

systemctl enable --now mosquitto.service

systemctl enable --now homeassistant.service
```

Again, looking for feedback from your own experiance and ways to make this easier to have an offline HA which you as the user control the OS and image used to run HA.

Enjoy,
Eric
