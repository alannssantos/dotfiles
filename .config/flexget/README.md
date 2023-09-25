# Flexget install

#### Requisitos

```
$ pip3 install flexget==3.1.50
$ sudo apt install python3-libtorrent
$ pip3 install transmission-rpc
```

#### Crontab `/etc/crontab`.

```bash
echo "*/30 *  * * *   $USER   $HOME/.local/bin/flexget execute > /tmp/dtest_erro.log 2>&1" | sudo tee -a /etc/crontab
```

#### Editar o arquivo `~/.config/flexget/config.yml`.

```
Definir os destinos dos donwloads.

Testar se RSS estão validos.

$ flexget --test execute

```
