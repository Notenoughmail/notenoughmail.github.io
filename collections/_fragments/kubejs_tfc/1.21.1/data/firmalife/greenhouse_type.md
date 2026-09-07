---
title: Greenhouse Type
anchor: greenhouse-type
cat:
    - kubejs_tfc
    - 1.21.1
    - data
desc: Add a greenhouse type
mod: firmalife
group: FirmaLifeEvents
method: greenhouseType
sig: |-
    type: {
        ingredient: BlockIngredient,
        translationKey: Component,
        tier?: int
    },
    id?: ResourceLocation
example: |-
    {
        ingredient: [
            'minecraft:green_wool',
            'minecraft:glass'
        ],
        translationKey: Text.darkPurple('"Green" House'),
        tier: 25
    }
---

- 1st argument: The greenhouse data, a map of parameters to values
    - `ingredient: BlockIngredient`{:.language-kube-21}: The [blocks]([[ bing ]]) the greenhouse type applies to
    - `translationKey: Component`{:.language-kube-21}: The text describing the greenhouse type
    - `tier?: int`{:.language-kube-21}: The tier of the greenhouse type
        - [[ def_0 ]]