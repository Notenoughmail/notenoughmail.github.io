---
title: Deposit
anchor: deposit
cat:
    - kubejs_tfc
    - 1.21.1
    - data
desc: Add a deposit definition, which allows an item to processed in a pan or sluice
sig: |-
    ingredient: Ingredient,
    lootTable: ResourceKey<LootTable>,
    modelStages: List<ResourceLocation>,
    id?: ResourceLocation
example: |-
    '#minecraft:flowers',
    'kubejs:flower_loot',
    [
        'minecraft:block/poppy',
        'minecraft:block/daisy',
        'minecraft:block/cornflower'
    ]
---

- 1st argument: An item ingredient, the items the deposit applies to
- 2nd argument: The id of a loot table, the result of panning/sluicing the item
- 3rd argument: The models to display in sequence while panning
- *Optional 4th argument*:  A `ResourceLocation`{:.language-kube-21}, the id of the deposit
