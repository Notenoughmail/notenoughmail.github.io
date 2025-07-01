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
TFC.itemStackProvider.of(itemStack: ItemStack, modifiers?: (String | JsonArray | JsonObject | List<(String | JsonObject)>))
TFC.isp.empty(modifiers?: (String | JsonArray | JsonObject | List<(String | JsonObject)>))
TFC.itemStackProvider.copyInput(modifiers?: (String | JsonArray | JsonObject | List<(String | JsonObject)>))
```

- `.of(itemStack: ItemStack, modifiers?: (String | JsonArray | JsonObject | List<(String | JsonObject)>))`{: .language-javascript .m-link #of }: Returns an item stack provider with the given item and modifiers
    - 1st argument: An item stack, the item stack of the ISP
    - *Optional 2nd argument*: A string, json array, json object, of list of strings and/or json objects, the modifiers to add. If not provided, no modifiers will be applied to the ISP
- `.empty(modifiers?: (String | JsonArray | JsonObject | List<(String | JsonObject)>))`{: .language-javascript .m-link #empty }: Returns an item stack modifier with an empty item stack and the provided modifiers
    - *Optional 1st argument*: A string, json array, json object, of list of strings and/or json objects, the modifiers to add. If not provided, no modifiers will be applied to the ISP
- `.copyInput(modifiers?: (String | JsonArray | JsonObject | List<(String | JsonObject)>))`{: .language-javascript .m-link #copy-input }: Returns an empty ISP with the `tfc:copy_input` modifier and the provided modifiers
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

- `.stack()`{: .language-javascript .m-link #isp-stack }: Returns the `ItemStack` of the ISP
- `.modifiers()`{: .language-javascript .m-link #isp-modifiers }: Returns a json array of all of the applied modifiers
- `.isEmpty()`{: .language-javascript .m-link #isp-is-empty }: Returns true if the stack and modifier list is empty
- `.withCount(i: number)`{: .language-javascript .m-link #isp-with-count }: Sets the stacks count to the provided value
- `.getCount()`{: .language-javascript .m-link #isp-get-count }: Returns the stack's count
- `.getJsonStack()`{: .language-javascript .m-link #isp-json-stack }: Returns a json object representing the item stack
- `.getModifiersOfType(type: String)`{: .language-javascript .m-link #isp-mod-of-type }: Returns a list of json objects which represent the applied modifiers with the given type
- `.toJson()`{: .language-javascript .m-link #isp-to-json }: Returns the json representation of the ISP
- `.asCanonClass()`{: .language-javascript .m-link #isp-make-canon }: Returns the ISP as an `ItemStackProvider` object, TFC's canonical class for this data
- `.dependsOnInput()`{: .language-javascript .m-link #isp-input-dependent }: Returns true if any of the applied modifiers is dependent on the recipe's input
- `.copy()`{: .language-javascript .m-link #isp-copy }: Returns a copy of the ISP
- `.getTag()`{: .language-javascript .m-link #isp-get-tag }: Returns the item stack's `CompoundTag`, may be null
- `.setTag(tag: CompoundTag)`{: .language-javascript .m-link #isp-set-tag }: Sets the item stack's `CompoundTag`
- `.mergeTag(tag: CompoundTag)`{: .language-javascript .m-link #isp-merge-tag }: Merges the provided `CompoundTag` into the item stack's
- `.simpleModifier(type: String)`{: .language-javascript .m-link #isp-simple-mod }: Adds a modifier of the provided type
- `.jsonModifier(modifier: JsonObject)`{: .language-javascript .m-link #isp-json-mod}: Adds the provided json modifier
- `.dyeLeather(color: DyeColor)`{: .language-javascript .m-link #isp-dye-mod }: Adds a `tfc:dye_leather` modifier with the provided color
- `.addHeat(temperature: number)`{: .language-javascript .m-link #isp-heat-mod }: Adds a [`tfc:add_heat`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#add-heat) with the provided temperature, allows negative values
- `.addPowder()`{: .language-javascript .m-link #isp-powder-mod }: Adds a [`tfc:add_powder`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#add-powder) modifier
- `.addTrait(trait: String)`{: .language-javascript .m-link #isp-add-trait-mod }: Adds a [`tfc:add_trait`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#add-trait) modifier with the provided trait value
- `.removeTrait(trait: String)`{: .language-javascript .m-link #isp-remove-trait-mod }: Adds a [`tfc:remove_trait`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#remove-trait) modifier with the provided trait value
- `.addGlass()`{: .language-javascript .m-link #isp-glass-mod }: Adds a [`tfc:add_glass`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#add-glass) modifier
- `.copyFood()`{: .language-javascript .m-link #isp-copy-food-mod }: Adds a [`tfc:copy_food`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#copy-food) modifier
- `.copyForgingBonus()`{: .language-javascript .m-link #isp-copy-forging-bonus-mod }: Adds a [`tfc:copy_forging_bonus`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#copy-forging-bonus) modifier
- `.copyHeat()`{: .language-javascript .m-link #isp-copy-heat-mod }: Adds a [`tfc:copy_heat`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#copy-heat) modifier
- `.copyInput()`{: .language-javascript .m-link #isp-copy-mod }: Adds a [`tfc:copy_input`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#copy-input) modifier
- `.emptyBowl()`{: .language-javascript .m-link #isp-empty-bowl-mod }: Adds a [`tfc:empty_bowl`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#empty-bowl) modifier
- `.resetFood()`{: .language-javascript .m-link #isp-reset-food-mod }: Adds a [`tfc:reset_food`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#reset-food) modifier
- `.copyOldestFood()`{: .language-javascript .m-link #isp-copy-oldest-food-mod }: Adds a [`tfc:copy_oldest_food`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#copy-oldest-food) modifier
- `.addBait()`{: .language-javascript .m-link #isp-add-bait-mod }: Adds a [`tfc:add_bait_to_rod`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#add-bait-to-rod) modifier
- `.meal(food: Consumer<BuildFoodItemData>, portions?: Consumer<BuildPortionData>[])`{: .language-javascript .m-link #isp-meal-mod }: Adds a [`tfc:meal`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#meal) modifier
    - 1st argument: A consumer with the same methods as the 2nd argument of a [food definition]({% link kubejs_tfc/1.20.1/data.md %}#food-items)
    - *Optional 2nd argument*: An array of consumers specifying the portions of a meal
        - `.ingredient(ingredient: Ingredient)`{: .language-javascript }: Sets the portion's ingredient
        - `.nutrientModifier(modifier: number)`{: .language-javascript }: Multiplies the nutrition from the ingredient, defaults to 1
        - `.waterModifier(modifier: number)`{: .language-javascript }: Multiplies the water from the ingredient, defaults to 1
        - `.saturationModifier(modifier: number)`{: .language-javascript }: Multiplies the saturation from the ingredient, defaults to 1

<a id="firmalife"></a>If [FirmaLife](https://modrinth.com/mod/firmalife) is installed the following methods are available:

- `.firmaLifeAddPiePan()`{: .language-javascript .m-link #isp-firmalife-pie-pan-mod }: Adds a `firmalife:add_pie_pan` modifier
- `.firmaLifeCopyDynamicFood()`{: .language-javascript .m-link #isp-firmalife-copy-dynamic-food-mod }: Adds a `firmalife:copy_dynamic_food` modifier
- `.firmaLifeEmptyPan()`{: .language-javascript .m-link #isp-firmalife-empty-pan-mod }: Adds a `firmalife:empty_pan` modifier

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
