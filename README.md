Install Fedora 34

firewall-cmd --permanent--zone=FedoraServer --add-port=8123/tcp 

firewall-cmd --permanent --zone=FedoraServer --add-port=1883/tcp

firewall-cmd --permanent --zone=FedoraServer --add-port=1883/udp

firewall-cmd --permanent --zone=FedoraServer --add-port=8883/tcp

firewall-cmd --permanent --zone=FedoraServer --add-port=8883/udp

firewall-cmd --reload

dnf install -y git podman

git clone your repo

cd halocal

make sure you create your own vault file simular to below and put it into the hass folder in your git repo:
```yaml
elevation: 123
latitude: 40.111111
longitude: 20.111111
mqttpassword: 123
stream_img: https://1.1.1.1/snap.jpeg
stream_url: rtsp://xyz
```

(put your ansible vault password into this file in git clone root folder)

vi vault.txt

Build images

(you can add the --no-cache option if you have to do edits on the git repo between builds)

podman build --rm -t homeassistant --secret=id=vault,src=vault.txt -f hass/Containerfile

podman build --rm -t mosquitto -f mosquitto/Containerfile

podman pod create --name ha -p 8123:8123 -p 1883:1883 -p 8883:8883

podman run -dt --pod ha localhost/mosquitto

podman run -dt --pod ha localhost/homeassistant


Again, looking for feedback from your own experiance and ways to make this easier to have an offline HA which you as the user control the OS and image used to run HA.

Enjoy,
Eric
