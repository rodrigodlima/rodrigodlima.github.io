---
layout: post
title: "Bash Completion for MacOS Sierra"
date: 2017-01-10 18:27:40 -0200
comments: true
categories: 
---

Uma coisa que sinto falta utilizando o MacOS da Apple é o Bash Completion. Com ele instalado, me poupa bastante digitação e tempo durante 
o meu dia de trabalho. Basicamente, ele preenche automaticamente alguns comandos somente apertando a tecla "TAB". Isso é natural no bash para
completar comandos, mas as opções e demais informações você precisa digitar. Com o Bash Completion, eu consigo digitar por exemplo:

	$ ssh <TAB>

Com isso ele lista todos os hosts que eu já digitei anteriormente. Isso é muito útil no dia a dia. É claro que isso pode gerar uma pequena lentidão
na execução do comando e também consome maiores recursos do hardware, mas para mim isso vale a pena pela facilidade.

Para instalar é bem simples, você precisa usar o "Port" ou "Homebrew". Esses caras são os gerenciadores de pacotes compatíveis no MacOS. São como 
Yum e Apt em sistemas Linux.

Não vou cobrir aqui a instalação desses caras, mas vou deixar abaixo o link para caso você ainda não tenha instalado:

https://www.macports.org/

http://brew.sh/


Para instalar o Bash Completion com o Port:

$ sudo port install bash-completion

Depois de instalado, basta você inserir o seguinte conteúdo no seu .bash_profile:

	# bash-completion
	if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
    	   . /opt/local/etc/profile.d/bash_completion.sh
	fi
