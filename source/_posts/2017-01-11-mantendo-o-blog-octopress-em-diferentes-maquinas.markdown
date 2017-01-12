---
layout: post
title: "Mantendo o blog Octopress em diferentes maquinas"
date: 2017-01-11 21:38:23 -0200
comments: true
categories: 
---

Neste post, explicarei como manter o seu blog com o Octopress em diferentes lugares, ou melhor, em diferentes máquinas. 
Talvez você precisa escrever seus posts na tua estação no trabalho e ás vezes em casa por exemplo, ou talvez você tenha reinstalado
seu SO. 

Não basta apenas fazer o clone do seu repositório do Octopress do Github, pois ele apenas "clona" os "renders" do blog localmente.
O repositório Octopress no Github possui dois branchs, `source` e `master`. O branch `source` contém os fontes que são usados para gerar 
o blog, e o branch `master` possui o próprio blog. 

Quado a pasta local é criada seguindo o [Octopress Setup Guide](http://octopress.org/docs/setup), o branch master fica na subpasta _deploy. Como esta pasta começa com um underscore, ela é ignorada quando é feito o push para o repositório: `git push origin source`. Por isso é necessário seguir os seguintes passos:

### Clonando o repositório

Primeiro, crie um diretório vazio e faça um `git init` do zero:

	$ mkdir <directory> && cd <directory> && git init

Adicione o repositório remoto do seu blog e faça o `pull`do branch source:

	$ git remote add origin git@github.com:username/username.github.io.git
	$ git pull origin source
	
Crie o branch local `source` e remova o branch local `master` para evitar confusão com o branch remoto:

	$ git checkout -b source
	$ git branch -D master
	
Agora, crie o diretório vazio _deploy e sincronize com o branch remoto `master`:
	
	$ mkdir _deploy
	$ git init
	$ git remote add origin git@github.com:username/username.github.io.git
	$ git pull origin master
	
Agora já está tudo pronto para realizar o update do Blog.

Crie um novo post:

	$ rake new_post["Novo Post"]
	$ rake generate
	$ rake deploy

E não esqueça de fazer o push do branch source:
	
	$ git push origin source
