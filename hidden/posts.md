---
layout: default
title: Every Post
nav_exclude: true
search_exclude: true
---

<div id="full">
<h2>Posts</h2>
<ul class="posts">
    {% for post in site.posts %}
        <li class="posts">
            <a href="{{ post.url }}">{{ post.title }}</a>
            <time class="publish-date" datetime="{{ post.date | date: '%F' }}">
                {{ post.date | date: "%B %-d, %Y" }}
            </time>
        </li>
    {% endfor %}
</ul>
</div>