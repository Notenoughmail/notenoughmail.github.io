---
layout: page
title: Data
permalink: /kubejs_tfc/1.21.1/data/
parent: 1.21.1
grand_parent: KubeJS TFC
desc: Documentation on Creating TFC's data types in scripts
---

# Data

{% map replacements %}
{% fn_mob_effect [^mob-effect] %}
{% food_data_properties %}#food-data-properties{% end_food_data_properties %}
{% def_0 %}Defaults to `0`{:.n}{% end_def_0 %}
{% def_1 %}Defaults to `1`{:.n}{% end_def_1 %}
{% n_inf %}`-Infinity`{:.language-kube-21}{% end_n_inf %}
{% p_inf %}`Infinity`{:.n}{% end_p_inf %}
{% unit %}Must be {% in_unit %}{% end_unit %}
{% fn_temps [^temperatures] %}
{% fn_sound [^sound] %}
{% bing %}{% link kubejs_tfc/1.21.1/bindings/ingredient.md %}#block-ingredient{% end_bing %}
{% endmap %}

[^mob-effect]: A full list of mob effects can be obtained by running the command `/kubejs dump_registry minecraft:mob_effect`{:.language-command} in-game
[^temperatures]: In TFC, the forging and welding temperatures of an item are typically 60% and 80% of its melting temperature
[^sound]: A full list of all sound events can be obtained by running the command `/kubejs dump_registry minecraft:sound_event`{:.language-command} in-game

{% assign data = site | fragments_replace: replacements, 'kubejs_tfc', '1.21.1', 'data' | prioritize_nil: 'multi_sort', 'group', 'anchor' %}

{% assign tfc = data | absent: 'mod' %}
{% assign firmalife = data | where: 'mod', 'firmalife' %}
{% assign beneath = data | where: 'mod', 'beneath' %}

TFC's data types can be created through the `TFCEvents.data` event in the `server_scripts` folder

{% grid n=3 %}

{% for d in tfc %}

- [{{ d.title }}](#{{ d.anchor }})

{% endfor %}

</div>

<a id="firmalife"></a>If *FirmaLife* {% include mr.html link='firmalife' %} {% include cf.html link='firmalife' %} is installed, the following data types are supported

{% grid n=3 %}

{% for d in firmalife %}

- [{{ d.title }}](#{{ d.anchor }})

{% endfor %}

</div>

<a id="beneath"></a>If *Beneath* {% include mr.html link='beneath' %} {% include cf.html link='beneath' %} is installed, the following data types are supported

{% grid n=3 %}

{% for d in beneath %}

- [{{ d.title }}](#{{ d.anchor }})

{% endfor %}

</div>

{: .notice #general-notice }
> Most of these methods have an optional final argument which specifies the id of the virtual json file the data will be placed in. For instance, if an id of `fish:get_pierced` was used for an entity damage resistance, the resulting file would effectively be at `data/fish/tfc/entity_damage_restances/get_pierced.json`{: .language-fs }; the `tfc/<data_type>`{: .language-fs } folders do not need to be provided
>
> If no id is provided, one will automatically be generated with the namespace `kubejs` and, unless other wise noted, a path matching the base 16 hash of the (usually) data type's `.toString()`{: .language-kube-21 } value
>
> Additionally, for data types that use ingredients, if there are multiple definitions with the same valid item/block/fluid/entity, then there is no guarantee as to which will take precedence. This situation can be confirmed by using the [search command]({% link kubejs_tfc/1.21.1/commands.md %}#search) and fixed by either overriding the existing definition or changing the entries in the tag it uses

{% for d in data %}

{: #{{ d.anchor }} }

## {{ d.title }}

{{ d.desc | render_full }}

{: #{{ d.anchor}}-method }

### Method Signature

{: .method-signature }

```js-21
event.{{ d | get_or_default: 'method', 'anchor' }}(
    {{ d.sig | with_indent: 4 }}
)
```

{{ d.clean | render_missed_footnotes }}

{: #{{ d.anchor }}-example }

### Example

```js-21
{{ d | get_or_else: 'group', 'TFCEvents' }}.data(event => {
    event.{{ d | get_or_default: 'method', 'anchor' }}(
        {{ d.example | with_indent }}
    )
})
```

{% endfor %}
