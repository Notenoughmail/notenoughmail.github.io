---
layout: none
s: item_stack_provider
title: '`ItemStackProvider`'
anchor: item-stack-provider
cat:
    - kubejs_tfc
    - 1.21.1
    - type_exp
---

An `ItemStackProvider` is a recipe output, effectively an `ItemStack` with a list of transformations which are applied to it at completion of the recipe. It can be created using the dedicated [sub-binding]({% link kubejs_tfc/1.21.1/bindings/isp.md %}) or, when required as a method argument, by passing in an `ItemStack` or anything that will wrap to an `ItemStack`

Providers have several methods by which they can be used and modified

- `.stack(): ItemStack`{: .language-kube-21 #isp-stack }: Get the base output `ItemStack` of the provider
- `.modifiers(): List<ItemStackModifier>`{: .language-kube-21 #isp-modifiers }: Get the provider's list of modifiers
- `.getSingleStack(input: ItemStack): ItemStack`{: .language-kube-21 #isp-get-single-stack }: Get the output stack of the provider, for the given input stack, assuming the input is a single item
- `.getSingleStackDisplayOnly(input: ItemStack): ItemStack`{: .language-kube-21 #isp-get-single-stack-display-only }: [`.getSingleStack(ItemStack)`{:.language-kube-21}](#isp-get-single-stack){:.preserve-color} but for display-only (`no_random_chance`{:.e}) contexts
- `.getEmptyStack(): ItemStack`{: .language-kube-21 #isp-get-empty-stack }: Get the output stack of the provider, without taking the input stack into consideration
- `.getStack(input: ItemStack): ItemStack`{: .language-kube-21 #isp-get-stack-0 }: Get the output stack of the provider, for the given input stack. **Note**: The presence of `CopyInputModifier`s may cause the resultant stack to have the same stack size as the input, if that is not desired use [`.getSingleStack(ItemStack)`{:.language-kube-21}](#isp-get-single-stack){:.preserve-color}
- `.getStack(input: ItemStack, context: StackModifierContext): ItemStack`{: .language-kube-21 #isp-get-stack-1 }: Get the output stack of the provider, for the given input stack and context. The context may be either `default`{:.e} or `no_random_chance`{:.e} and the note in [`.getStack(ItemStack)`{:.language-kube-21}](#isp-get-stack-0){:.preserve-color} also applies
- `.dependsOnInput(): boolean`{: .language-kube-21 #isp-depends-on-input }: If any of the provider's modifiers depend on the input stack
- `.isEmpty(): boolean`{: .language-kube-21 #isp-is-empty }: If the provider has no modifiers and its stack is empty
- `.toJson(): JsonElement`{: .language-kube-21 #isp-to-json }: Serializes the provider to json
- `.toNBT(): Tag`{: .language-kube-21 #isp-to-nbt }: Serializes the provider to nbt
- `.copy(): ItemStackProvider`{: .language-kube-21 #isp-copy }: Copies the provider with a mutable modifier list
- `.copyImmutable(): ItemStackProvider`{: .language-kube-21 #isp-copy-immutable }: Copies the provider with an immutable modifier list
- `.addModifier(modifier: ItemStackModifier): @Self ItemStackProvider`{: .language-kube-21 #isp-add-modifier }: Adds the given modifier to the provider
- `.addJsonModifier(json: JsonObject): @Self ItemStackProvider`{: .language-kube-21 #isp-add-json-modifier }: Parses the given json as an `ItemStackModifer` and adds it to the provider
- `.addSimpleModifier(type: ResourceLocation): @Self ItemStackProvider`{: .language-kube-21 #isp-add-simple-modifier }: Adds a modifier of the given type, only valid for modifiers with no additional parameters
- `.copyInputStack(): @Self ItemStackProvider`{: .language-kube-21 #isp-copy-input-stack }: Adds a `tfc:copy_input` modifier to the provider
- `.copyFood(): @Self ItemStackProvider`{: .language-kube-21 #isp-copy-food }: Adds a `tfc:copy_food` modifier to the provider
- `.copyOldestFood(): @Self ItemStackProvider`{: .language-kube-21 #isp-copy-oldest-food }: Adds a `tfc:copy_oldest_food` modifier to the provider
- `.copyHeat(): @Self ItemStackProvider`{: .language-kube-21 #isp-copy-heat }: Adds a `tfc:copy_heat` modifier to the provider. Copies the input stack's temperature to the output stack
- `.copyForgingBonus(): @Self ItemStackProvider`{: .language-kube-21 #isp-copy-forging-bonus }: Adds a `tfc:copy_forging_bonus` modifier to the provider. Copies the input stack's forging bonus to the output
- `.resetFood(): @Self ItemStackProvider`{: .language-kube-21 #isp-reset-food }: Adds a `tfc:reset_food` modifier to the provider
- `.emptyBowl(): @Self ItemStackProvider`{: .language-kube-21 #isp-empty-bowl }: Adds a `tfc:empty_bowl` modifier to the provider. Sets the output stack to the contents of the input's `tfc:bowl` component or `minecraft:bowl` if not present
- `.addBaitToRod(): @Self ItemStackProvider`{: .language-kube-21 #isp-add-bait-to-rod }: Adds a `tfc:add_bait_to_rod` modifier to the provider
- `.addGlass(): @Self ItemStackProvider`{: .language-kube-21 #isp-add-glass }: Adds a `tfc:add_glass` modifier to the provider
- `.addPowder(): @Self ItemStackProvider`{: .language-kube-21 #isp-add-powder }: Adds a `tfc:add_powder` modifier to the provider
- `.craftingRemainder(): @Self ItemStackProvider`{: .language-kube-21 #isp-crafting-remainder }: Adds a `tfc:crafting_remainder` modifier to the provider. Sets the output to the crafting remainder of the input stack
- `.damageInput(): @Self ItemStackProvider`{: .language-kube-21 #isp-damage-input }: Adds a `tfc:damage_crafting_remainder` modifier to the provider. Sets the output to the input if it has durability and removes durability if possible
- `.addTrait(trait: Holder<FoodTrait>): @Self ItemStackProvider`{: .language-kube-21 #isp-add-trait }: Adds a `tfc:add_trait` modifier to the provider. Adds the given trait to the output
- `.removeTrait(trait: Holder<FoodTrait>): @Self ItemStackProvider`{: .language-kube-21 #isp-remove-trait }: Adds a `tfc:remove_trait` modifier to the provider. Removes the given trait from the output
- `.addHeat(temperature: number): @Self ItemStackProvider`{: .language-kube-21 #isp-add-heat }: Adds a `tfc:add_heat` modifier to the provider. Increases the output's temperature by the given amount, in °C
- `.dyeLeather(color: DyeColor): @Self ItemStackProvider`{: .language-kube-21 #isp-dye-leather }: Adds a `tfc:dye_leather` modifier, which adds the given color to dyeable items, to the provider. Adds the given color to dyable items
- `.removeDye(): @Self ItemStackProvider`{: .language-kube-21 #isp-remove-dye }: Adds a `tfc:remove_dye` modifier to the provider
- `.meal(food: FoodData, portions...: MealPortion[]): @Self ItemStackProvider`{: .language-kube-21 #isp-meal }: Adds a `tfc:meal` modifier to the provider
    - `food: FoodData`{:.language-kube-21}: ...
    - `portions...: MealPortion[]`{:.language-kube-21}: ...
- `.extraProduct(stack: ItemStack): @Self ItemStackProvider`{: .language-kube-21 #isp-extra-product }: Adds a `tfc:extra_products` modifier to the provider. Gives the provided stack to the player, if present
- `.chance(chance: number): @Self ItemStackProvider`{: .language-kube-21 #isp-chance }: Adds a `tfc:chance` modifier to the provider. Applies the chance, {% in_unit %}, to the output

{% comment %}

## isp get single stack

## isp get stack 0

{% endcomment %}
