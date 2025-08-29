## Transmission-deamon install
### Requisitos
`$ sudo apt install transmission-daemon`
### Configuração
- Parar o Transmission `$ sudo service transmission-daemon stop` antes de editar.
- Modifique o USER pelo nome do seu usuario no arquivo `$ sudo vim /lib/systemd/system/transmission-daemon.service`.
```
[Unit]
Description=Transmission BitTorrent Daemon
After=network.target

[Service]
User=USER
Type=notify
ExecStart=/usr/bin/transmission-daemon -f --log-error
ExecStop=/bin/kill -s STOP $MAINPID
ExecReload=/bin/kill -s HUP $MAINPID

[Install]
WantedBy=multi-user.target
```
- Arquivo padrão fica `~/.config/transmission-daemon/settings.json`.
- Definir destino de downloads padrão e caminho do script pois downloads (Caminho absoluto).
- Iniciar Transmission `$ sudo service transmission-daemon start`.
