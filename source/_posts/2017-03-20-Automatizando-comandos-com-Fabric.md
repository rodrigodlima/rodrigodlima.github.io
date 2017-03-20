---
layout: post
title: "Automatizando comandos com Fabric"
date: 2017-03-20 15:43:21 -0300
comments: true
categories: Devops Linux SSH
---


Este post é apenas uma dica de como automatizar algumas tarefas remotamente em servidores Linux. 
Hoje em dia, automatizar tarefas é algo extremamente necessário em grandes ambientes e até em pequenos, para evitar trabalho e perda de tempo.
Costumo usar o Puppet como gerenciamento de configuração do meu ambiente, juntamente com Github para controle de versões das confs dos servidores. Já se foi o tempo que o Git era utilizado apenas por desenvolvedores, hoje o pessoal de Infra tem usado muito, seguindo o conceito de DevOPS. 

Só que o Puppet tem algumas limitações, digamos assim, para execução de comandos remotos. As vezes você quer apenas dar um "restart" em algum daemon nos seus servidores. Isso não é problema caso você possua uns dois ou 3 servidores, mas já imaginou fazer isso em uns 200 servidores? Vai levar um certo tempinho até você terminar isso né? Aí que entra o [Fabric](http://www.fabfile.org/). O Python é uma biblioteca Python e um utilitário de linha de comando que utiliza o SSH para executar tarefas administrativas remotamente.

Existe uma boa documentação no site do [Fabric](http://www.fabfile.org/), mas o objetivo aqui é só demonstrar um exemplo prático de como utilizar ele para executar algumas tarefas remotamente.

Antes de começarmos, a instalação do Fabric pode ser efetuado com o comando pip:
	
	# pip install fabric
	
Você define as tarefas que você vai querer executar em um arquivo, chamado "fabfile.py". Você pode definir várias "funções" nesse arquivo, e depois você apenas "chama" essa função desejada, o que torna bem mais simples definir várias tasks sem a necessidade de estar editando o arquivo para cada execução.

Aqui, um exemplo do conteúdo do arquivo *fabfile.py*:

	from fabric.api import run, sudo, env, settings, 	hide, parallel
	from fabric.colors import yellow, green
	def host_type():
    run('uname -s')
    
	def read_hosts():
    """
    Reads hosts from sys.stdin line by line, expecting 	one host per line.
    """
    import sys
    env.hosts = [line.strip() for line in sys.stdin.readlines()]
    t) 
    @parallel
    
    def restart_nginx():
  	sudo('systemctl restart nginx')
	@parallel

Só explicando um pouco o exemplo acima. A função host_type, caso chamada, irá executar o comando *uname -s* em todos os servidores e irá retornar a saída para o terminal. A segunda função é uma boa opção caso você tenha uma lista dos hostnames ou IPS dos seus servidores em um arquivo txt por exemplo, no qual ele irá ler linha por linha do arquivo e executar o comando remotamente no servidor correspondente. Importante salientar, é necessário que você tenha a sua chave pública SSH exportada em todos os servidores, para que não seja exigido senha no momento da conexão.

Agora, vamos chamar o Fabric para verificar o hostname de todos os servidores que estão listados no arquivo servers.txt por exemplo:
	
	# cat servers.txt |fab read_hosts host_type -P
	
	[server1] Executing task 	'host_type'
	[server2] Executing task 	'host_type'
	[server1] run: uname -s
	[server2] run: uname -s
	[server1] out: Linux
	[server1] out:

	[server2] out: Linux
	[server2] out:


	Done.

O comando acima executa um *cat* no arquivo servers.txt redirecionando saída para o *fab* ao qual executa a função *read_hosts* (que lê cada linha do arquivo *servers.txt* juntamente com a função *host_type*. O conteúdo do arquivo servers.txt possui o hostname ou o endereço IP dos servidores ao qual o Fab irá executar a função desejada.

A saída para cada consulta é exibido na linha com o hostname do server e mais "out":
	
	[server1] out: Linux
	
Obs: O parâmetro "-P" no comando diz que o comando será executado paralelamente, ou seja, ele irá executar o comando ao mesmo tempo em todos os servidores.

Era isso pessoal, é um artigo curto, mas tem o objetivo apenas de apresentar essa pequenha ferramenta que pode fazer toda a diferença no seu dia a dia. A documentação é bem completa e você poderá encontrar diversos exemplos de como montar as suas tasks...

;-)
	