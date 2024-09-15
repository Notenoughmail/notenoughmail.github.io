---
layout: page
title: Test Page
permalink: /test/
nav_exclude: true
search_exclude: true
---

# Test page

Just a place to see how various things look/interact and if certain things work

## Two hashes

And text underneath

### Three hashes

And text underneath

#### Four hashes

And text underneath

##### Five hashes

And text underneath

###### Six hashes

And text underneath

{: .notice }
> A multiline notice callout
>
> See the game yesterday?

{: .deprecated }
> A multiline deprecated callout
>
> What a load of rubbish, eh?

{: .unstable }
> A multiline unstable callout
>
> Eat any good books lately?

{: .prompt }
> A multiline prompt callout
>
> > This is a synergistic expression of art and engineering challenges
>
> ~ Joe Hills, 2020-10-24

{: .comment }
> A multiline comment callout
>
> There ain't ever been a man who can destroy a drought

Embedded html tag stuff:

A value exceeding 2<span style="vertical-align: baseline; position: relative; top: -0.5em;">90</span>

<span style="vertical-align: baseline; position: relative; top: -0.5em; right: -0.5em;">14</span><span style="vertical-align: baseline; position: relative; bottom: -0.5em;">6</span>C<span style="vertical-align: baseline; position: relative; top: -0.5em;">4+</span>

Embedded images:

![Black Helicopters](https://www.theregister.com/design_picker/fa16d26efb42e6ba1052f1d387470f643c5aa18d/graphics/icons/comment/black_helicopters_48.png)

![The Register logo](https://www.theregister.com/design_picker/fa16d26efb42e6ba1052f1d387470f643c5aa18d/graphics/std/reg_logo_no_strapline.svg)

htmz:

<base target="htmz" />

<div role="tablist">
    <a class="tab" href="/hidden/dog.html#tab">Dog</a>
    <a class="tab" href="/hidden/horse.html#tab">Horse</a>
    <a class="tab" href="/hidden/empty.html#tab">Empty</a>
</div>

<div id="tab" role="tabpanel"></div>

<iframe hidden name=htmz onload="setTimeout(()=>document.querySelector(contentWindow.location.hash||null)?.replaceWith(...contentDocument.body.childNodes))"></iframe>

{: .notice }
This page can be safely ignored :)

<code style="color:25FF25;">Haggard</code>
