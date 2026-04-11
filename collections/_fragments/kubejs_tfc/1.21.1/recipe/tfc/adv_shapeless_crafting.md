---
title: Advanced Shapeless Crafting
anchor: shapeless
func: shapeless
mod: tfc
group: zzz_crafting
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For shapeless crafting recipes which have an [[ isp ]] result
example:
    - "'minecraft:blue_glazed_terracotta',"
    - "["
    - "    'minecraft:blue_concrete',"
    - "    TFC.ingredient.fluidContents(Fluid.lava(50))"
    - "],"
    - "TFC.ingredient.fluidContents(Fluid.lava(50))"
    - "TFC.isp.copyInputStack().addHeat(500)"
sig:
    - "result: ItemStackProvider,"
    - "ingredients: List<Ingredient>,"
    - "primaryIngredient: Ingredient,"
    - "remainder?: ItemStackProvider"
---

- 1st argument: An [[ isp ]], the recipe result
- 2nd argument: A list of item ingredients, the recipe inputs. May not be empty
- 3rd argument: An item ingredient, the primary ingredient of the recipe
- *Optional 4th argument*: An [[ isp ]], the provider to apply to all inputs with the same item as the primary input

{: .related #{{ page.anchor }}-alias-notice }
> The recipe method present here is an alias for the 'official' recipe type, `.tfc.advanced_shapeless_crafting(...)`{:.language-kube-21}. Both may be used in placed of each other as they have the same semantics
