# Tmux

![Screenshot of my desktop](https://raw.githubusercontent.com/alannssantos/dotfiles/master/.screenshots/Tmux.png "Screenshot")

# Configuração.

#### Crontab `/etc/crontab`.

```
# For details see man 4 crontabs

# Example of job definition:
# .---------------- minute (0 - 59)
# | .------------- hour (0 - 23)
# | | .---------- day of month (1 - 31)
# | | | .------- month (1 - 12) OR jan,feb,mar,apr ...
# | | | | .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# | | | | |
# * * * * * user-name command to be executed
*/30  *     *    * *    root    /usr/bin/apt update >/dev/null 2>&1 ; pkill -RTMIN+12 dwmblocks
*/30  */3   */3  * *    alann   /home/alann/.config/scripts/wallpapers.sh >/dev/null 2>&1
*/30  *     *    * *    alann   /usr/local/bin/flexget execute > /tmp/dtest_erro.log 2>&1
```

#### Ip Fixo `/etc/network/interfaces`.

```
# Configuração de IP Fixo.
auto enp2s0
allow-hotplug enp2s0
iface enp2s0 inet static
        address 192.168.0.132
        netmask 255.255.255.0
        network 192.168.0.1
        broadcast 192.168.0.255
        gateway 192.168.0.1
```

#### Samba `/etc/samba/smb.conf`.

```
# Configuração de Compartilhamento.
[Emby]
	comment = Filmes e Series
	path = /media/Stronger/Emby
	writable = no
	guest ok = yes

```

#### Ativar o Bluetooth.

```
$ sudo systemctl enable bluetooth
$ sudo systemctl restart bluetooth
$ systemctl status bluetooth
```

#### Instalar PyPi direto do Github.

```
$ pip3 install git+https://github.com/alannssantos/mangascandl.git
```
