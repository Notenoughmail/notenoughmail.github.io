---
layout: page
title: Ingredient Bindings
permalink: /kubejs_tfc/1.21.1/bindings/ingredient/
parent: Bindings
grand_parent: 1.21.1
desc: Bindings for creating TFC's ingredient types
field: ingredient
---

# {{ page.title }}

{{ page.desc }}

```js-21
declare class IngredientBindings {

    // These are available via TFC.ingredient.*

    blockIngredient(blocks: List<Block>): BlockIngredient
    tagBlockIngredient(tag: TagKey<Block>): BlockIngredient
    notRotten(): Ingredient
    rotten(): Ingredient
    hasTrait(trait: Holder<FoodTrait>): Ingredient
    lacksTrait(trait: Holder<FoodTrait>): Ingredient
    heat(min: number, max?: number): Ingredient
    fluidContents(ingredient: SizedFluidIngredient): Ingredient
    fluidContents(fluid: Fluid, amount: int): Ingredient
    and(ingredients...: Ingredient[]): Ingredient
}
```

- `.blockIngredient(blocks: List<Block>)`{: .language-kube-21 #block-ingredient }: Creates a block ingredient that matches the given blocks
- `.tagBlockIngredient(tag: TagKey<Block>)`{: .language-kube-21 #tag-block-ingredient }: Creates a block ingredient that matches the given tag
- `.notRotten()`{: .language-kube-21 #not-rotten }: Creates a `tfc:not_rotten` ingredient
- `.rotten()`{: .language-kube-21 #rotten }: Creates a `tfc:rotten` ingredient
- `.hasTrait(trait: Holder<FoodTrait>)`{: .language-kube-21 #has-trait }: Creates a `tfc:has_trait` ingredient that accepts any stack with the given trait
- `.lacksTrait(trait: Holder<FoodTrait>)`{: .language-kube-21 #lacks-trait }: Creates a `tfc:lacks_trait` ingredient that denies any stacks with the given trait
- `.heat(min: number, max?: number)`{: .language-kube-21 #heat }: Creates a `tfc:heat` ingredient, matching items with temperatures in the range <code>[<span class="kv">min</span>,<span class="mi">Infinity</span>)</code> or <code>[<span class="kv">min</span>,<span class="kv">max</span>]</code>
- `.fluidContents(ingredient: SizedFluidIngredient)`{: .language-kube-21 #fluid-contents-0 }: Creates a `tfc:fluid_contents` ingredient with the contents filter being the given fluid ingredient
- `.fluidContents(fluid: Fluid, amount: int)`{: .language-kube-21 #fluid-contents-1 }: Creates a `tfc:fluid_contents` ingredient that only matches the given `fluid`{:.v} with the given `amount`{:.v}
- `.and(ingredients...: Ingredient[])`{: .language-kube-21 #and }: Creates a `tfc:and` ingredient, a variation on NeoForge's intersection ingredient which properly displays TFC ingredient types in recipe viewers
