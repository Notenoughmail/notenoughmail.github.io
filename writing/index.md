---
layout: page
title: Writing
permalink: /writing/
---

# Writing

One of my pastimes is writing, so I might put something up whenever I've the time and feel ✨inspired✨

Also, if you've a prompt, questions about something I've written, or otherwise want to talk to me about something here, see the [email section](/contact/#email) of the Links & Contact page. If you'd like to be credited for a prompt, let me know so and how you'd like to be credited in the email

- [All Writing](#all-writing)
- [Fiction](#fiction)
    - [Port-in-Orbit Olwicks-2](#port-in-orbit-olwicks-2)
    - [All](#all)
- [Water](#water)
- [Politics](#politics)

## Fiction

### [Progenitology Universe](progenitology/)

<div id="progenitology">
<ul>
{% assign posts = site.posts | where: "cat", "prog_unv" %}
{% for post in posts %}
<li><a href="{{ post.url }}">{{ post.title }}</a> <time class="publish-date" datetime="{{ post.date | date: '%F' }}">{{ post.date | date: "%B %-d, %Y" }}</time></li>
{% endfor %}
</ul>
</div>

#### [Port-in-Orbit Olwicks-2](olwicks/)

<div id="olwicks">
<ul>
{% assign posts = site.posts | where: "cat", "olwicks" %}
{% for post in posts %}
<li><a href="{{ post.url }}">{{ post.title }}</a> <time class="publish-date" datetime="{{ post.date | date: '%F' }}">{{ post.date | date: "%B %-d, %Y" }}</time></li>
{% endfor %}
</ul>
</div>

### All

<div id="all-fiction">
<ul>
{% assign posts = site.posts | where: "cat", "fiction" %}
{% for post in posts %}
<li><a href="{{ post.url }}">{{ post.title }}</a> <time class="publish-date" datetime="{{ post.date | date: '%F' }}">{{ post.date | date: "%B %-d, %Y" }}</time></li>
{% endfor %}
</ul>
</div>

## Water

<div id="water">
<ul>
{% assign posts = site.posts | where: "cat", "fiction" %}
{% for post in posts %}
<li><a href="{{ post.url }}">{{ post.title }}</a> <time class="publish-date" datetime="{{ post.date | date: '%F' }}">{{ post.date | date: "%B %-d, %Y" }}</time></li>
{% endfor %}
</ul>
</div>

## Politics

<div id="politics">
<ul>
{% assign posts = site.posts | where: "cat", "politics" %}
{% for post in posts %}
<li><a href="{{ post.url }}">{{ post.title }}</a> <time class="publish-date" datetime="{{ post.date | date: '%F' }}">{{ post.date | date: "%B %-d, %Y" }}</time></li>
{% endfor %}
</ul>
</div>

## All Writing

<ul>
{% assign posts = site.posts | where: "cat", "writing" %}
{% for post in posts %}
<li><a href="{{ post.url }}">{{ post.title }}</a> <time class="publish-date" datetime="{{ post.date | date: '%F' }}">{{ post.date | date: "%B %-d, %Y" }}</time></li>
{% endfor %}
</ul>
