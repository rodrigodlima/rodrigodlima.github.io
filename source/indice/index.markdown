---
layout: page
title: "Posts Index"
comments: false
sharing: true
footer: true
---

## Posts by Category

{% assign sorted_categories = site.categories | sort %}
{% for category in sorted_categories %}
  {% assign category_name = category[0] %}
  {% assign posts = category[1] %}

### {{ category_name }}
  {% for post in posts %}
  - [{{ post.title }}]({{ post.url }}) - {{ post.date | date: "%m/%d/%Y" }}
  {% endfor %}
{% endfor %}

---

## Posts by Year

{% for post in site.posts %}
  {% assign current_year = post.date | date: "%Y" %}
  {% assign current_month = post.date | date: "%B %Y" %}

  {% if current_year != previous_year %}
### {{ current_year }}
    {% assign previous_year = current_year %}
  {% endif %}

- **{{ post.date | date: "%m/%d" }}** - [{{ post.title }}]({{ post.url }})
{% endfor %}
