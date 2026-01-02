---
layout: page
title: Type Explanations
permalink: /kubejs_tfc/1.21.1/type-explanations/
parent: 1.21.1
grand_parent: KubeJS TFC
desc: Explanations of certain Java types that may be encountered in various simple and complex situations
fragment-filter:
    - kubejs_tfc
    - 1.21.1
    - type_exp
---

# Type Explanations

There are several Java types which can be encountered fairly frequently in the docs or are too complex to describe in-line along with other, perhaps more pertinent, information. Those are collected here

{% assign sections = site.fragments | multi_where: 'cat', page.fragment-filter | clean_fragments | sort: 's' %}

{% for section in sections %}

- [{{ section.title | render_liquid }}](#{{ section.anchor }}){% if section.preserve-color %}{: .preserve-color }{% endif %}

{% endfor %}

{: .related #types-note }
> Throughout the docs on this page (and elsewhere for the mod) you may notice some odd type declarations/specifications for JavaScript. This primarily stems from the fact JS/TS types do not perfectly align with Java's type system and a prioritization of displaying the correct Java type over a valid JS type
>
> However there are some compromises on that front in the 1.21 docs. In 1.20 there were many cases where the Java primitives `int`{:.p}, `long`{:.p}, `float`{:.p}, and `double`{:.p} were used instead of JavaScript's `number`{:.p}, but the where and when of their usage is rather inconsistent. For 1.21, only `int`{:.p} and `number`{:.p} will be used; `int`{:.p} will be used for Java `int`{:.p} and `long`{:.p} types and indicate "a `number`{:.p} that will only be/coerced to an integer number" while `number`{:.p} will be used for Java `float`{:.p} and `double`{:.p} types. Other primitives which don't have an equivalent JavaScript type (`byte`{:.p}/`short`{:.p}) will use their Java type.
>
> In addition to the primitive type shenanigans, there are some additional colors for specific categories of Java types with special behavior
>
> - Types colored `#{{ site.colors.enum }}`{:.e} are Java enums which have a defined set values. They can be wrapped from JavaScript as either a case-insensitive string of a value's name or its ordinal
> - Types colored `#{{ site.colors.func }}`{:.f} are Java functional interfaces. They can be wrapped from JavaScript as a function or callback with the appropriate arguments. See the [Rhino docs](https://rhino.github.io/tutorials/scripting_java/#javascript-functions-as-java-interfaces), any moderately sized modpack, or many of the examples here for examples of this

{% for section in sections %}

---

{: #{{ section.anchor }} }

## {{ section.title | render_liquid }}

{{ section.clean }}

{% endfor %}
