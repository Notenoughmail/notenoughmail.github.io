---
title: Updates
layout: page
permalink: /precpros/updates/
parent: Precision Prospecting
has_children: false
---

# Updates

<ul>
{% assign posts = site.posts | reverse %}
{% for post in posts %}
{% if post.precpros %}
<li><a href="{{ post.url }}">{{post.version | xml_escape}}</a></li>
{% endif %}
{% endfor %}
</ul>
