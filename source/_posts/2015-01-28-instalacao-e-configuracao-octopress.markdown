---
layout: post
title: "Instalação e Configuração Octopress"
date: 2015-01-28 11:40:58 -0200
comments: true
categories: 
---

Eu utilizo geralmente 2 ou 3 equipamentos para escrever meus posts, utilizo meu notebook do trabalho, meu MacBook pessoal e por vezes meu computador em casa. Com isso, achei interessante disponibilizar o código do meu blog em algum drive virtual na nuvem, assim eu consigo postar qualquer artigo em qualquer dispositivo que estiver utilizando, bastando apenas deixá-lo configurado para tal tarefa. Como já utilizo o Dropbox a algum tempo, achei interessante manter meu blog lá. 

O objetivo aqui é explicar o processo de instalação e configuração do Octopress. A maioria dos passos aqui estão na documentação oficial do Octopress, porém tem alguns detalhes a mais no qual passei algum trabalho e é importante destacar aqui.

Vamos lá então. 

** Instalar as dependências do Octopress: **

> $ sudo yum install git ruby rubygems ruby-devel
 
Na documentação do Octopress é sugerido a instalação de algum ExecJS runtime JavaScript. Um deles é o nodejs. No caso do Fedora, é necessário instalar o pacote RPM, apenas instalando o Gem não funciona. É necessário também ter instalado e configurado o repositório EPEL

>$ sudo yum install nodejs

** Baixar a última versão do Octopress **

Obs: Já baixar diretamente no seu diretório do Dropbox, geralmente em ~/Dropbox

>$ pwd

> /home/rodrigo.lima/Dropbox/Blog

>$ cd octopress/

>$ pwd

>/home/rodrigo.lima/Dropbox/Blog/octopress


** Instalar também algumas dependências do Ruby necessárias: **

>$ gem install execjs

>$ gem install bundler

>$ bundle install

** Instalar e configurar agora o tema default do Octopress **

>$ rake install

Ok, o Octopress neste momento está pronto para ser utilizado.
O próximo passo da documentação é como fazer o deploy do site. Existem algumas várias formas de se fazer o deploy, mas escolhi fazer o deploy no Github. O Github oferece um serviço de hospedagem free, e não vi necessidade de utilizar ou contratar um VPS em algum provedor, já que com o Octopress não irei precisar de banco de dados (Mysql, etc.), ou seja, será gerado apenas páginas estáticas e para isso o Github está mais do que suficiente.

### Fazendo o deploy para o Github Pages

Caso você ainda não possua, terá que criar uma conta do Github. Faça isso caso você não tenha. 
Meu usuário no Gitbug é rodrigodlima, logo, ele irá disponibilizar meu blog em http://rodrigodlima.github.io. Antigamente, ele disponibilizada no domínio ".com", porém agora utiliza o ".io".

Crie um novo repositório no seguinte formato: username.github.io, onde username é o seu usuário no Github. No meu caso, ficou rodrigodlima.github.io. Caso você tenha algum domínio registrado, o Github oferece uma forma de apontar o seu domínio para lá, depois explico melhor como fazer isso.

Agora, vamos começar a ver algumas vantagens em utilizar o Octopress. Ele já disponibiliza alguns scripts para facilitar a configuração. Então, execute:

>$ rake setup_github_pages

O script irá solicitar a você a URL do seu repositório git, com isso informe conforme solicitado. Ex: git@github.com:rodrigodlima/rodrigodlima.github.io.git.

**Importante:** É necessário inserir a sua chave pública SSH para conseguir fazer o deploy. Caso você não possua uma chave pública SSH, consulte a documentação do Github para inserir a sua chave: 

https://help.github.com/articles/generating-ssh-keys/


Tanto no Fedora 20 como no CentOS 7 eu precisei editar o arquivo GemFile do Octopress e adicionar o seguinte:

	 gem 'json'

> $ cat Gemfile


	source "https://rubygems.org"
	group :development do
		gem 'rake', '~> 10.0'
		gem 'jekyll', '~> 2.0'
		gem 'octopress-hooks', '~> 2.2'
		gem 'octopress-date-format', '~> 2.0'
		gem 'jekyll-sitemap'
		gem 'rdiscount', '~> 2.0'
		gem 'json'
		gem 'RedCloth', '~> 4.2.9'
		gem 'haml', '~> 4.0'
		gem 'compass', '~> 1.0.1'
		gem 'sass-globbing', '~> 1.0.0'
		gem 'rubypants', '~> 0.2.0'
		gem 'rb-fsevent', '~> 0.9'
		gem 'stringex', '~> 1.4.0'
	end
		gem 'sinatra', '~> 1.4.2'



Sem essa linha, dá erro no comando "rake generate".

Agora sim:

>$ rake generate

>$ rake deploy

Esses dois comandos irão gerar o blog e fazer o primeiro commit para o Github. Porém, você precisa agora gerar um novo post para que seja publicado. E agora vem a vantagem de utilizar o octopress. É muito simples criar um novo post. Quer ver?

## Criando o primeiro post 

Para criar um novo post é muito simples:

	$ rake new_post["Instalação e Configuração Octopress"]
	mkdir -p source/_posts
	Creating new post: source/_posts/2015-01-28-instalacao-e-configuracao-octopress.markdown

Veja que ele criou o post no caminho source/_posts/2015-01-28-instalacao-e-configuracao-octopress.markdown. Agora basta você editar o arquivo com o seu editor preferdo de markdown. Eu utilizo o Ramarkable:

[Remarkable](http://remarkableapp.net/download.html) 

Após fazer a edição que você deseja, salve o arquivo. E agora basta gerar a página e enviar ao Gitbub. Esses dois comandos abaixo fazem isso pra você:

>$ rake generate

>$ rake deploy
	
Cada vez que quiser criar um novo post, siga esses passos. Simples não? ;-)

### Custom Domains

Conforme citei no começo do post, o Github oferece uma forma de customizar o seu domínio, caso você deseje. Por exemplo, eu possuo o domínio rodrigolima.blog.br registrado e gostaria que meu "blog" que acabamos de ver hospedados no Github, seja acessado através do meu domínio "rodrigolima.blog.br". É muito simples de fazer e também está da documentação do Octopress.

> echo 'rodrigolima.blog.br' >> source/CNAME

Agora, crie um registro "A" no seu DNS server apontando para o IP 192.30.252.153 ou 192.30.252.154 que são os IP's do Github