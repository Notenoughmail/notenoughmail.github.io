---
title: Food
anchor: food
cat:
    - kubejs_tfc
    - 1.21.1
    - data
desc: Add a food definition to an item
sig: |-
    food: {
        ingredient: Ingredient,
        food: {
            hunger?: int,
            water?: number,
            saturation?: number,
            intoxication?: int,
            grain?: number,
            fruit?: number,
            vegetables?: number,
            protein?: number
            dairy?: number,
            decayModifier?: number
        },
        edible?: boolean
    },
    id?: ResourceLocation
example: |-
    {
        ingredient: 'minecraft:cooked_beef',
        food: {
            hunger: 4,
            saturation: 2,
            nutrients: [ 0, 0, 0, 5, 0 ]
        }
    }
---

- 1st argument: The food definition data, a map of parameters to values
    - `ingredient: Ingredient`{:.language-kube-21}: The items the food applies to
    - `food: FoodData`{: .language-kube-21 [[ food_data_properties ]] }: The food properties, a map of parameters to values
        - `hunger?: int`{:.language-kube-21}: The amount of hunger to add. A full hunger bar is 20
            - [[ def_0 ]]
        - `water?: number`{:.language-kube-21}: The amount of thirst to restore. A full thirst bar is 100
            - [[ def_0 ]]
        - `saturation?: number`{:.language-kube-21}: The amount of saturation to provide
            - [[ def_0 ]]
        - `intoxication?: int`{:.language-kube-21}: The number of ticks of intoxication to add to the player
            - [[ def_0 ]]
        - `grain?: number`{:.language-kube-21}: The amount of grain nutrient to add to the player
            - [[ def_0 ]]
        - `fruit?: number`{:.language-kube-21}: The amount of fruit nutrient to add to the player
            - [[ def_0 ]]
        - `vegetables?: number`{:.language-kube-21}: The amount of vegetables nutrient to add to the player
            - [[ def_0 ]]
        - `protein?: number`{:.language-kube-21}: The amount of protein nutrient to add to the player
            - [[ def_0 ]]
        - `dairy?: number`{:.language-kube-21}: The amount of dairy nutrient to add to the player
            - [[ def_0 ]]
        - `decayModifier?: number`{:.language-kube-21}: The decay modifier to apply, a higher value means a quicker decay
            - [[ def_0 ]]
    - `edible?: boolean`{:.language-kube-21}: If the food is edible
        - Defaults to `true`{:.p}
- *Optional 2nd argument*: A `ResourceLocation`{:.language-kube-21}, the id of the food definition
