---
title: Progenitology Universe
layout: page
permalink: /writing/progenitology/
parent: Writing
has_toc: false
---

# Progenitology Universe

> *Humanity's story is one of expansion, of an insatiable desire to see and be so much more than they were before. They threw themselves from their planet out into the stars with no expectations for what they might find, only hoping for satisfaction. They would find so much more.*

This is collection of stories about the future, space, and the people between. In essence, this is my take on the "Future History of Mankind" idea.

- [Sorted by Post Date](#by-post-date)
- [Sorted Chronologically](#chronologically)

## By Post Date

<ul>
{% assign all = site.pages | where: "writing", "true" | where: "cat", "prog_unv" | sort: "date" %}
{% for post in all %}
<li><a href="{{ post.url }}">{{ post.title }}</a>  <time class="publish-date" datetime="{{ post.date | date: '%F' }}">{{ post.date | date: "%B %-d, %Y" }}</time></li>
{% endfor %}
</ul>

## Chronologically

- The [Port-in-Orbit Olwicks-2](../olwicks/#chronologically) series
