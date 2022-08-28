# Honeygain Manager

Este é uma aplicação para gerenciar o serviço [Honeygain](https://honeygain.com) no [Arch Linux](https://archlinux.org)

# Requerimentos

* archlinux
* docker >= 20.10
* systemd >= 251
* jq >= 1.5

# Instalando

1 - Faça o clone e entre na pasta:

```
git clone --single-branch https://github.com/williamcanin/honeygain-manager.git
cd honeygain-manager
```

2 - Instale o "Honeygain Manager" no **Arch Linux**:

```
make install
```

> Nota: Você terá que ter permissão de sudo

# Usando

1 - Abra o arquivo de configuração em **~/.config/honeygain-manager.conf**:

```
nano ~/.config/honeygain-manager.conf
```

* Em **EMAIL**, coloque o e-mail de login da sua conta do "Honeygain".
* Em **PASSWORD**, coloque a sua senha de login do "Honeygain"
* Em **DEVICE_NAME**, insira um nome qualquer apenas para o "Honeygain" organizar seus dispositivos.

2 - Depois de informar seus dados no arquivo de configuração, execute o comando abaixo para criar o container com as informações:

```
honeygain-manager create
```

> Nota: Sempre que você mudar as informações no arquivo "~/.config/honeygain-manager.conf", execute este comando acima.

3 - Agora, inicie o serviço do "Honeygain" manualmente:

```
systemctl --user start honeygain-manager
```

4 - Para iniciar o serviço do "Honeygain" durante o boot, faça:

```
systemctl --user enable honeygain-manager
```

5 - Caso queira parar o serviço do "Honeygain":

```
systemctl --user stop honeygain-manager
```

6 - Reiniciar o serviço do "Honeygain", execute este comando:

```
systemctl --user restart honeygain-manager
```

7 - Desabilitar o serviço do "Honeygain" no boot da máquina, faça:

```
systemctl --user disable honeygain-manager
```
