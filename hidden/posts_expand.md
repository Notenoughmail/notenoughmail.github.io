---
layout: none
title: Every Post
nav_exclude: true
search_exclude: true
---

<div id="full">
<iframe hidden name="htmz_inner" onload="setTimeout(() => {
function getChildren(body) {
    let children = body.getElementsByClassName('main')[0]?.getElementsByClassName('main-content-wrap')[0]?.childNodes;
    if (children) {
        return children;
    }
    return body.childNodes;
}
document
    .querySelector(contentWindow.location.hash || null)
    ?.replaceWith(...getChildren(contentDocument.body));
})"></iframe>
<h2>Posts</h2>
<ul class="posts" id="full">
    {% for post in site.posts %}
        <li class="posts">
            <a href="{{ post.url }}#inline-{{ post.ref }}" target=htmz_inner>{{ post.title }}</a>
            <time class="publish-date" datetime="{{ post.date | date: '%F' }}">{{ post.date | date: "%B %-d, %Y" }}</time>
            <div id="inline-{{ post.ref }}"></div>
        </li>
    {% endfor %}
</ul>
</div>