---
layout: post
title: "Alterando o Runlevel no CentOS7"
date: 2017-02-14 16:10:34 -0200
comments: true
categories: Linux
---

Apenas uma pequena dica para quem deseja alterar o Runlevel no CentOS7 ou RHEL7. 

Nas versões anteriores, como por exemplo no CentOS6, bastava editar o arquivo /etc/initab e alterar o runlevel na seguinte linha:

	id:3:initdefault:

No exemplo acima, o runlevel está setado para <b>"3"</b>. O runlevel 3 significa <b>"Full multiuser mode"</b>, ou seja, inicia o sistema normalmente com suporte a rede e principalmente em modo texto. Caso deseje alterar para iniciar o sistema com a interface gráfica (KDE, Gnome, etc), basta alterar a linha acima para <b>"5"</b>.

Com a mudança do Init para Systemd apartir do CentOS7 (Caso queira saber mais sobre isso: [Leia aqui](http://www.tecmint.com/systemd-replaces-init-in-linux/), a maneira como é alterado o runlevel muda ligeiramente (bastante na real ;-) 

## Verificando runlevel atual

	[root@localhost ~] systemctl get-default
	multi-user.target
 
 O multi-user-agent equivale ao runlevel "3", ou seja, modo texto.
 
## Alterando o runlevel

Caso você queria mudar o runlevel para o modo gráfico, ou "runlevel 5" como era conhecido nas versões anteriores:

	[root@localhost ~] systemctl set-default graphical.target

Basta reiniciar o sistema que você verá que iniciará em modo gráfico. Para verificar os outros Runlevels:

	[root@localhost ~] systemctl list-units --type=target
 
 