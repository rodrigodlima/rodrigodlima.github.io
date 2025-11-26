---
layout: post
title: "Changing Runlevel on CentOS7"
date: 2017-02-14 16:10:34 -0200
comments: true
categories: [Linux, CentOS, SystemAdmin]
---

Just a quick tip for those who want to change the Runlevel on CentOS7 or RHEL7.

In previous versions, such as CentOS6, you just had to edit the /etc/inittab file and change the runlevel in the following line:

	id:3:initdefault:

In the example above, the runlevel is set to <b>"3"</b>. Runlevel 3 means <b>"Full multiuser mode"</b>, that is, it starts the system normally with network support and mainly in text mode. If you want to change it to start the system with the graphical interface (KDE, Gnome, etc), just change the line above to <b>"5"</b>.

With the change from Init to Systemd starting from CentOS7 (If you want to know more about this: [Read here](http://www.tecmint.com/systemd-replaces-init-in-linux/), the way the runlevel is changed changes slightly (quite a bit actually ;-)

## Checking current runlevel

	[root@localhost ~] systemctl get-default
	multi-user.target

The multi-user.target is equivalent to runlevel "3", that is, text mode.

## Changing the runlevel

If you want to change the runlevel to graphical mode, or "runlevel 5" as it was known in previous versions:

	[root@localhost ~] systemctl set-default graphical.target

Just restart the system and you will see that it will start in graphical mode. To check the other Runlevels:

	[root@localhost ~] systemctl list-units --type=target

