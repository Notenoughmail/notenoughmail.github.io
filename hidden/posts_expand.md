---
layout: none
title: Every Post
nav_exclude: true
search_exclude: true
---

<div id="full">
<h2>Posts</h2>
<ul class="posts" id="full">
    {% for post in site.posts %}
        <li class="posts">
            <a href="{{ post.url }}/field?class=main-content-wrap#inline-{{ post.ref }}" target=htmz>{{ post.title }}</a>
            <time class="publish-date" datetime="{{ post.date | date: '%F' }}">{{ post.date | date: "%B %-d, %Y" }}</time>
            <div id="inline-{{ post.ref }}"></div>
        </li>
    {% endfor %}
</ul>
</div>