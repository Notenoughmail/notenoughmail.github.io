---
layout: page
title: Misc. Features
permalink: /kubejs_tfc/1.18.2/misc/
parent: 1.18.2
grand_parent: KubeJS TFC
---

# Misc. Features

This page is for features which don't fit into/warrant another page

- [Editing Existing Recipes](#editing-existing-recipes)
- [New Recipe Filters](#new-recipe-filters)
- [Bindings](#bindings)
- [Custom Food Traits](#custom-food-traits)

Looking for how to limit containers? It's been moved to the [Events]({% link kubejs_tfc/1.18.2/events.md %}) page.

---

## Editing Existing Recipes

In the `recipes` event KubeJS has `replaceInput` and `replaceOutput` methods which allow the user to edit the inputs and outputs of existing recipes, unfortunately these do not apply to many of TFC's recipes due to the methods only applying to vanilla item stacks. Thus KubeJS TFC provides several methods to modify the fluid and block inputs and fluid, item stack provider, and extra item outputs. A table for compatibility between recipe types and replace method is available in the collapsible below

<details><summary>Replace Method Table</summary>

<table>
    <thead>
        <col0>
            <th></th>
        </col0>
        <col1>
            <th>replaceInput</th>
        </col1>
        <col2>
            <th>replaceOutput</th>
        </col2>
        <col3>
            <th>tfcReplaceFluidInput</th>
        </col3>
        <col4>
            <th>tfcReplaceFluidOutput</th>
        </col4>
        <col5>
            <th>tfcReplaceBlockInput</th>
        </col5>
        <col6>
            <th>tfcReplaceItemStackProvider</th>
        </col6>
        <col7>
            <th>tfcReplaceExtraItem</th>
        </col7>
    </thead>
    <tbody>
        <alloy>
            <td>Alloying</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
        </alloy>
    </tbody>
    <tbody>
        <weld>
            <td>Anvil Welding</td>
            <td>inputs</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>output</td>
            <td>❌</td>
        </weld>
    </tbody>
    <tbody>
        <work>
            <td>Anvil Working</td>
            <td>input</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>output</td>
            <td>❌</td>
        </work>
    </tbody>
    <tbody>
        <fluidinst>
            <td>Barrel Instant Fluid</td>
            <td>❌</td>
            <td>❌</td>
            <td>input fluids</td>
            <td>output fluid</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
        </fluidinst>
    </tbody>
    <tbody>
        <inst>
            <td>Barrel Instant</td>
            <td>input item</td>
            <td>❌</td>
            <td>input fluid</td>
            <td>output fluid (if present)</td>
            <td>❌</td>
            <td>output item (if present)</td>
            <td>❌</td>
        </inst>
    </tbody>
    <tbody>
        <sealed>
            <td>Barrel Sealed</td>
            <td>input item</td>
            <td>❌</td>
            <td>input fluid</td>
            <td>output fluid (if present)</td>
            <td>❌</td>
            <td>output item (if present)</td>
            <td>❌</td>
        </sealed>
    </tbody>
    <tbody>
        <blast>
            <td>Blast Furnace</td>
            <td>input catalyst</td>
            <td>❌</td>
            <td>input fluid</td>
            <td>output fluid</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
        </blast>
    </tbody>
    <tbody>
        <bloom>
            <td>Bloomery</td>
            <td>item catalyst</td>
            <td>❌</td>
            <td>input fluid</td>
            <td>❌</td>
            <td>❌</td>
            <td>output item</td>
            <td>❌</td>
        </bloom>
    </tbody>
    <tbody>
        <cast>
            <td>Casting</td>
            <td>mold item</td>
            <td>❌</td>
            <td>input fluid</td>
            <td>❌</td>
            <td>❌</td>
            <td>output item</td>
            <td>❌</td>
        </cast>
    </tbody>
    <tbody>
        <chisel>
            <td>Chiseling</td>
            <td>chisel items (if present)</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>block input</td>
            <td>extra drops (if present)</td>
            <td>❌</td>
        </chisel>
    </tbody>
    <tbody>
        <colslid>
            <td>Collapse/Landslide</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>block input</td>
            <td>❌</td>
            <td>❌</td>
        </colslid>
    </tbody>
    <tbody>
        <heat>
            <td>Heating</td>
            <td>input item</td>
            <td>❌</td>
            <td>❌</td>
            <td>output fluid (if present)</td>
            <td>❌</td>
            <td>output item (if present)</td>
            <td>❌</td>
        </heat>
    </tbody>
    <tbody>
        <knap>
            <td>Knapping</td>
            <td>❌</td>
            <td>output item</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
        </knap>
    </tbody>
    <tbody>
        <loom>
            <td>Loom</td>
            <td>input item</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>output item</td>
            <td>❌</td>
        </loom>
    </tbody>
    <tbody>
        <pot>
            <td>Simple Pot</td>
            <td>input item</td>
            <td>output items</td>
            <td>input fluid</td>
            <td>output fluid</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
        </pot>
    </tbody>
    <tbody>
        <quern>
            <td>Quern</td>
            <td>input item</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>output item</td>
            <td>❌</td>
        </quern>
    </tbody>
    <tbody>
        <rknap>
            <td>Rock Knapping</td>
            <td>input item</td>
            <td>output item</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
        </rknap>
    </tbody>
    <tbody>
        <scrape>
            <td>Scraping</td>
            <td>input item</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>output item</td>
            <td>❌</td>
        </scrape>
    </tbody>
    <tbody>
        <advcra>
            <td>Adv. Crafting</td>
            <td>input item(s)</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>output item</td>
            <td>❌</td>
        </advcra>
    </tbody>
    <tbody>
        <dmgincra>
            <td>Damage Inputs Crafting</td>
            <td>unknown</td>
            <td>unknown</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>unknown</td>
            <td>❌</td>
        </dmgincra>
    </tbody>
    <tbody>
        <xtracra>
            <td>Extra Products Crafting</td>
            <td>unknown</td>
            <td>unknown</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>unknown</td>
            <td>extra output items</td>
        </xtracra>
    </tbody>
    <tbody>
        <dry>
            <td>Drying</td>
            <td>input item</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>output item</td>
            <td>❌</td>
        </dry>
    </tbody>
    <tbody>
        <smoke>
            <td>Smoking</td>
            <td>input item</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>output item</td>
            <td>❌</td>
        </smoke>
    </tbody>
    <tbody>
        <mix>
            <td>Mixing Bowl</td>
            <td>input items (if present)</td>
            <td>❌</td>
            <td>input fluid (if present)</td>
            <td>output fluid (if present)</td>
            <td>❌</td>
            <td>output item (if present)</td>
            <td>❌</td>
        </mix>
    </tbody>
    <tbody>
        <pknap>
            <td>Pumpkin Knapping</td>
            <td>❌</td>
            <td>output item</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
        </pknap>
    </tbody>
    <tbody>
        <oven>
            <td>Oven</td>
            <td>input item</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>output item</td>
            <td>❌</td>
        </oven>
    </tbody>
    <tbody>
        <vat>
            <td>Vat</td>
            <td>input item (if present)</td>
            <td>❌</td>
            <td>input fluid (if present)</td>
            <td>output fluid (if present)</td>
            <td>❌</td>
            <td>output item (if present)</td>
            <td>❌</td>
        </vat>
    </tbody>
    <tbody>
        <aquern>
            <td>Auto-Quern</td>
            <td>input item</td>
            <td>output item</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
        </aquern>
    </tbody>
    <tbody>
        <extrmac>
            <td>Extruding Machine</td>
            <td>input item</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>output item</td>
            <td>❌</td>
        </extrmac>
    </tbody>
    <tbody>
        <rollmac>
            <td>Rolling Machine</td>
            <td>input item</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>❌</td>
            <td>output item</td>
            <td>❌</td>
        </rollmac>
    </tbody>
</table>

</details>

### Replacing Fluid Inputs

- *optional 1st argument*: A recipe filter, defaults to ALWAYS_TRUE
- 2nd argument: A [fluid stack ingredient]({% link kubejs_tfc/1.18.2/wrappers.md %}#fluid-stack-ingredient), the fluid ingredient to be replaced
- 3rd argument: A fluid stack ingredient, the fluid ingredient to replace with
- *optional 4th argument*: A boolean, determines if the match should be exact, defaults to false

#### Example

```js
onEvent('recipes', event => {
    event.tfcReplaceFluidInput('minecraft:water', 'minecraft:lava')
})
```

### Replacing Fluid Outputs

- *optional 1st argument*: A recipe filter, defaults to ALWAYS_TRUE
- 2nd argument: A fluid stack, the fluid output to be replaced
- 3rd argument: A fluid stack, the fluid stack to replace with
- *optional 4th argument*: A boolean, determines if the match should be exact, defaults to false

#### Example

```js
onEvent('recipes', event => {
    event.tfcReplaceFluidOutput('tfc:blue_dye', 'minecraft:water')
})
```

### Replacing Block Inputs

- *optional 1st argument*: A recipe filter, defaults to ALWAYS_TRUE
- 2nd argument: A [block ingredient]({% link kubejs_tfc/1.18.2/wrappers.md %}#block-ingredient), the block ingredient to be replaced
- 3rd argument: A block ingredient, the block ingredient to replace with
- *optional 4th argument*: A boolean, determines if the match should be exact, defaults to false

#### Example

```js
onEvent('recipes', event => {
    event.tfcReplaceBlockInput(/tfc:rock\/cobble\/.+/, 'minecraft:cobblestone')
})
```

### Replacing Item Stack Providers

- *optional 1st argument*: A recipe filter, defaults to ALWAYS_TRUE
- 2nd argument: An [item stack provider]({% link kubejs_tfc/1.18.2/wrappers.md %}#item-stack-provider), the item provider to be replaced
- 3rd argument: A item stack provider, the item provider to replace with
- *optional 4th argument*: A boolean, determines if the match should be exact, defaults to false

Keep in mind it is unlikely this method will be able to replace items tack providers which use the `copy_input` modifier

#### Example

```js
onEvent('recipes', event => {
    event.tfcReplaceItemStackProvider('tfc:raw_iron_bloom', 'minecraft:iron_ingot')
})
```

### Replacing Extra Outputs

Used for the extra outputs of extra products shaped/shapeless crafting

- *optional 1st argument*: A recipe filter, defaults to ALWAYS_TRUE
- 2nd argument: An item ingredient, the item to be replaced
- 3rd argument: An item stack, the item to be replaced with
- *optional 4th argument*: A boolean, determines if the match should be exact, defaults to false

#### Example

```js
onEvent('recipes', event => {
    event.tfcReplaceExtraItem('tfc:straw', 'minecraft:music_disc_stal')
})
```

---

## New Recipe Filters

Recipe filters filter recipes based on certain properties they have, the tfc specific ones are built through the `TFCRecipeFilter` object

### Block Ingredient Filter

- 1st argument: A block ingredient, the block ingredient input to look for in recipes
- *optional 2nd argument*: A boolean, determines if the filter should be exact, defaults to false

```js
TFCRecipeFilter.blockIngredient('tfc:rock/cobblestone/andesite')
```

### Fluid Output Filter

- 1st argument: A fluid stack, the fluid output to look for in recipes
- *optional 2nd argument*: A boolean, determines if the filter should be exact, defaults to false

```js
TFCRecipeFilter.fluidOutput('tfc:salt_water')
```

### Fluid Input Filter

- 1st argument: A [fluid stack ingredient]({% link kubejs_tfc/1.18.2/wrappers.md %}#fluid-stack-ingredient), the fluid ingredient to look for in recipes
- *optional 2nd argument*: A boolean, determines if the filter should be exact, defaults to false

```js
TFCRecipeFilter.fluidInput('#tfc:milks')
```

### Item Provider Filter

- 1st argument: A [item stack provider]({% link kubejs_tfc/1.18.2/wrappers.md %}#item-stack-provider), the item stack provider to look for in recipes
- *optional 2nd argument*: A boolean, determines if the filter should be exact, defaults to false

```js
TFCRecipeFilter.itemProvider('tfc:metal/chain/bismuth_bronze',)
```

### Extra Item Filter

- 1st argument: An item , the item to look for in recipes
- *optional 2nd argument*: A boolean, determines if the filter should be exact, defaults to false

```js
TFCRecipeFilter.extraItem('tfc:straw')
```

## Bindings

Bindings are objects which represent internal Java classes which can be used in scripts without having to directly load the class in your scripts. The three major bindings can be found in the [Wrappers]({% link kubejs_tfc/1.18.2/wrappers.md %}) page. Another is also described above.

### FireResult

Represents the fire result of a [StartFireEvent]({% link kubejs_tfc/1.18.2/events.md %}#start-fire), it has three values:

- `IF_FAILED`: Places a fire block if the event isn't cancelled
- `ALWAYS`: Guarantees a fire block will be placed
- `NEVER`: Forbids a fire block from being placed

```js
FireResult.ALWAYS
```

### FireStrength

Represents the strength of a StartFireEvent, it currently has two values:

- `STRONG`: Representing a fire starting where
    - The fire starting is the primary functionality, or
    - Destructive fire starting behavior is desired (creating fire blocks, lighting log piles)
- `WEAK`: Representing a fire starting where
    - The fire starting may have been secondary behavior or a side effect (mis-clicks)
    - Destructive fire starting behaviors should not be attempted

```js
FireStrength.WEAK
```

Currently this only useful for posting a new StartFireEvent

### AnimalAge

Represents the age of an animal, it has three values:

- `CHILD`
- `ADULT`
- `OLD`

```js
AnimalAge.OLD
```

### AnimalGender

Represents the gender of an animal, it has two values:

- `MALE`
- `FEMALE`

```js
AnimalGender.MALE
```

### Climate

A collection of helpful methods when dealing with climate models

- `.getModel(Object)`{: .language-kube }: Will try its best to get a ClimateModel form the provided object, else returning the default biome-based model
- `.getName(ClimateModel)`{: .language-kube }: Will retrieve the name of the provided climate model
- `.getCurrentTemperature(BlockContainerJS)`{: .language-kube }: RReturns the temperature at the specified block at that moment
- `.getTemperature(BlockContainerJS, Long)`{: .language-kube }: RReturns the temperature at the specified block at he provided calendar tick
- `.getAverageTemperature(BlockContainerJS)`{: .language-kube }: RReturns the average temperature at the specified block
- `.getAverageRainfall(BlockContainerJS)`{: .language-kube }: Returns the average rainfall at the specified block
- `.getFogginess(BlockContainerJS)`{: .language-kube }: Returns the fogginess at the specified block
- `.getWaterFogginess(BlockContainerJS)`{: .language-kube }: Returns the water fogginess at the specified block
- `.isWarnEnoughToRain(BlockContainerJS)`{: .language-kube }: Returns true if it is warm enough to rain at the specified block

```js
Climate.getModel('kubejs:my_advanced_model')
```

### Month

Represents the months of the year

- `JANUARY`
- `FEBRUARY`
- `MARCH`
- `APRIL`
- `MAY`
- `JUNE`
- `JULY`
- `AUGUST`
- `SEPTEMBER`
- `OCTOBER`
- `NOVEMBER`
- `DECEMBER`

Each month also has a few methods:

- `.getTemperatureModifier()`{: .language-kube }: Returns a number that TFC uses to adjust the temperature during a month
- `.next()`{: .language-kube }: Returns the next month
- `.isWithin(Month, Month)`{: .language-kube }: Returns true if the month is between the two provided months
- `.getSeason()`{: .language-kube }: Returns the season the month is in

```js
Month.JULY.next()
```

### Season

Represents the seasons of the year

- `SPRING`
- `SUMMER`
- `FALL`
- `WINTER`

Each season also has a few methods:

- `.next()`{: .language-kube }: Returns the next season
- `.previous()`{: .language-kube }: Returns the previous season

```js
Season.FALL.next()
```

### Calendar

A collection of methods for getting information about the calendar. Methods with 'calendar' in their name are synced with the daylight cycle and should not be used to save time stamps as they may go backwards

- `.getCalendarTicksInMonth(Integer)`{: .language-kube }: Returns how many ticks are in a month based upon the provided number of days in a month
- `.getCalendarTicksInYear(Integer)`{: .language-kube }: Returns how many ticks are in a year based upon the provided number of days in a month
- `.getTotalMinutes(number)`{: .language-kube }: Returns how many in-game minutes are in the number of provided time
- `.getTotalHours(number)`{: .language-kube }: Returns how many in-game hours are in the number of provided time
- `.getTotalDays(number)`{: .language-kube }: Returns how many in-game days are in the number of provided time
- `.getTotalMonths(number, Integer)`{: .language-kube }: Returns how many in-game months are in the number of provided time for the provided number of days in a month
- `.getTotalYears(number, Integer)`{: .language-kube }: Returns how many in-game years are in the number of provided time for the provided number of days in a month
- `.getMinuteOfHour(number)`{: .language-kube }: Returns the minute of the hour, [0, 59] of the provided time
- `.getHourOfDay(number)`{: .language-kube }: Returns the hour of the day, [0, 23], of the provided time
- `.getDayOfMonth(number, Integer)`{: .language-kube }: Returns the day of the month of the provided time for the provided number of days in a month
- `.getFractionOfMonth(number, Integer)`{: .language-kube }: Returns how far through a month, [0, 1], the provided time is for the given number of days in a month
- `.getFractionOfYear(number, Integer)`{: .language-kube }: Returns how far through a year, [0, 1], the provided time is for the given number of days in a month
- `.getMonthOfYear(number, Integer)`{: .language-kube }: Returns the month of the provided time for the given number of days in a month
- `.getTimeAndDate(number, Integer)`{: .language-kube }: Returns a text component displaying text component displaying an exact time stamp of the provided time and number of days in a month
- `.getTimeAndDat(Integer, Integer, Month, Integer, number)`{: .language-kube }: Returns a text component displaying an exact time stamp of the provided hour, minute, month, day, and year
- `.getTimeDelta(number, Integer)`{: .language-kube }: Returns a text component displaying the amount of time in hour/day/month/year format for the provided number of ticks and number of days in a month

The following methods return a Calendar object

- `.getCalendar()`{: .language-kube }: Returns a Calendar, may be the server or client side calendar depending on if the calling location appears to be server or client side
- `.getCalendar(boolean)`{: .language-kube }: Returns a Calendar. If true returns the client calendar, else the server calendar
- `.getCalendar(LevelReader)`{: .language-kube }: Returns the provided level's calendar
- `.getCalendar(LevelJS)`{: .language-kube }: Returns the provided LevelJS's calendar

The calendars have the following methods available

- `.getTicks()`{: .language-kube }: Returns the amount of ticks since the world was created
- `.getCalendarTicks()`{: .language-kube }: Returns the amount of ticks since Jan 1, 1000
- `.getCalendarDaysInMonth()`{: .language-kube }: Returns the amount of days in a month
- `.ticksToCalendarTicks(number)`{: .language-kube }: Returns the calendar tick corresponding to the given tick
- `.getTotalHours()`{: .language-kube }: Returns the total amount of hours passed
- `.getTotalCalendarHours()`{: .language-kube }: Returns the total number of hours passed since Jan 1, 1000
- `.getTotalDays()`{: .language-kube }: Returns the total amount of days passed
- `.getTotalCalendarDays()`{: .language-kube }: Returns the total amount of days passed since Jan 1, 1000
- `.getTotalMonths()`{: .language-kube }: Returns the total amount of months passed
- `.getTotalCalendarMonths()`{: .language-kube }: Returns the total amount of months passed since Jan 1, 1000
- `.getTotalYears()`{: .language-kube }: Returns the total amount of years passed
- `.getTotalCalendarYears()`{: .language-kube }: Returns the total amount of years passed since Jan 1, 1000
- `.getCalendarDayTime()`{: .language-kube }: Returns the equivalent total world time; 0 = 6:00 which is calendar time 6000
- `.getCalendarDayOfMonth()`{: .language-kube }: Returns the current day of the month
- `.getCalendarFractionOfMonth()`{: .language-kube }: Returns the progress through the month
- `.getCalendarFractionOfYear()`{: .language-kube }: Returns the progress though the year
- `.getCalendarDayOfYear()`{: .language-kube }: Returns a text component displaying the current day of the week
- `.getCalendarMonthOfYear()`{: .language-kube }: Returns a text component displaying the current month of the year
- `.getCalendarTicksInMonth()`{: .language-kube }: Returns the number of ticks in a month
- `.getCalendarTicksInYear()`{: .language-kube }: Returns the number of ticks in a year
- `.getCalendarTimeAndDate()`{: .language-kube }: Returns a text component displaying an exact time stamp
- `.getTimeDelta(number)`{: .language-kube }: Returns a text component displaying a length of time based upon the number given

```js
Calendar.getCalendar().getTotalYears()
```

## Custom Food Traits

Food traits are applied to food items while in a container or after completion of a recipe (i.e. `Burnt to a Crisp!`, `Preserved`, and `In Vinegar`) and are used to affect how fast an item rots. New food traits can be made through the `tfc.food_trait.register` event which has two methods for doing so.

### registerTrait(number,ResourceLocation)

This registers a new food trait with a decay modifier given by the number, in the namespace of the provided `ResourceLocation`

### registerTraitWithName(number,ResourceLocation,String)

This registers a new food trait with s decay modifier given by the number, in the namespace of the provided `ResourceLocation` which provides a tooltip to an item with this modifier matching the given string.

### Examples

```js
onEvent('tfc.food_trait.register', event => {
    // Registers a trait which increases the rate of decay
    event.registerTrait(1.4, 'kubejs:trash')
    // Registers a trait which slows the rate of decay and adds a tooltip of 'Saran Wrapped!'
    event.registerTraitWithName(0.3, 'kubejs:saran_wrapped', 'Saran Wrapped!')
})
```
