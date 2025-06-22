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
TFC.itemStackProvider.of(itemStack: ItemStack, modifiers?: (string | JsonArray | JsonObject | List<(string | JsonObject)>))
TFC.isp.empty(modifiers?: (string | JsonArray | JsonObject | List<(string | JsonObject)>))
TFC.itemStackProvider.copyInput(modifiers?: (string | JsonArray | JsonObject | List<(string | JsonObject)>))
```

- Of: Returns an item stack provider with the given item and modifiers
    - 1st argument: An item stack, the item stack of the ISP
    - *Optional 2nd argument*: A string, json array, json object, of list of strings and/or json objects, the modifiers to add. If not provided, no modifiers will be applied to the ISP
- Empty: Returns an item stack modifier with an empty item stack and the provided modifiers
    - *Optional 1st argument*: A string, json array, json object, of list of strings and/or json objects, the modifiers to add. If not provided, no modifiers will be applied to the ISP
- CopyInput: Returns an empty ISP with the `tfc:copy_input` modifier and the provided modifiers
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
declare class ItemStackProviderJS {
    stack(): ItemStack
    modifiers(): JsonArray
    isEmpty(): boolean
    isSimple(): boolean
    withCount(i: number): ItemStackProviderJS
    getCount(): number
    getJsonStack(): JsonObject
    getModifiersOfType(type: string): List<JsonObject>
    toJson(): JsonObject
    asCanonClass(): ItemStackProvider
    dependsOnInput(): boolean
    copy(): ItemStackProviderJS
    getTag(): @Nullable CompoundTag
    setTag(tag: CompoundTag): ItemStackProviderJS
    mergeTag(tag: CompoundTag): ItemStackProviderJS
    simpleModifier(type: string): ItemStackProviderJS
    jsonModifier(modifier: JsonObject): ItemStackProviderJS
    dyeLeather(color: DyeColor): ItemStackProviderJS
    addHeat(temperature: number): ItemStackProviderJS
    addPowder(): ItemStackProviderJS
    addTrait(trait: string): ItemStackProviderJS
    removeTrait(trait: string): ItemStackProviderJS
    addGlass(): ItemStackProviderJS
    copyFood(): ItemStackProviderJS
    copyForgingBonus(): ItemStackProviderJS
    copyHeat(): ItemStackProviderJS
    copyInput(): ItemStackProviderJS
    emptyBowl(): ItemStackProviderJS
    resetFood(): ItemStackProviderJS
    copyOldestFood(): ItemStackProviderJS
    addBait(): ItemStackProviderJS
    meal(food: Consumer<BuildFoodItemData>, portions?: Consumer<BuildPortionData>[]): ItemStackProviderJS
    // The following are available if FirmaLife is installed
    firmaLifeAddPiePan(): ItemStackProviderJS
    firmaLifeCopyDynamicFood(): ItemStackProviderJS
    firmaLifeEmptyPan(): ItemStackProviderJS
}
```

- `.stack()`{: .language-javascript }: Returns the `ItemStack` of the ISP
- `.modifiers()`{: .language-javascript }: Returns a json array of all of the applied modifiers
- `.isEmpty()`{: .language-javascript }: Returns true if the stack and modifier list is empty
- `.withCount(i: number)`{: .language-javascript }: Sets the stacks count to the provided value
- `.getCount()`{: .language-javascript }: Returns the stack's count
- `.getJsonStack()`{: .language-javascript }: Returns a json object representing the item stack
- `.getModifiersOfType(type: string)`{: .language-javascript }: Returns a list of json objects which represent the applied modifiers with the given type
- `.toJson()`{: .language-javascript }: Returns the json representation of the ISP
- `.asCanonClass()`{: .language-javascript }: Returns the ISP as an `ItemStackProvider` object, TFC's canonical class for this data
- `.dependsOnInput()`{: .language-javascript }: Returns true if any of the applied modifiers is dependent on the recipe's input
- `.copy()`{: .language-javascript }: Returns a copy of the ISP
- `.getTag()`{: .language-javascript }: Returns the item stack's `CompoundTag`, may be null
- `.setTag(tag: CompoundTag)`{: .language-javascript }: Sets the item stack's `CompoundTag`
- `.mergeTag(tag: CompoundTag)`{: .language-javascript }: Merges the provided `CompoundTag` into the item stack's
- `.simpleModifier(type: string)`{: .language-javascript }: Adds a modifier of the provided type
- `.jsonModifier(modifier: JsonObject)`{: .language-javascript }: Adds the provided json modifier
- `.dyeLeather(color: DyeColor)`{: .language-javascript }: Adds a `tfc:dye_leather` modifier with the provided color
- `.addHeat(temperature: number)`{: .language-javascript }: Adds a [`tfc:add_heat`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#add-heat) with the provided temperature, allows negative values
- `.addPowder()`{: .language-javascript }: Adds a [`tfc:add_powder`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#add-powder) modifier
- `.addTrait(trait: string)`{: .language-javascript }: Adds a [`tfc:add_trait`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#add-trait) modifier with the provided trait value
- `.removeTrait(trait: string)`{: .language-javascript }: Adds a [`tfc:remove_trait`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#remove-trait) modifier with the provided trait value
- `.addGlass()`{: .language-javascript }: Adds a [`tfc:add_glass`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#add-glass) modifier
- `.copyFood()`{: .language-javascript }: Adds a [`tfc:copy_food`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#copy-food) modifier
- `.copyForgingBonus()`{: .language-javascript }: Adds a [`tfc:copy_forging_bonus`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#copy-forging-bonus) modifier
- `.copyHeat()`{: .language-javascript }: Adds a [`tfc:copy_heat`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#copy-heat) modifier
- `.copyInput()`{: .language-javascript }: Adds a [`tfc:copy_input`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#copy-input) modifier
- `.emptyBowl()`{: .language-javascript }: Adds a [`tfc:empty_bowl`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#empty-bowl) modifier
- `.resetFood()`{: .language-javascript }: Adds a [`tfc:reset_food`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#reset-food) modifier
- `.copyOldestFood()`{: .language-javascript }: Adds a [`tfc:copy_oldest_food`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#copy-oldest-food) modifier
- `.addBait()`{: .language-javascript }: Adds a [`tfc:add_bait_to_rod`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#add-bait-to-rod) modifier
- `.meal(food: Consumer<BuildFoodItemData>, portions?: Consumer<BuildPortionData>[])`{: .language-javascript }: Adds a [`tfc:meal`](https://terrafirmacraft.github.io/Documentation/1.20.x/item-stack-modifiers/#meal) modifier
    - 1st argument: A consumer with the same methods as the 2nd argument of a [food definition]({% link kubejs_tfc/1.20.1/data.md %}#food-items)
    - *Optional 2nd argument*: An array of consumers specifying the portions of a meal
        - `.ingredient(ingredient: Ingredient)`{: .language-javascript }: Sets the portion's ingredient
        - `.nutrientModifier(modifier: number)`{: .language-javascript }: Multiplies the nutrition from the ingredient, defaults to 1
        - `.waterModifier(modifier: number)`{: .language-javascript }: Multiplies the water from the ingredient, defaults to 1
        - `.saturationModifier(modifier: number)`{: .language-javascript }: Multiplies the saturation from the ingredient, defaults to 1

<a id="firmalife"></a>If [FirmaLife](https://modrinth.com/mod/firmalife) is installed the following methods are available:

- `.firmaLifeAddPiePan()`{: .language-javascript }: Adds a `firmalife:add_pie_pan` modifier
- `.firmaLifeCopyDynamicFood()`{: .language-javascript }: Adds a `firmalife:copy_dynamic_food` modifier
- `.firmaLifeEmptyPan()`{: .language-javascript }: Adds a `firmalife:empty_pan` modifier

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
