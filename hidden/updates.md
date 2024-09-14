---
layout: none
title: Every Post
nav_exclude: true
search_exclude: true
---

<div id="full">
<h2>Updates</h2>
<ul class="posts">
    {% assign posts = site.posts | where:"cat","update" %}
    {% for post in posts %}
        <li class="posts">
            <a href="{{ post.url }}">{{ post.title }}</a>
            <time class="publish-date" datetime="{{ post.date | date: '%F' }}">
                {{ post.date | date: "%B %-d, %Y" }}
            </time>
        </li>
    {% endfor %}
</ul>
</div>
