---
title: Updates
layout: page
permalink: /configjs/updates/
parent: ConfigJS
has_children: false
---

# Updates

<ul>
{% assign posts = site.posts | reverse %}
{% for post in posts %}
{% if post.configjs %}
<li><a href="{{ post.url }}">{{ post.version | xml_escape }}</a></li>
{% endif %}
{% endfor %}
</ul>
