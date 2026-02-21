---
layout: page
title: Writing
permalink: /writing/
top: true
---

# Writing

One of my pastimes is writing, so I might put something up whenever I've the time and feel ✨inspired✨

Also, if you've a prompt, questions about something I've written, or otherwise want to talk to me about something here, see the [email section](/contact/#email) of the Links & Contact page. If you'd like to be credited for a prompt, let me know so and how you'd like to be credited in the email

- [All Writing](#all-writing)
- [Fiction](#fiction)
    - [Port-in-Orbit Olwicks-2](#port-in-orbit-olwicks-2)
    - [All](#all-fiction)
- [Water](#water)
- [Politics](#politics)

## Fiction

### [Progenitology Universe](progenitology/)

{% assign posts = site.pages | where: "writing", "true" | sort: "date" %}

<div id="progenitology">
<ul>
{% for post in posts %}
{% if post.cat contains "prog_unv" %}
<li><a href="{{ post.url }}">{{ post.title }}</a> <time class="publish-date" datetime="{{ post.date | date: '%F' }}">{{ post.date | date: "%B %-d, %Y" }}</time></li>
{% endif %}
{% endfor %}
</ul>
</div>

#### [Port-in-Orbit Olwicks-2](olwicks/)

<div id="olwicks">
<ul>
{% for post in posts %}
{% if post.cat contains "olwicks" %}
<li><a href="{{ post.url }}">{{ post.title }}</a> <time class="publish-date" datetime="{{ post.date | date: '%F' }}">{{ post.date | date: "%B %-d, %Y" }}</time></li>
{% endif %}
{% endfor %}
</ul>
</div>

### All Fiction

<div id="all-fiction">
<ul>
{% for post in posts %}
{% if post.cat contains "fiction" %}
<li><a href="{{ post.url }}">{{ post.title }}</a> <time class="publish-date" datetime="{{ post.date | date: '%F' }}">{{ post.date | date: "%B %-d, %Y" }}</time></li>
{% endif %}
{% endfor %}
</ul>
</div>

## Water

<div id="water">
<ul>
{% for post in posts %}
{% if post.cat contains "water" %}
<li><a href="{{ post.url }}">{{ post.title }}</a> <time class="publish-date" datetime="{{ post.date | date: '%F' }}">{{ post.date | date: "%B %-d, %Y" }}</time></li>
{% endif %}
{% endfor %}
</ul>
</div>

## Politics

<div id="politics">
<ul>
{% for post in posts %}
{% if post.cat contains "politics" %}
<li><a href="{{ post.url }}">{{ post.title }}</a> <time class="publish-date" datetime="{{ post.date | date: '%F' }}">{{ post.date | date: "%B %-d, %Y" }}</time></li>
{% endif %}
{% endfor %}
</ul>
</div>

## All Writing

<ul>
{% for post in posts %}
<li><a href="{{ post.url }}">{{ post.title }}</a> <time class="publish-date" datetime="{{ post.date | date: '%F' }}">{{ post.date | date: "%B %-d, %Y" }}</time></li>
{% endfor %}
</ul>
