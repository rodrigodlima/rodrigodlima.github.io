---
layout: post
title: "Eliminando arquivos não gerenciados pelo Puppet"
date: 2018-03-01 21:34:54 -0300
comments: true
categories: DevOps Puppet
---

# Dica sobre Puppet

Você sabe o que é o Puppet? Caso você seja um Sysadmin ou um Dev sugiro fortemente que comece a estudar sobre. O Puppet é um utilitário de gerenciamento de configuração de software. O desenvolvimento do Puppet é coordenado pela Puppet Labs. Segue o link: [https://puppet.com/](https://puppet.com/).

Não vou me aprofundar sobre os conceitos, vou apenas colocar uma dica que pode ser útil em algumas situações.

Você possui vários arquivos de configurações de vhosts do Apache gerenciados pelo Puppet, por exemplo, mas não quer que sejam criados novos arquivos manualmente no qual esses arquivos não sejam orquestrados/gerenciados pelo Puppet, pois com isso você poderia perder o controle do que está sendo colocado em produção.

Para resolver isso, existe um atributo que pode nos ajudar com isso, e esse atributo é do resource type "file", o **purge**

		file { '/etc/httpd/confs.d': 
        	ensure  => 'directory', 
        	recurse => true, 
        	purge   => true, 
		} 
		
		file { '/etc/httpd/confs.d/www.conf':
			ensure => 'present',
			source => 'puppet://modules/httpd/www.conf',
		} 

Com essa configuração acima, o Puppet irá manter no diretório /etc/httpd/confs.d apenas o arquivo www.conf. Todos arquivos criados manualmente serão removidos após o agente realizar a comunicação com o Puppet server. 


