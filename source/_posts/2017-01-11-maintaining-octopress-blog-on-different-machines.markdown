---
layout: post
title: "Maintaining Octopress Blog on Different Machines"
date: 2017-01-11 21:38:23 -0200
comments: true
categories: [Octopress, Tutorial, Blogging, Git]
---

In this post, I will explain how to maintain your blog with Octopress in different places, or rather, on different machines.
Maybe you need to write your posts on your workstation at work and sometimes at home for example, or maybe you have reinstalled your OS.

It is not enough to just clone your Octopress repository from Github, as it only "clones" the blog "renders" locally.
The Octopress repository on Github has two branches, `source` and `master`. The `source` branch contains the sources that are used to generate the blog, and the `master` branch contains the blog itself.

When the local folder is created following the [Octopress Setup Guide](http://octopress.org/docs/setup), the master branch is in the _deploy subfolder. Since this folder starts with an underscore, it is ignored when pushing to the repository: `git push origin source`. That's why it's necessary to follow these steps:

### Cloning the repository

First, create an empty directory and do a `git init` from scratch:

	$ mkdir <directory> && cd <directory> && git init

Add the remote repository of your blog and do a `pull` of the source branch:

	$ git remote add origin git@github.com:username/username.github.io.git
	$ git pull origin source

Create the local `source` branch and remove the local `master` branch to avoid confusion with the remote branch:

	$ git checkout -b source
	$ git branch -D master

Now, create the empty _deploy directory and sync with the remote `master` branch:

	$ mkdir _deploy
	$ git init
	$ git remote add origin git@github.com:username/username.github.io.git
	$ git pull origin master

Now everything is ready to update the Blog.

Create a new post:

	$ rake new_post["New Post"]
	$ rake generate
	$ rake deploy

And don't forget to push the source branch:

	$ git push origin source
