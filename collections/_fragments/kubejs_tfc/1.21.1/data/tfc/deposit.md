---
title: Deposit
anchor: deposit
cat:
    - kubejs_tfc
    - 1.21.1
    - data
desc: Add a deposit definition, which allows an item to processed in a pan or sluice
sig: |-
    deposit: {
        ingredient: Ingredient,
        lootTable: ResourceKey<LootTable>,
        modelStages?: List<ResourceLocaiton>
    },
    id?: ResourceLocation
example: |-
    {
        ingredient: '#minecraft:flowers',
        lootTable: 'kubejs:flower_loot',
        modelStages: [
            'minecraft:block/poppy',
            'minecraft:block/daisy',
            'minecraft:block/cornflower'
        ]
    }
---

- 1st argument: The deposit data, a map of parameters to values
    - `ingredient: Ingredient`{:.language-kube-21}: An item ingredient, the items the deposit applies to
    - `lootTable: ResourceKey<LootTable>`{:.language-kube-21}: The id of a loot table, the result of panning/sluicing the item
    - `modelStages?: List<ResourceLocation>`{:.language-kube-21}: The models to display in sequence while panning
        - Defaults to `[]`
- *Optional 2nd argument*:  A `ResourceLocation`{:.language-kube-21}, the id of the deposit
