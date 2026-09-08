---
s: item_stack_provider
title: '`ItemStackProvider`'
anchor: item-stack-provider
cat:
    - kubejs_tfc
    - 1.21.1
    - type_exp
---

{% capture def_0 %}Defaults to `0`{:.n}{% endcapture %}
{% capture def_1 %}Defaults to `1`{:.n}{% endcapture %}

An `ItemStackProvider` is a recipe output, effectively an `ItemStack` with a list of transformations which are applied to it at completion of the recipe. It can be created using the dedicated [sub-binding]({% link kubejs_tfc/1.21.1/bindings/isp.md %}) or, when required as a method argument, by passing in an `ItemStack` or anything that will wrap to an `ItemStack`

Providers have several methods by which they can be used and modified

- `.stack(): ItemStack`{: .language-kube-21 #{{ page.anchor }}-stack }: Get the base output `ItemStack` of the provider
- `.modifiers(): List<ItemStackModifier>`{: .language-kube-21 #{{ page.anchor }}-modifiers }: Get the provider's list of modifiers
- `.prettyPrint(): String`{: .language-kube-21 #{{ page.anchor }}-pretty-print }: Similar to `.toString()`{:.language-kube-21} but includes the class name of enum-based modifiers
- `.getSingleStack(input: ItemStack): ItemStack`{: .language-kube-21 #{{ page.anchor }}-get-single-stack }: Get the output stack of the provider, for the given input stack, assuming the input is a single item
- `.getSingleStackDisplayOnly(input: ItemStack): ItemStack`{: .language-kube-21 #{{ page.anchor }}-get-single-stack-display-only }: [`.getSingleStack(ItemStack)`{:.language-kube-21}](#{{ page.anchor }}-get-single-stack){:.preserve-color} but for display-only (`no_random_chance`{:.e}) contexts
- `.getEmptyStack(): ItemStack`{: .language-kube-21 #{{ page.anchor }}-get-empty-stack }: Get the output stack of the provider, without taking the input stack into consideration
- `.getStack(input: ItemStack): ItemStack`{: .language-kube-21 #{{ page.anchor }}-get-stack-0 }: Get the output stack of the provider, for the given input stack
    - **Note**: The presence of `CopyInputModifier`s may cause the resultant stack to have the same stack size as the input, if that is not desired use [`.getSingleStack(ItemStack)`{:.language-kube-21}](#{{ page.anchor }}-get-single-stack){:.preserve-color}
- `.getStack(input: ItemStack, context: StackModifierContext): ItemStack`{: .language-kube-21 #{{ page.anchor }}-get-stack-1 }: Get the output stack of the provider
    - `input:ItemStack`{:.language-kube-21}: The given input stack
    - `context: StackModifierContext`{:.language-kube-21}: The context under which the modifiers will be evaluated
        {% include enum_list.html summary='Reveal/hide list of contexts' values='default,no_random_chance' %}
    - **Note**: The note in [`.getStack(ItemStack)`{:.language-kube-21}](#{{ page.anchor }}-get-stack-0){:.preserve-color} also applies
- `.dependsOnInput(): boolean`{: .language-kube-21 #{{ page.anchor }}-depends-on-input }: If any of the provider's modifiers depend on the input stack
- `.isEmpty(): boolean`{: .language-kube-21 #{{ page.anchor }}-is-empty }: If the provider has no modifiers and its stack is empty
- `.toJson(): JsonElement`{: .language-kube-21 #{{ page.anchor }}-to-json }: Serializes the provider to json
- `.toNBT(): Tag`{: .language-kube-21 #{{ page.anchor }}-to-nbt }: Serializes the provider to nbt
- `.copy(): ItemStackProvider`{: .language-kube-21 #{{ page.anchor }}-copy }: Copies the provider with a mutable modifier list
- `.copyImmutable(): ItemStackProvider`{: .language-kube-21 #{{ page.anchor }}-copy-immutable }: Copies the provider with an immutable modifier list
- `.addModifier(modifier: ItemStackModifier): @Self ItemStackProvider`{: .language-kube-21 #{{ page.anchor }}-add-modifier }: Adds the given modifier to the provider
- `.addJsonModifier(json: JsonObject): @Self ItemStackProvider`{: .language-kube-21 #{{ page.anchor }}-add-json-modifier }: Parses the given json as an `ItemStackModifer` and adds it to the provider
- `.addSimpleModifier(type: ResourceLocation): @Self ItemStackProvider`{: .language-kube-21 #{{ page.anchor }}-add-simple-modifier }: Adds a modifier of the given type, only valid for modifiers with no additional parameters
- `.copyInputStack(): @Self ItemStackProvider`{: .language-kube-21 #{{ page.anchor }}-copy-input-stack }: Adds a `tfc:copy_input` modifier to the provider
- `.copyFood(): @Self ItemStackProvider`{: .language-kube-21 #{{ page.anchor }}-copy-food }: Adds a `tfc:copy_food` modifier to the provider
- `.copyOldestFood(): @Self ItemStackProvider`{: .language-kube-21 #{{ page.anchor }}-copy-oldest-food }: Adds a `tfc:copy_oldest_food` modifier to the provider
- `.copyHeat(): @Self ItemStackProvider`{: .language-kube-21 #{{ page.anchor }}-copy-heat }: Adds a `tfc:copy_heat` modifier to the provider. Copies the input stack's temperature to the output stack
- `.copyForgingBonus(): @Self ItemStackProvider`{: .language-kube-21 #{{ page.anchor }}-copy-forging-bonus }: Adds a `tfc:copy_forging_bonus` modifier to the provider. Copies the input stack's forging bonus to the output
- `.resetFood(): @Self ItemStackProvider`{: .language-kube-21 #{{ page.anchor }}-reset-food }: Adds a `tfc:reset_food` modifier to the provider
- `.emptyBowl(): @Self ItemStackProvider`{: .language-kube-21 #{{ page.anchor }}-empty-bowl }: Adds a `tfc:empty_bowl` modifier to the provider. Sets the output stack to the contents of the input's `tfc:bowl` component or `minecraft:bowl` if not present
- `.addBaitToRod(): @Self ItemStackProvider`{: .language-kube-21 #{{ page.anchor }}-add-bait-to-rod }: Adds a `tfc:add_bait_to_rod` modifier to the provider
- `.addGlass(): @Self ItemStackProvider`{: .language-kube-21 #{{ page.anchor }}-add-glass }: Adds a `tfc:add_glass` modifier to the provider
- `.addPowder(): @Self ItemStackProvider`{: .language-kube-21 #{{ page.anchor }}-add-powder }: Adds a `tfc:add_powder` modifier to the provider
- `.craftingRemainder(): @Self ItemStackProvider`{: .language-kube-21 #{{ page.anchor }}-crafting-remainder }: Adds a `tfc:crafting_remainder` modifier to the provider. Sets the output to the crafting remainder of the input stack
- `.damageInput(): @Self ItemStackProvider`{: .language-kube-21 #{{ page.anchor }}-damage-input }: Adds a `tfc:damage_crafting_remainder` modifier to the provider. Sets the output to the input if it has durability and removes durability if possible
- `.addTrait(trait: Holder<FoodTrait>): @Self ItemStackProvider`{: .language-kube-21 #{{ page.anchor }}-add-trait }: Adds a `tfc:add_trait` modifier to the provider. Adds the given trait to the output
- `.removeTrait(trait: Holder<FoodTrait>): @Self ItemStackProvider`{: .language-kube-21 #{{ page.anchor }}-remove-trait }: Adds a `tfc:remove_trait` modifier to the provider. Removes the given trait from the output
- `.addHeat(temperature: number): @Self ItemStackProvider`{: .language-kube-21 #{{ page.anchor }}-add-heat }: Adds a `tfc:add_heat` modifier to the provider. Increases the output's temperature by the given amount, in °C
- `.dyeLeather(color: DyeColor): @Self ItemStackProvider`{: .language-kube-21 #{{ page.anchor }}-dye-leather }: Adds a `tfc:dye_leather` modifier, which adds the given color to dyeable items, to the provider. Adds the given color to dyable items
- `.removeDye(): @Self ItemStackProvider`{: .language-kube-21 #{{ page.anchor }}-remove-dye }: Adds a `tfc:remove_dye` modifier to the provider
- `.meal(food: FoodData, portions...: MealPortion[]): @Self ItemStackProvider`{: .language-kube-21 #{{ page.anchor }}-meal }: Adds a `tfc:meal` modifier to the provider
    - `food: FoodData`{:.language-kube-21}: The base food properties, a map of parameters to values
        - `hunger?: int`{:.language-kube-21}: The amount of hunger to add. A full hunger bar is 20
            - {{ def_0 }}
        - `water?: number`{:.language-kube-21}: The amount of thirst to restore. A full thirst bar is 100
            - {{ def_0 }}
        - `saturation?: number`{:.language-kube-21}: The amount of saturation to provide
            - {{ def_0 }}
        - `intoxication?: int`{:.language-kube-21}: The number of ticks of intoxication to add to the player
            - {{ def_0 }}
        - `grain?: number`{:.language-kube-21}: The amount of grain nutrient to add to the player
            - {{ def_0 }}
        - `fruit?: number`{:.language-kube-21}: The amount of fruit nutrient to add to the player
            - {{ def_0 }}
        - `vegetables?: number`{:.language-kube-21}: The amount of vegetables nutrient to add to the player
            - {{ def_0 }}
        - `protein?: number`{:.language-kube-21}: The amount of protein nutrient to add to the player
            - {{ def_0 }}
        - `dairy?: number`{:.language-kube-21}: The amount of dairy nutrient to add to the player
            - {{ def_0 }}
        - `decayModifier?: number`{:.language-kube-21}: The decay modifier to apply, a higher value means a quicker decay
            - {{ def_0 }}
    - `portions...: MealPortion[]`{:.language-kube-21}: The meal portions. These are checked in order for each input food and the first to match will be used. Portions can be made as a map of parameters to values
        - `ingredient?: Ingredient`{:.language-kube-21}: The food item(s) to match
            - Optional, if not specified will match all items
        - `nutrientModifier?: number`{:.language-kube-21}: The multiplier to apply to the `ingredient`{:.v}'s nutrient values
            - {{ def_1 }}
        - `waterModifier?: number`{:.language-kube-21}: The multiplier to apply to the `ingredient`{:.v}'s water value
            - {{ def_1 }}
        - `saturationModifier?: number`{:.language-kube-21}: The multiplier to apply to the `ingredient`{:.v}'s saturation value
            - {{ def_1 }}
- `.extraProduct(stack: ItemStack): @Self ItemStackProvider`{: .language-kube-21 #{{ page.anchor }}-extra-product }: Adds a `tfc:extra_products` modifier to the provider. Gives the provided stack to the crafting player, if present
- `.chance(chance: number): @Self ItemStackProvider`{: .language-kube-21 #{{ page.anchor }}-chance }: Adds a `tfc:chance` modifier to the provider. Applies the chance, {% in_unit %}, to the output
