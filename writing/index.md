---
layout: page
title: Writing
permalink: /writing/
---

# Writing

One of my pastimes is writing, so I might put something up whenever I've the time and feel ✨inspired✨

- [All Writing](#all-writing)
- [Fiction](#fiction)
    - [Port-in-Orbit Olwicks-2](#port-in-orbit-olwicks-2)
    - [All](#all)
- [Water](#water)
- [politics](#politics)

## Fiction

### Port-in-Orbit Olwicks-2

<div id="olwicks">
<ul>
{% assign posts = site.posts | where:"tags","Port-in-Orbit Olwicks-2" %}
{% for post in posts %}
<li><a href="{{ post.url }}">{{ post.title }}</a> <time class="publish-date" datetime="{{ post.date | date: '%F' }}">{{ post.date | date: "%B %-d, %Y" }}</time></li>
{% endfor %}
</ul>
</div>

### All

<div id="all-fiction">
<ul>
{% assign posts = site.posts | where:"tags","Fiction" %}
{% for post in posts %}
<li><a href="{{ post.url }}">{{ post.title }}</a> <time class="publish-date" datetime="{{ post.date | date: '%F' }}">{{ post.date | date: "%B %-d, %Y" }}</time></li>
{% endfor %}
</ul>
</div>

## Water

<div id="water">
<ul>
{% assign posts = site.posts | where:"tags","Water" %}
{% for post in posts %}
<li><a href="{{ post.url }}">{{ post.title }}</a> <time class="publish-date" datetime="{{ post.date | date: '%F' }}">{{ post.date | date: "%B %-d, %Y" }}</time></li>
{% endfor %}
</ul>
</div>

## Politics

<div id="politics">
<ul>
{% assign posts = site.posts | where:"tags","Politics" %}
{% for post in posts %}
<li><a href="{{ post.url }}">{{ post.title }}</a> <time class="publish-date" datetime="{{ post.date | date: '%F' }}">{{ post.date | date: "%B %-d, %Y" }}</time></li>
{% endfor %}
</ul>
</div>

## All Writing

<ul>
{% assign posts = site.posts | where:"cat","writing" %}
{% for post in posts %}
<li><a href="{{ post.url }}">{{ post.title }}</a> <time class="publish-date" datetime="{{ post.date | date: '%F' }}">{{ post.date | date: "%B %-d, %Y" }}</time></li>
{% endfor %}
</ul>