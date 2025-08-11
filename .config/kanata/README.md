# [Kanata](https://github.com/jtroo/kanata) (Configurador de teclado)
### Requisitos
* Ainda não tem binário nos repositórios do debian (Instalação tem que ser feita manualmente.).
* O uso do crontab é temporário, o correto seria colocar para rodar em um serviço do systemd.
### Crontab `/etc/crontab`.
```bash
echo "@reboot    root    $(which kanata) -c $HOME/.config/kanata/config.kbd > /tmp/dtest_erro.log 2>&1" | sudo tee -a /etc/crontab
```
