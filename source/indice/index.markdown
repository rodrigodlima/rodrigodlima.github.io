---
layout: page
title: "Índice de Posts"
comments: false
sharing: true
footer: true
---

## Posts por Categoria

{% assign sorted_categories = site.categories | sort %}
{% for category in sorted_categories %}
  {% assign category_name = category[0] %}
  {% assign posts = category[1] %}

### {{ category_name }}
  {% for post in posts %}
  - [{{ post.title }}]({{ post.url }}) - {{ post.date | date: "%d/%m/%Y" }}
  {% endfor %}
{% endfor %}

---

## Posts por Ano

{% for post in site.posts %}
  {% assign current_year = post.date | date: "%Y" %}
  {% assign current_month = post.date | date: "%B %Y" %}

  {% if current_year != previous_year %}
### {{ current_year }}
    {% assign previous_year = current_year %}
  {% endif %}

- **{{ post.date | date: "%d/%m" }}** - [{{ post.title }}]({{ post.url }})
{% endfor %}
