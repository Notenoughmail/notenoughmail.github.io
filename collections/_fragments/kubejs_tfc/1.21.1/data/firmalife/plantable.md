---
title: Plantable
anchor: plantable
cat:
    - kubejs_tfc
    - 1.21.1
    - data
desc: Add a plantable definition, for use in planters in [greenhouses](#greenhouse-type)
mod: firmalife
group: FirmaLifeEvents
sig: |-
    plantable: {
        ingredient: Ingredient,
        planter: PlanterType,
        seed: ItemStack,
        crop: ItemStack,
        tier?: int,
        stages?: int,
        extraSeedChance?: number,
        nutrient?: {
            nitrogen?: number,
            phosphorous?: number,
            potassium?: number
        },
        textures?: List<ResourceLocation>,
        specials?: List<ResourceLocation>
    },
    id?: ResourceLocation
example: |-
    {
        ingredient: 'minecraft:rose_bush',
        planter: 'trellis',
        seed: 'minecraft:rose_bush',
        crop: 'minecraft:rose_bush',
        tier: 22,
        nutrient: {
            nitrogen: 2
        },
        textures: [
            'minecraft:block/stone',
            'minecraft:block/dirt'
        ]
    }
---

- 1st argument: The plantable data, a map of parameters to values
    - `ingredient: Ingredient`{:.language-kube-21}: The items that can be put in a planter to grow
    - `planter: PlanterType`{:.language-kube-21}: The planter the plantable grows in
        {% include enum_list.html summary='Reveal/hide list of planter types' values='quad,large,hanging,trellis,bonsai,hydroponic' %}
    - `seed: ItemStack`{:.language-kube-21}: The seed drop when harvesting the plantable
    - `crop: ItemStack`{:.language-kube-21}: The crop drop when harvesting the plantable
    - `tier?: int`{:.language-kube-21}: The minimum [greenhouse tier](#greenhouse-type) required for the plantable to grow
    - `stages?: int`{:.language-kube-21}: The number of growth stages the plantable has
        - [[ def_0 ]]
    - `extraSeedChance?: number`{:.language-kube-21}: The chance an extra seed drops on harvest
        - [[ unit ]]
        - [[ def_0 ]]
    - `nutrient: NutrientList`{:.language-kube-21}: The nutrients required to grow, a map of parameters to values
        - `nitrogen?: number`{:.language-kube-21}: The nitrogen amount
            - [[ unit ]]
            - [[ def_0 ]]
        - `phosphorous?: number`{:.language-kube-21}: The phosphorous amount
            - [[ unit ]]
            - [[ def_0 ]]
        - `potassium?: number`{:.language-kube-21}: The potassium amount
            - [[ unit ]]
            - [[ def_0 ]]
    - `textures?: List<ResourceLocation>`{:.language-kube-21}: The textures used for the growth stages
        - Defaults to `[]`
    - `specials?: List<ResourceLocation>`{:.language-kube-21}: Special textures used by `hanging`{:.e} planters
        - Defaults to `[]`
- *Optional 2nd argument*: A `ResourceLocation`, the id of the plantable

{% comment %}

## greenhouse type

{% endcomment %}
