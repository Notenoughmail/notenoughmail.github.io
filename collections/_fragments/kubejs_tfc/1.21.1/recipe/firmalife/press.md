---
title: Press
anchor: firmalife-press
func: press
mod: firmalife
group: p
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: Currently unused, but theoretically for pressing items in a mechanical press for automated [stomping](#firmalife-stomping)
example: |-
    'minecraft:smooth_stone',
    'minecraft:cobblestone',
    'minecraft:block/cobblestone',
    'minecraft:block/smooth_stone',
    'tfc.block.charcoal.fall'
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
