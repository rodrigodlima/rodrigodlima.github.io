---
layout: post
title: "Immutable Infrastructure in GCP"
date: 2025-11-27 09:06:58 -0300
comments: true
categories: [DevOps, GCP, Infrastructure, IaC]
---

Do you know what Immutable Infrastructure is? If you don't, I think you should ;-)

Let me explain a bit about it.

Immutable infrastructure is an infrastructure paradigm in which servers are never modified after they're deployed. If something needs to be updated, fixed, or modified in any way, new servers built from a common image with the appropriate changes are provisioned to replace the old ones. After they're validated, they're put into use and the old ones are decommissioned[^1].

I created a code example for it in my GitHub account. There is complete documentation in the repository's markdown files.

[GitHub repository](https://github.com/rodrigodlima/immutable-Infrastructure)

---

## References

[^1]: [What is Immutable Infrastructure? - Hazel Virdó](https://www.digitalocean.com/community/tutorials/what-is-immutable-infrastructure)