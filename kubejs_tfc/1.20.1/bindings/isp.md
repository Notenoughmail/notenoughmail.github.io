---
layout: page
title: Item Stack Provider Bindings
permalink: /kubejs_tfc/1.20.1/bindings/isp/
parent: Bindings
grand_parent: 1.20.1
---

# Item Stack Provider Bindings

[Item stack providers](https://terrafirmacraft.github.io/Documentation/1.20.x/common-types/#item-stack-providers) are an item stack with attached data, known as item stack modifiers. There are several methods for creating them

These are available from the `TFC.itemStackProvider` and `TFC.isp` fields

## Method Signatures

```js
TFC.itemStackProvider.of(itemStack: ItemStack, modifiers?: (String | JsonArray | JsonObject | List<(String | JsonObject)>)): ItemStackProvider
TFC.isp.empty(modifiers?: (String | JsonArray | JsonObject | List<(String | JsonObject)>)): ItemStackProvider
TFC.itemStackProvider.copyInput(modifiers?: (String | JsonArray | JsonObject | List<(String | JsonObject)>)): ItemStackProvider
```

- `.of(itemStack: ItemStack, modifiers?: (String | JsonArray | JsonObject | List<(String | JsonObject)>))`{: .language-kube #of }: Returns an item stack provider with the given item and modifiers
    - 1st argument: An item stack, the item stack of the ISP
    - *Optional 2nd argument*: A string, json array, json object, of list of strings and/or json objects, the modifiers to add. If not provided, no modifiers will be applied to the ISP
- `.empty(modifiers?: (String | JsonArray | JsonObject | List<(String | JsonObject)>))`{: .language-kube #empty }: Returns an item stack modifier with an empty item stack and the provided modifiers
    - *Optional 1st argument*: A string, json array, json object, of list of strings and/or json objects, the modifiers to add. If not provided, no modifiers will be applied to the ISP
- `.copyInput(modifiers?: (String | JsonArray | JsonObject | List<(String | JsonObject)>))`{: .language-kube #copy-input }: Returns an empty ISP with the `tfc:copy_input` modifier and the provided modifiers
    - *Optional 1st argument*: A string, json array, json object, of list of strings and/or json objects, the modifiers to add. If not provided, only the copy input modifier will be applied to the ISP

{: .notice #method-notice }
These methods return an `ItemStackProviderJS` object which has several helper methods and is described [below](#itemstackproviderjs)

## Examples

```js
TFC.itemStackProvider.of('3x minecraft:dirt', ['tfc:add_glass', {type: 'tfc:add_trait', trait: 'kubejs:my_cool_trait'}])
TFC.isp.of('5x minecraft:stone')
TFC.itemStackProvider.empty('tfc:add_powder')
TFC.isp.copyInput()
TFC.itemStackProvider.copyInput('tfc:copy_heat')
```

In json:

```json
{
    "stack": {
        "item": "minecraft:dirt",
        "count": 3
    },
    "modifiers": [
        {
            "type": "tfc:add_glass"
        },
        {
            "type": "tfc:add_trait",
            "trait": "kubejs:my_cool_trait"
        }
    ]
}
```

```json
{
    "item": "minecraft:stone",
    "count": 5
}
```

```json
{
    "modifiers": [
        {
            "type": "tfc:add_powder"
        }
    ]
}
```

```json
{
    "modifiers": [
        {
            "type": "tfc:copy_input"
        }
    ]
}
```

```json
{
    "modifiers": [
        {
            "type": "tfc:copy_input"
        },
        {
            "type": "tfc:copy_heat"
        }
    ]
}
```

# ItemStackProviderJS

An `ItemStackProviderJS` is an object which is meant to mirror an actual `ItemStackProvider` but be friendly to modify from JS and can be serialized into json.

## Method Signatures

```js
isp.stack(): ItemStack
isp.modifiers(): JsonArray
isp.isEmpty(): boolean
isp.isSimple(): boolean
isp.withCount(i: number): ItemStackProviderJS
isp.getCount(): number
isp.getJsonStack(): JsonObject
isp.getModifiersOfType(type: String): List<JsonObject>
isp.toJson(): JsonObject
isp.asCanonClass(): ItemStackProvider
isp.dependsOnInput(): boolean
isp.copy(): ItemStackProviderJS
isp.getTag(): @Nullable CompoundTag
isp.setTag(tag: CompoundTag): ItemStackProviderJS
isp.mergeTag(tag: CompoundTag): ItemStackProviderJS
isp.simpleModifier(type: String): ItemStackProviderJS
isp.jsonModifier(modifier: JsonObject): ItemStackProviderJS
isp.dyeLeather(color: DyeColor): ItemStackProviderJS
isp.addHeat(temperature: number): ItemStackProviderJS
isp.addPowder(): ItemStackProviderJS
isp.addTrait(trait: String): ItemStackProviderJS
isp.removeTrait(trait: String): ItemStackProviderJS
isp.addGlass(): ItemStackProviderJS
isp.copyFood(): ItemStackProviderJS
isp.copyForgingBonus(): ItemStackProviderJS
isp.copyHeat(): ItemStackProviderJS
isp.copyInput(): ItemStackProviderJS
isp.emptyBowl(): ItemStackProviderJS
isp.resetFood(): ItemStackProviderJS
isp.copyOldestFood(): ItemStackProviderJS
isp.addBait(): ItemStackProviderJS
isp.meal(food: Consumer<BuildFoodItemData>, portions?: Consumer<BuildPortionData>[]): ItemStackProviderJS
// The following are available if FirmaLife is installed
isp.firmaLifeAddPiePan(): ItemStackProviderJS
isp.firmaLifeCopyDynamicFood(): ItemStackProviderJS
isp.firmaLifeEmptyPan(): ItemStackProviderJS
```

- `.stack()`{: .language-kube #isp-stack }: Returns the `ItemStack` of the ISP
- `.modifiers()`{: .language-kube #isp-modifiers }: Returns a json array of all of the applied modifiers
- `.isEmpty()`{: .language-kube #isp-is-empty }: Returns true if the stack and modifier list is empty
- `.withCount(i: number)`{: .language-kube #isp-with-count }: Sets the stacks count to the provided value
- `.getCount()`{: .language-kube #isp-get-count }: Returns the stack's count
- `.getJsonStack()`{: .language-kube #isp-json-stack }: Returns a json object representing the item stack
- `.getModifiersOfType(type: String)`{: .language-kube #isp-mod-of-type }: Returns a list of json objects which represent the applied modifiers with the given type
- `.toJson()`{: .language-kube #isp-to-json }: Returns the json representation of the ISP
- `.asCanonClass()`{: .language-kube #isp-make-canon }: Returns the ISP as an `ItemStackProvider` object, TFC's canonical class for this data
- `.dependsOnInput()`{: .language-kube #isp-input-dependent }: Returns true if any of the applied modifiers is dependent on the recipe's input
- `.copy()`{: .language-kube #isp-copy }: Returns a copy of the ISP
- `.getTag()`{: .language-kube #isp-get-tag }: Returns the item stack's `CompoundTag`, may be null
- `.setTag(tag: CompoundTag)`{: .language-kube #isp-set-tag }: Sets the item stack's `CompoundTag`
- `.mergeTag(tag: CompoundTag)`{: .language-kube #isp-merge-tag }: Merges the provided `CompoundTag` into the item stack's
- `.simpleModifier(type: String)`{: .language-kube #isp-simple-mod }: Adds a modifier of the provided type
- `.jsonModifier(modifier: JsonObject)`{: .language-kube #isp-json-mod}: Adds the provided json modifier
- `.dyeLeather(color: DyeColor)`{: .language-kube #isp-dye-mod }: Adds a `tfc:dye_leather` modifier with the provided color
- `.addHeat(temperature: number)`{: .language-kube #isp-heat-mod }: Adds a [`tfc:add_heat`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#add-heat) with the provided temperature, allows negative values
- `.addPowder()`{: .language-kube #isp-powder-mod }: Adds a [`tfc:add_powder`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#add-powder) modifier
- `.addTrait(trait: String)`{: .language-kube #isp-add-trait-mod }: Adds a [`tfc:add_trait`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#add-trait) modifier with the provided trait value
- `.removeTrait(trait: String)`{: .language-kube #isp-remove-trait-mod }: Adds a [`tfc:remove_trait`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#remove-trait) modifier with the provided trait value
- `.addGlass()`{: .language-kube #isp-glass-mod }: Adds a [`tfc:add_glass`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#add-glass) modifier
- `.copyFood()`{: .language-kube #isp-copy-food-mod }: Adds a [`tfc:copy_food`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#copy-food) modifier
- `.copyForgingBonus()`{: .language-kube #isp-copy-forging-bonus-mod }: Adds a [`tfc:copy_forging_bonus`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#copy-forging-bonus) modifier
- `.copyHeat()`{: .language-kube #isp-copy-heat-mod }: Adds a [`tfc:copy_heat`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#copy-heat) modifier
- `.copyInput()`{: .language-kube #isp-copy-mod }: Adds a [`tfc:copy_input`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#copy-input) modifier
- `.emptyBowl()`{: .language-kube #isp-empty-bowl-mod }: Adds a [`tfc:empty_bowl`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#empty-bowl) modifier
- `.resetFood()`{: .language-kube #isp-reset-food-mod }: Adds a [`tfc:reset_food`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#reset-food) modifier
- `.copyOldestFood()`{: .language-kube #isp-copy-oldest-food-mod }: Adds a [`tfc:copy_oldest_food`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#copy-oldest-food) modifier
- `.addBait()`{: .language-kube #isp-add-bait-mod }: Adds a [`tfc:add_bait_to_rod`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#add-bait-to-rod) modifier
- `.meal(food: Consumer<BuildFoodItemData>, portions?: Consumer<BuildPortionData>[])`{: .language-kube #isp-meal-mod }: Adds a [`tfc:meal`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#meal) modifier
    - 1st argument: A consumer with the same methods as the 2nd argument of a [food definition]({% link kubejs_tfc/1.20.1/data.md %}#food-items)
    - *Optional 2nd argument*: An array of consumers specifying the portions of a meal
        - `.ingredient(ingredient: Ingredient)`{: .language-kube }: Sets the portion's ingredient
        - `.nutrientModifier(modifier: number)`{: .language-kube }: Multiplies the nutrition from the ingredient, defaults to 1
        - `.waterModifier(modifier: number)`{: .language-kube }: Multiplies the water from the ingredient, defaults to 1
        - `.saturationModifier(modifier: number)`{: .language-kube }: Multiplies the saturation from the ingredient, defaults to 1

<a id="firmalife"></a>If *FirmaLife* {% include mr.html link='firmalife' %} {% include cf.html link='firmalife' %} is installed the following methods are available:

- `.firmaLifeAddPiePan()`{: .language-kube #isp-firmalife-pie-pan-mod }: Adds a `firmalife:add_pie_pan` modifier
- `.firmaLifeCopyDynamicFood()`{: .language-kube #isp-firmalife-copy-dynamic-food-mod }: Adds a `firmalife:copy_dynamic_food` modifier
- `.firmaLifeEmptyPan()`{: .language-kube #isp-firmalife-empty-pan-mod }: Adds a `firmalife:empty_pan` modifier

<a id="artisanal"></a>If *TFC Artisanal* {% include mr.html link='tfc-artisanal' %} {% include cf.html link='tfc-artisanal' %} is installed the following methods are available:

- `.artisanalCapHeat(max: number)`{: .language-kube #isp-artisanal-cap-heat }: Adds a `artisanal:cap_heat` modifier
- `.artisanalCopyDynamicFood()`{: .language-kube #isp-artisanal-copy-dynamic-food }: Adds a `artisanal:copy_dynamic_food` modifier
- `.artisanalCopyDynamicFoodNeverExpires()`{: .language-kube #isp-artisanal-copy-dynamic-food-never-expires }: Adds a `artisanal:copy_dynamic_food_never_expires` modifier
- `.artisanalEmptyBowl()`{: .language-kube #isp-artisanal-empty-bowl }: Adds a `artisanal:empty_bowl` modifier
- `.artisanalExtractCannedFood()`{: .language-kube #isp-artisanal-extract-canned-food }: Adds a `artisanal:extract-canned-food` modifier
- `.artisanalHomogenousIngredients()`{: .language-kube #isp-artisanal-homogenous-ingredients }: Adds a `artisanal:homogenous-ingredients` modifier
- `.artisanalInheritDecay(decayModifier: number)`{: .language-kube #isp-artisanal-inherit-decay }: Adds a `artisanal:inherit_decay` modifier
- `.artisanalModifyFluid(fluid: FluidStack)`{: .language-kube #isp-artisanal-modify-fluid }: Adds a `artisanal:modify_fluid` modifier
- `.artisanalOnlyIfGenericAnimalFat()`{: .language-kube #isp-artisanal-only-if-generic-animal-fat }: Adds a `artisanal:only_if_generic_animal_fat` modifier
- `.artisanalRemoveButter()`{: .language-kube #isp-artisanal-remove-butter }: Adds a `artisanal:remove_butter` modifier.

## Examples

```js
TFC.itemStackProvider.copyInput().copyHeat().copyOldestFood()
TFC.itemStackProvider.of('5x minecraft:glass').addHeat(500)
```

In json:

```json
{
    "modifiers": [
        {
            "type": "tfc:copy_input"
        },
        {
            "type": "tfc:copy_heat"
        },
        {
            "type": "tfc:copy_oldest_food"
        }
    ]
}
```

```json
{
    "stack": {
        "item": "minecraft:glass",
        "count": 5
    },
    "modifiers": [
        {
            "type": "tfc:add_heat",
            "temperature": 500
        }
    ]
}
```
