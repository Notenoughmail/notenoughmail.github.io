---
layout: page
title: Recipes
permalink: /kubejs_tfc/1.21.1/recipes/
parent: 1.21.1
grand_parent: KubeJS TFC
desc: Explanations of making TFC's recipe types in scripts
fragment-filter:
    - kubejs_tfc
    - 1.21.1
    - recipe
fragment-sort:
    - group
    - title
---

# Recipes

The following recipe types are supported by KubeJS TFC

{% map replacements %}
{% isp %}[`ItemStackProvider`]({% link kubejs_tfc/1.21.1/type-explanations.md %}#item-stack-provider){% end_isp %}
{% bing %}[`BlockIngredient`]({% link kubejs_tfc/1.21.1/bindings/ingredient.md %}#block-ingredient){% end_bing %}
{% endmap %}

{% assign all_recipes = site.fragments | multi_where: 'cat', page.fragment-filter | replace_in_fragments: replacements | clean_fragments | multi_sort: page.fragment-sort %}
{% assign tfc = all_recipes | where: 'mod', 'tfc' %}
{% assign afc = all_recipes | where: 'mod', 'afc' %}

{% list mods %}
{% tfc %}
{% afc %}
{% endlist %}

{% grid n=3 %}

{% for recipe in tfc %}

- [{{ recipe.title }}](#{{ recipe.anchor }})

{% endfor %}

</div>

<a id="arborfirmacraft"></a>If *ArborFirmaCraft* {% include mr.html link='arborfirmacraft-(afc)' %} {% include cf.html link='arborfirmacraft' %} is installed, the following recipes are supported

{% for recipe in afc %}

- [{{ recipe.title }}](#{{ recipe.anchor }})

{% endfor %}

{% for mod in mods %}

{% assign mod_recipes = mod | extract_from_context %}

{% for recipe in mod_recipes %}

{: #{{ recipe.anchor }} }

## {{ recipe.title }}

{{ recipe.tagline | replace_inline: replacements | render_liquid }}

{: #{{ recipe.anchor }}-signature }

### Method Signature

```js-21
event.recipes.{{ recipe.mod }}.{{ recipe | get_or_default: 'func', 'anchor' }}(
    {{ recipe.sig | with_indent: 4 }}
){% if recipe.sig_add %}
    // Additional methods
    {{ recipe.sig_add | with_indent: 4 }}{% endif %}
```

{{ recipe.clean }}

{: #{{ recipe.anchor }}-example }

### Example

```js-21
ServerEvents.recipes(event => {
    event.recipes.{{ recipe.mod }}.{{ recipe | get_or_default: 'func', 'anchor' }}(
        {{ recipe.example | with_indent }}
    ){% if recipe.example_add %}
    {{ recipe.example_add | with_indent: 4 }}{% endif %}
})
```

{% endfor %}

{% endfor %}
