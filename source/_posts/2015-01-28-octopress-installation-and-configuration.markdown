---
layout: post
title: "Octopress Installation and Configuration"
date: 2015-01-28 11:40:58 -0200
comments: true
categories: [Octopress, Tutorial, Blogging, Git]
---

I usually use 2 or 3 devices to write my posts, I use my work laptop, my personal MacBook and sometimes my computer at home. With that, I thought it would be interesting to make my blog code available on some virtual cloud drive, so I can post any article on any device I'm using, just needing to have it configured for that task. Since I've been using Dropbox for a while, I thought it would be interesting to keep my blog there.

The objective here is to explain the installation and configuration process of Octopress. Most of the steps here are in the official Octopress documentation, but there are some extra details that I had some trouble with and it's important to highlight here.

Let's go then.

** Install Octopress dependencies: **

> $ sudo yum install git ruby rubygems ruby-devel

In the Octopress documentation it is suggested to install some ExecJS runtime JavaScript. One of them is nodejs. In the case of Fedora, it is necessary to install the RPM package, just installing the Gem doesn't work. It is also necessary to have the EPEL repository installed and configured.

>$ sudo yum install nodejs

** Download the latest version of Octopress **

Note: Download directly to your Dropbox directory, usually in ~/Dropbox

>$ pwd

> /home/rodrigo.lima/Dropbox/Blog

>$ cd octopress/

>$ pwd

>/home/rodrigo.lima/Dropbox/Blog/octopress


** Also install some necessary Ruby dependencies: **

>$ gem install execjs

>$ gem install bundler

>$ bundle install

** Install and configure the default Octopress theme **

>$ rake install

Ok, Octopress is now ready to be used.
The next step in the documentation is how to deploy the site. There are several ways to deploy, but I chose to deploy on Github. Github offers a free hosting service, and I didn't see the need to use or hire a VPS from some provider, since with Octopress I won't need a database (Mysql, etc.), that is, only static pages will be generated and for that Github is more than enough.

### Deploying to Github Pages

If you don't have one yet, you'll need to create a Github account. Do this if you don't have one.
My Github username is rodrigodlima, so it will make my blog available at http://rodrigodlima.github.io. In the old days, it was made available on the ".com" domain, but now it uses ".io".

Create a new repository in the following format: username.github.io, where username is your Github username. In my case, it was rodrigodlima.github.io. If you have a registered domain, Github offers a way to point your domain there, I'll explain better how to do this later.

Now, let's start to see some advantages in using Octopress. It already provides some scripts to facilitate configuration. So, run:

>$ rake setup_github_pages

The script will ask you for the URL of your git repository, so provide it as requested. Ex: git@github.com:rodrigodlima/rodrigodlima.github.io.git.

**Important:** It is necessary to insert your public SSH key to be able to deploy. If you don't have a public SSH key, consult the Github documentation to insert your key:

https://help.github.com/articles/generating-ssh-keys/


On both Fedora 20 and CentOS 7 I needed to edit the Octopress GemFile and add the following:

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



Without this line, the "rake generate" command throws an error.

Now yes:

>$ rake generate

>$ rake deploy

These two commands will generate the blog and make the first commit to Github. However, you now need to generate a new post to be published. And now comes the advantage of using Octopress. It's very simple to create a new post. Want to see?

## Creating the first post

To create a new post is very simple:

	$ rake new_post["Octopress Installation and Configuration"]
	mkdir -p source/_posts
	Creating new post: source/_posts/2015-01-28-octopress-installation-and-configuration.markdown

See that it created the post in the path source/_posts/2015-01-28-octopress-installation-and-configuration.markdown. Now you just need to edit the file with your preferred markdown editor. I use Remarkable:

[Remarkable](http://remarkableapp.net/download.html)

After making the edits you want, save the file. And now you just need to generate the page and send it to Github. These two commands below do this for you:

>$ rake generate

>$ rake deploy

Every time you want to create a new post, follow these steps. Simple isn't it? ;-)

### Custom Domains

As I mentioned at the beginning of the post, Github offers a way to customize your domain, if you wish. For example, I have the domain rodrigolima.blog.br registered and I would like my "blog" that we just saw hosted on Github, to be accessed through my domain "rodrigolima.blog.br". It's very simple to do and it's also in the Octopress documentation.

> echo 'rodrigolima.blog.br' >> source/CNAME

Now, create an "A" record on your DNS server pointing to IP 192.30.252.153 or 192.30.252.154 which are Github's IPs
