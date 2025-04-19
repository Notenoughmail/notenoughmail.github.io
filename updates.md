---
layout: page
title: Updates
permalink: /updates/
has_children: false
---

# Updates

<iframe hidden name=htmz onload="setTimeout(()=>document.querySelector(contentWindow.location.hash||null)?.replaceWith(...contentDocument.body.childNodes))"></iframe>

An archive of project updates, everything else will be on [another page](/writing/)

- [KubeJS TFC Updates](#kubejs-tfc-updates)
- [Precision Prospecting Updates](#precision-prospecting-updates)
- [ConfigJS Updates](#configjs-updates)
- [TFCGenViewer Updates](#tfcgenviewer-updates)

Click <a href="/hidden/updates.html#full" target=htmz>here</a> to display the full list of posts in reverse chronological order or <a href="/hidden/updates_expand.html#full" target=htmz>here</a> to also have the links expand in place, and <a href="/hidden/empty.html#full" target=htmz>here</a> to clear the list away

<div id="full"></div>

## KubeJS TFC Updates

<ul>
{% assign posts = site.posts | reverse %}
{% for post in posts %}
{% if post.kjstfc %}
<li><a href="{{ post.url }}">{{post.version | xml_escape}}</a></li>
{% endif %}
{% endfor %}
</ul>

## Precision Prospecting Updates

<ul>
{% assign posts = site.posts | reverse %}
{% for post in posts %}
{% if post.precpros %}
<li><a href="{{ post.url }}">{{post.version | xml_escape}}</a></li>
{% endif %}
{% endfor %}
</ul>

## ConfigJS Updates

<ul>
{% assign posts = site.posts | reverse %}
{% for post in posts %}
{% if post.configjs %}
<li><a href="{{ post.url }}">{{post.version | xml_escape}}</a></li>
{% endif %}
{% endfor %}
</ul>

## TFCGenViewer Updates

<ul>
{% assign posts = site.posts | reverse %}
{% for post in posts %}
{% if post.tfcgv %}
<li><a href="{{ post.url }}">{{post.version | xml_escape}}</a></li>
{% endif %}
{% endfor %}
</ul>
