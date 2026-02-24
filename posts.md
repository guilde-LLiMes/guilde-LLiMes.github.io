---
title: Articles
layout: default
nav_order: 99
description: Articles and updates about guide-LLiMes
---

# Articles

Updates, tutorials, and thoughts on building effective LLM guidelines.

{% assign posts = site.posts | sort: date | reverse %}
{% for post in posts %}
<article class="post-preview">
  <h2>
    <a href="{{ post.url }}">{{ post.title }}</a>
  </h2>
  <div class="post-meta">
    <time>{{ post.date | date: "%B %d, %Y" }}</time>
    {% if post.author %}
    <span> · {{ post.author }}</span>
    {% endif %}
  </div>
  {% if post.excerpt %}
  <p class="post-excerpt">{{ post.excerpt | strip_html | truncatewords: 40 }}</p>
  {% endif %}
</article>
{% endfor %}

{% if posts.size == 0 %}
<p><em>No articles yet. Check back soon!</em></p>
{% endif %}
