---
layout: post
title: "Automating Commands with Fabric"
date: 2017-03-20 15:43:21 -0300
comments: true
categories: [DevOps, Fabric, Python, Automation, Linux, SSH]
---


This post is just a tip on how to automate some tasks remotely on Linux servers.
Nowadays, automating tasks is extremely necessary in large environments and even in small ones, to avoid work and waste of time.
I usually use Puppet as configuration management for my environment, along with Github for version control of server configurations. Gone are the days when Git was used only by developers, today infrastructure people have used it a lot, following the DevOps concept.

However, Puppet has some limitations, so to speak, for executing remote commands. Sometimes you just want to restart some daemon on your servers. This is not a problem if you have two or three servers, but have you imagined doing this on 200 servers? It will take quite a while until you finish this, right? That's where [Fabric](http://www.fabfile.org/) comes in. Fabric is a Python library and command-line utility that uses SSH to execute administrative tasks remotely.

There is good documentation on the [Fabric](http://www.fabfile.org/) website, but the objective here is just to demonstrate a practical example of how to use it to execute some tasks remotely.

Before we start, the installation of Fabric can be done with the pip command:

	# pip install fabric

You define the tasks you want to execute in a file called "fabfile.py". You can define multiple "functions" in this file, and then you just "call" the desired function, which makes it much simpler to define multiple tasks without the need to be editing the file for each execution.

Here, an example of the content of the *fabfile.py* file:

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

Just explaining a bit about the example above. The host_type function, when called, will execute the *uname -s* command on all servers and will return the output to the terminal. The second function is a good option if you have a list of hostnames or IPs of your servers in a txt file for example, which it will read line by line from the file and execute the command remotely on the corresponding server. It's important to note, you need to have your public SSH key exported to all servers, so that no password is required at the time of connection.

Now, let's call Fabric to check the hostname of all servers that are listed in the servers.txt file for example:

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

The above command executes a *cat* on the servers.txt file redirecting the output to *fab* which executes the *read_hosts* function (which reads each line of the *servers.txt* file) together with the *host_type* function. The content of the servers.txt file contains the hostname or IP address of the servers on which Fab will execute the desired function.

The output for each query is displayed on the line with the server hostname and "out":

	[server1] out: Linux

Note: The "-P" parameter in the command means that the command will be executed in parallel, that is, it will execute the command at the same time on all servers.

That's it folks, it's a short article, but it only aims to present this little tool that can make all the difference in your day to day. The documentation is very complete and you will be able to find several examples of how to assemble your tasks...

;-)

