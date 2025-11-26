---
layout: post
title: "Removing Unmanaged Files with Puppet"
date: 2018-03-01 21:34:54 -0300
comments: true
categories: [DevOps, Puppet, Linux, Configuration Management]
---


Do you know what Puppet is? If you're a Sysadmin or a Dev, I strongly suggest you start learning about it. Puppet is a software configuration management utility. Puppet's development is coordinated by Puppet Labs. Here's the link: [https://puppet.com/](https://puppet.com/).

I won't go deep into the concepts, I'll just share a tip that can be useful in some situations.

You have multiple Apache vhost configuration files managed by Puppet, for example, but you don't want new files to be created manually that aren't orchestrated/managed by Puppet, as this could cause you to lose control of what's being deployed to production.

To solve this, there's an attribute that can help us with this, and it's from the "file" resource type: **purge**

	file { '/etc/httpd/confs.d':
    	ensure  => 'directory',
    	recurse => true,
    	purge   => true,
	}

	file { '/etc/httpd/confs.d/www.conf':
		ensure => 'present',
		source => 'puppet://modules/httpd/www.conf',
	}

With the above configuration, Puppet will maintain only the www.conf file in the /etc/httpd/confs.d directory. All manually created files will be removed after the agent communicates with the Puppet server.
