---
title: Drinkable
anchor: drinkable
cat:
    - kubejs_tfc
    - 1.21.1
    - data
desc: Add a drinkable definition, allows a fluid to be drunk for thirst, nutrients, and even effects
sig: |-
    drinkable: {
        ingredient: FluidIngredient,
        consumeChance?: number,
        mayDrinkWhenFull?: boolean,
        food?: FoodData,
        effects?: List<{
            type: Holder<MobEffect>,
            duration: int,
            amplifier?: int,
            chance?: number
        }>
    },
    id?: ResourceLocation
example: |-
    {
        ingredient: Fluid.of('lava', 500),
        mayDrinkWhenFull: true,
        food: {
            nutrients: [ 0, 0, 0, 500, 0 ]
        },
        effects: [{
            type: 'minecraft:wither',
            duration: 500,
            amplifier: 3,
            chance: 1
        }]
    }
---

- 1st argument: The drinkable data, a map of parameters to values
    - `ingredient: FluidIngredient`{:.language-kube-21}: The fluids the drink data applies to
    - `consumeChance?: number`{:.language-kube-21}: The chance a block of fluid will be consumed when drinking from in-world
        - [[ unit ]]
        - [[ def_1 ]]
    - `mayDrinkWhenFull?: boolean`{:.language-kube-21}: If the player can drink with a full thirst bar
        - Defaults to `false`{:.p}
    - `food?: FoodData`{:.language-kube-21}: Additional food and nutrient data, the same as the [`food`{:.v} properties of food definitions]([[ food_data_properties ]]){:.preserve-color}
    - `effects?: List<Effect>`{:.language-kube-21}: A list of effects to apply, an effect can be specified as a map of
        - `type: Holder<MobEffect>`{:.language-kube-21}: The effect to apply[[ fn_mob_effect ]]
        - `duration: int`{:.language-kube-21}: How many ticks the effect should be active for
        - `amplifier?: int`{:.language-kube-21}: The level of the effect
            - [[ def_0 ]]
        - `chance?: number`{:.language-kube-21}: The chance the effect is added
            - [[ unit ]]
            - [[ def_0 ]]
- *Optional 2nd argument*:  A `ResourceLocation`{:.language-kube-21}, the id of the drinkable
