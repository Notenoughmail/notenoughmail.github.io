---
title: Stomping
anchor: firmalife-stomping
func: stomping
mod: firmalife
group: s
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For stomping items in a stomping barrel
example: |-
    'minecraft:dirt',
    'minecraft:stone',
    'tfc:block/charcoal_pile',
    'tfc:block/powder/charcoal',
    'tfc:block.charcoal.fall'
sig: |-
    result: ItemStackProvider,
    ingredient: Ingredient,
    inputTexture: ResourceLocation,
    outputTexture: ResourceLocation,
    sound: Holder<SoundEvent>
---

- 1st argument: An [[ isp ]], the result of the recipe
- 2nd argument: An item ingredient, the recipe input
- 3rd argument: A texture id, the texture to show for the input
- 4th argument: A texture id, the texture to show for the output
- 5th argument: A sound event id[[ fn_sound ]], the sound to play when stomping
