---
layout: page
title: Custom Registry Objects
permalink: /kubejs_tfc/1.21.1/registry/
parent: 1.21.1
grand_parent: KubeJS TFC
desc: Non-item/block registry types
---

# Custom Registry Objects

KubeJS TFC adds the ability to register some TFC-specific non-item/block types

- [Chisel Mode](#chisel-mode)
- [Climate Model Type](#climate-model-type)
- [Food Trait](#food-trait)
- [Glass Operation](#glass-operation)
- [Item Stack Modifier](#item-stack-modifier)
- [Spring Water](#spring-water)

## Chisel Mode

Chisel modes are used when [chiseling]({% link kubejs_tfc/1.21.1/recipes.md %}#chisel)

The registry for chisel modes is `tfc:chisel_mode`

{: #chisel-model-methods }

### Methods

- `.priority(priority: int)`{: .language-kube-21 #chisel-mode-priority }: Sets the 'priority' of the chisel mode when sorting chisel modes for cycling. Defaults to `300`{:.n}
- `.hotbarIcon(textureLocation: ResourceLocation, x: int, y: int)`{: .language-kube-21 #chisel-mode-hotbar-icon }: Sets the texture to use when displayed in the hotbar. Draws the 20 x 20 pixel area at the x and y coordinate
- `.recipeIcon(textureLocation: ResourceLocation, x: int, y: int, width: int, height: int)`{: .language-kube-21 #chisel-mode-recipe-icon }: Sets the texture to use when displayed in recipe viewers
- `.chiselBehavior(behavior: ChiselBehavior)`{: .language-kube-21 #chisel-mode-chisel-behavior }: Sets the behavior when chiseling is performed. Accepts a callback with the params
    - `original: BlockState`{:.language-kube-21}: The original state being chiseled
    - `chiseled: BlockState`{:.language-kube-21}: The chiseled state specified by the recipe
    - `player: Player`{:.language-kube-21}: The player chiseling
    - `hit: BlockHitResult`{:.language-kube-21}: The hit result of the player
    - `return: @Nullable BlockState`{:.language-kube-21}: The chiseled state to place in-world, may be null to indicate an invalid value
    Defaults to returning the `chiseled`{:.v} state

{: #chisel-mode-example }

### Example

```js-21
StartupEvents.registry('tfc:chisel_mode', event => {
    event.create('my_chisel_mode')
        .hotbarIcon('kubejs:block/my_chisel_mode/hotbar', 0, 0)
        .recipeIcon('kubejs:block/my_chisel_mode/recipe', 0, 0, 20, 20)
        .chiselBehavior((original, chiseled, player, hit) => {
            if (orginal.hasBlockEntity()) {
                return null
            } else {
                return chiseled
            }
        })
})
```

## Climate Model Type

Climate models define the temperature, rainfall, and other climatic factors of a world. They are created and [added]({% link kubejs_tfc/1.21.1/events.md %}#selected-climate-model) to a level at world-start, but must have a registered type. KubeJS TFC adds the ability to create types and easily create models from them

The registry for climate model types is `tfc:climate_model`

{: #climate-model-type-methods }

### Methods

{% capture calendar %}[calendar]({% link kubejs_tfc/1.21.1/bindings/calendar.md %}){% endcapture %}
{% capture model %}[`ClimateModel`]({% link kubejs_tfc/1.21.1/type-explanations.md %}#climate-model){% endcapture %}
{% capture timeless %}[`TimelessClimateValueFunction`{:.f}](#climate-model-type-timeless-value-function){:.preserve-color}{% endcapture %}
{% capture climate %}[`ClimateValueFunction`{:.f}](#climate-model-type-value-function){:.preserve-color}{% endcapture %}

- `.wind(wind: WindFunction)`{: .language-kube-21 #climate-model-type-wind }: Sets the wind calculation of the model, accepts a callback with the params
    - `model: ClimateModel`{:.language-kube-21}: The {{ model }} the wind is being calculated for
    - `level: Level`{:.language-kube-21}: The level wind is being calculated for
    - `pos: BlockPos`{:.language-kube-21}: The position the wind is being calculated for
    - `calendarTick: int`{:.language-kube-21}: The {{ calendar }} timestamp at which wind is being calculated at
    - `daysInMonth: int`{:.language-kube-21}: The number of days in a month
    - `wind: Function<number, number, Vec2>`{:.language-kube-21}: A helper function to create a `Vec2` without reflection. Use `.blow(x: float, z: float)`{:.language-kube-21} to do so
    - `return: Vec2`{:.language-kube-21}: The calculated horizontal wind vector
- `.fog(fog: TimelessClimateValueFunction)`{: .language-kube-21 #climate-model-type-fog }: Sets the fog calculation of the model, accepts a {{ timeless }}. The returned value will be clamped to {% range_unit %}
- `.calendarFog(fog: ClimateValueFunction)`{: .language-kube-21 #climate-model-type-calendar-fog }: Sets the fog calculation of the model, accepts a {{ climate }}. The returned value will be clamped to {% range_unit %}
- `.averageTemperature(temp: TimelessClimateValueFunction)`{: .language-kube-21 #climate-model-type-average-temperature }: Sets the average temperature calculation of the model. Accepts a {{ timeless }} which returns the average temperature, in °C, at the position
- `.averageRainfall(rain: TimelessClimateValueFunction)`{: .language-kube-21 #climate-model-type-average-rain }: Sets the average rainfall calculation of the model, accepts a {{ timeless }}. Returned values will be clamped to {% range 0,Infinity,) %}
- `.rainVariance(variance: TimelessClimateValueFunction)`{: .language-kube-21 #climate-model-type-rain-variance }: Sets the rain variance calculation of the model, accepts a {{ timeless }}. Returned values will be clamped to {% range -1,1 %}
- `.thunder(thunder: BiPredicate<ClimateModel, int>)`{: .language-kube-21 #climate-model-type-thunder }: Sets the calculation for if its currently raining at a calendar timestamp, given it is raining. Accepts a callback with the params
    - `model: ClimateModel`{:.language-kube-21}: The {{ model }} the calculation is for
    - `calendarTick: int`{:.language-kube-21}: The {{ calendar }} timestamp being evaluated at
    - `return: boolean`{:.language-kube-21}: If it is thundering at the timestamp
- `.rainIntensity(intensity: BiFunction<ClimateModel, int, number>)`{: .language-kube-21 #climate-model-type-rain-intensity }: Sets the calculation for the rain intensity. Accepts a callback with the parameters
    - `model: ClimateModel`{:.language-kube-21}: The {{ model }} the calculation is for
    - `calendarTick: int`{:.language-kube-21}: The {{ calendar }} timestamp being evaluated at
    - `return: number`{:.language-kube-21}: The intensity, typically {% in_unit %}, but may be greater to indicate extreme rain intensity or negative to indicate it is not raining
- `.instantaneousTemperature(temp: ClimateValueFunction)`{: .language-kube-21 #climate-model-type-instantaneous-temperature }: Sets the calculation for the instantaneous temperature of the model, accepts a {{ climate }}
- `.instantaneousRainfall(rain: ClimateValueFunction)`{: .language-kube-21 #climate-model-type-instantaneous-rainfall }: Sets the calculation for the instantaneous rainfall of the model, accepts a {{ climate }}
- `.baseGroundwater(groundwater: TimelessClimateValueFunction)`{: .language-kube-21 #climate-model-type-base-groundwater }: Sets the groundwater calculation of the model, accepts a {{ timeless }}. Returned values will be clamped to {% range 0,Infinity,) %}

{: #climate-model-type-timeless-value-function}

#### `TimelessClimateValueFunction`{:.f}

A callback with the following parameters

- `model: ClimateModel`{:.language-kube-21}: The {{ model }} the value is being calculated for
- `level: LevelReader`{:.language-kube-21}: The level the value is being calculated in
- `pos: BlockPos`{:.language-kube-21}: The position the value is being calculated at
- `return: number`{:.language-kube-21}: The calculated value

{: #climate-model-type-value-function }

#### `ClimateValueFunction`{:.f}

A callback with the following parameters

- `model: ClimateModel`{:.language-kube-21}: The {{ model }} the value is being calculated for
- `level: LevelReader`{:.language-kube-21}: The level the value is being calculated in
- `pos: BlockPos`{:.language-kube-21}: The position the value is being calculated at
- `calendarTick: int`{:.language-kube-21}: The {{ calendar }} timestamp at which the value is being calculated at
- `daysInMonth: int`{:.language-kube-21}: The number of days in a month
- `return: number`{:.language-kube-21}: The calculated value

{: #climate-model-type-example }

### Example

```js-21
StartupEvents.registry('tfc:climate_model', event => {
    event.create('hell')
        .wind((model, level, pos, calendarTick, daysInMonth, wind) => {
            let dir = calendarTick / 1000
            return wind.blow(Math.sin(dir), Math.cos(dir)).scaled(Math.cos(dir) * 100)
        })
        .thunder((model, calendarTick) => true)
        .rainIntensity((model, calendarTick) => 2)
        .averageTemperature((model, level, pos) => {
            return pos.y > 20 ? 88 : 92
        })
        .instantaneousTemperature((model, level, pos, calendarTicks, daysInMonth) => {
            let yearlength = daysInMonth * 12 * 24000
            let yearPortion = (calendarTicks % yearLength) / yearLength
            // +/- 7 degrees dependent on progress through year
            let currentDeviation = Math.cos(yearPortion * 2 * Math.PI) * 7
            // Use the model's average temperature (as calculated above) as a base
            return model.getAverageTemperature(level, pos) + currentDeviation
        })
})
```

## Food Trait

Food traits can be applied to food items to modify how long it takes them to expire

The registry for food traits is `tfc:food_trait`

{: #food-trait-methods }

### Methods

- `.decayModifier(modifier: number)`{: .language-kube-21 #food-trait-decay-modifier }: Sets the decay modifier of the trait. A larger value results in a quicker expiry
- `.decayModifierSupplier(modifier: Supplier<number>)`{: .language-kube-21 #food-trait-decay-modifier-supplier }: Sets the modifier of the trait as a supplier
- `.tooltipKey(key: String)`{: .language-kube-21 #food-trait-tooltip-key }: Gives the food trait a tooltip with the specified translation key
- `.tooltipText(text: Component)`{: .language-kube-21 #food-trait-tooltip-text }: Gives the food trait a tooltip with the given text, autogenerating a lang key if not already specified

{: #food-trait-example }

### Example

```js-21
StartupEvents.registry('tfc:food-trait', event => {
    event.create('my_trait')
        .decayModifier(0.5)
        .tooltipText('Well preserved')
})
```

## Glass Operation

Glass operations are used in [glassworking recipes]({% link kubejs_tfc/1.21.1/recipes.md %}#glassworking) and are performed by [specific items]({% link kubejs_tfc/1.21.1/items.md %}#glassworking) and [tools]({% link kubejs_tfc/1.21.1/items.md %}#glassworking-tool)

The registry for glass operations is `tfc:glass_operation`

{: #glass-operation-methods }

### Methods

- `.powder(texture: ResourceLocation)`{: .language-kube-21 #glass-operation-powder }: Marks the operation as being associated with a powder item and sets the texture used in the powder bowl
- `.workingTemperature(temperature: number)`{: .language-kube-21 #glass-operation-working-temperature }: Sets the minimum temperature required to apply the operation
- `.applicationSound(sound: Holder<SoundEvent>)`{: .language-kube-21 #glass-operation-use-sound }: Sets the sound[^1] to use when the operation is applied
- `.items(items...: Holder<Item>[])`{: .language-kube-21 }: Sets the items associated with the operation, used for recipe viewers and, if a powder, powder bowls

[^1]: A full list of sounds can be obtained by running the command `/kubejs dump_registry minecraft:sound_event`{:.language-command} in-game

{: #glass-operation-example }

### Example

```js-21
StartupEvents.registry('tfc:glass_operation', event => {
    event.create('my_operation')
        .powder('minecraft:block/cobblestone')
        .items('kubejs:stone_dust', 'kubejs:pulverized_mineral_sample')
})
```

## Item Stack Modifier

Item stack modifiers are used by [`ItemStackProvider`s]({% link kubejs_tfc/1.21.1/type-explanations.md %}#item-stack-provider) to modify a stack, typically at the completion of a recipe

The registry for item stack modifiers is `tfc:item_stack_modifiers`

{: #item-stack-modifier-methods }

### Methods

- `.applicator(applicator: TriFunction<ItemStack, ItemStack, StackModifierContext, ItemStack>)`{: .language-kube-21 #item-stack-modifier-applicator }: Sets the behavior of the modifier, accepts a callback with the params
    - `stack: ItemStack`{:.language-kube-21}: The original output stack, may be freely modified
    - `input: ItemStack`{:.language-kube-21}: The input stack, should not be modified in any way
    - `context: StackModifierContext`{:.language-kube-21}: The context under which the modifier is being evaluated, may be either `default`{:.e} or `no_random_chance`{:.e}
    - `return: ItemStack`{:.language-kube-21}: The modified output item stack
- `.applicatorWithInventory(applicator: QuadFunction<ItemStack, ItemStack, StackModifierContext, Iterable<ItemStack>, ItemStacl>)`{: .language-kube-21 #item-stack-modifier-applicator-with-inventory}: Sets the behavior of the modifier, accepts a callback with the params
    - `stack: ItemStack`{:.language-kube-21}: The original output stack, may be freely modified
    - `input: ItemStack`{:.language-kube-21}: The input stack, should not be modified in any way
    - `context: StackModifierContext`{:.language-kube-21}: The context under which the modifier is being evaluated, may be either `default`{:.e} or `no_random_chance`{:.e}
    - `inventory: Iterable<ItemStack>`{:.language-kube-21}: An [iterable](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Iterable.html) view of the inventory's items
    - `return: ItemStack`{:.language-kube-21}: The modified output item stack

{: #item-stack-modifier-example }

### Example

```js-21
StartupEvents.registry('tfc:item_stack_modifiers', event => {
    event.create('copy_cheese')
        .applicator((stack, input, ctx) => {
            if (input.has('cheese_mod:cheese')) {
                stack.patch({
                    'cheese_mod:cheese': input.get('cheese_mod:cheese')
                })
            }
            return stack
        })
})
```

## Spring Water

{% comment %}

### climate model type timeless value function

### climate model type value function

{% endcomment %}
