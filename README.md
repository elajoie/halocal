Install Fedora 34

Install podman and git

git clone your repo

cd halocal

vi vault.txt

podman secret create vault vault.txt

podman build --rm -t homeassistant -f Containerfile

Pre Reqs:
1. make sure you create your own vault file simular to below:
```yaml
elevation: 123
latitude: 40.111111
longitude: 20.111111
mqttpassword: 123
stream_img: https://1.1.1.1/snap.jpeg
stream_url: rtsp://xyz
```

Pleas note the host running the container should already allow the ports for HA and Mosquitto.
```
1. dnf -y install podman
2. podman pull registry.fedoraproject.org/fedora:latest
3. firewall-cmd --zone=FedoraServer --add-port=8123/tcp --permanent
4. firewall-cmd --permanent --zone=FedoraServer --add-port=1883/tcp
5. firewall-cmd --permanent --zone=FedoraServer --add-port=1883/udp
6. firewall-cmd --permanent --zone=FedoraServer --add-port=8883/tcp
7. firewall-cmd --permanent --zone=FedoraServer --add-port=8883/udp
8. firewall-cmd --reload
```

Again, looking for feedback from your own experiance and ways to make this easier to have an offline HA which you as the user control the OS and image used to run HA.

Enjoy,
Eric
