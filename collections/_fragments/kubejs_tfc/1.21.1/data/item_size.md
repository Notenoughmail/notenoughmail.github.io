---
title: Item Size
anchor: item-size
cat:
    - kubejs_tfc
    - 1.21.1
    - data
desc: Add a size and weight definition
method: itemSize
sig: |-
    itemSize: {
        ingredient: Ingredient,
        size?: Size,
        weight?: Weight
    },
    id?: ResourceLocation
example: |-
    {
        ingredient: 'minecraft:netherite_ingot',
        weight: 'very_heavy'
    },
    'kubejs:heavy_netherite'
---

- 1st argument: A item size definition, a map of parameters to values
    - `ingredient: Ingredient`{:.language-kube-21}: The items the size applies to
    - `size?: Size`{:.language-kube-21}: The size of the item(s)
        - {% include enum_list.html summary='Reveal/hide list of sizes' values='tiny,very_small,small,normal,large,very_large,huge' %}
        - Defaults to `small`{:.e}
    - `weight?: Weight`{:.language-kube-21}: The weight of the item(s)
        - {% include enum_list.html summary='Reveal/hide list of weights' values='very_light,light,medium,heavy,very_heavy' %}
        - Defaults to `light`{:.e}
- *Optional 2nd argument*: A `ResourceLocation`, the id of the size
