# Install latest fedora

```
sudo dnf install -y git podman ansible python3-pip

sudo pip install ansible-navigator

git clone https://github.com/elajoie/halocal.git

cd halocal/configs

Change inventory IP to match your HA system IP or hostname

add local file called rootpass with the password for sudo into config folder

add a local file called vaultpass with your vault password into the config folder

You will likely have a .gitignore file which looks like below:

```yml
vaultpass*
rootpass*
main-artifact*
vault-artifact*
.gitignore
ansible-nav*
.vscode/
```

make sure you create your own vault file simular to below and put it into the hass folder
in your git repo:

```ini
elevation: 123
latitude: 40.111111
longitude: 20.111111
mqttpassword: 123
stream_img: https://1.1.1.1/snap.jpeg
stream_url: rtsp://xyz
```


Now run this command from within the config folder:
```cli
ansible-navigator run --mode stdout --become-password-file=rootpass --vault-password-file=vaultpass main.yml
```

Again, looking for feedback from your own experiance and ways to make this easier to have
an offline HA which you as the user control the OS and image used to run HA.

Enjoy,
Eric
