---
title: Updates
layout: page
permalink: /kubejs_tfc/updates/
parent: KubeJS TFC
has_children: false
---

# Updates

<ul>
{% assign posts = site.posts | reverse %}
{% for post in posts %}
{% if post.kjstfc %}
<li><a href="{{ post.url }}">{{post.version | xml_escape}}</a></li>
{% endif %}
{% endfor %}
</ul>
