---
layout: page
title: Misc. Features
permalink: /kubejs_tfc/1.18.2/misc/
---

# Misc. Features

This page is for features which don't fit into/warrant another page

- [Editing Existing Recipes](#editing-existing-recipes)
- [New Recipe Filters](#new-recipe-filters)
- [Bindings](#bindings)
- [Custom Food Traits](#custom-food-traits)

Looking for how to limit containers? It's been moved to the [Events](events/) page.

---

## Editing Existing Recipes
In the `recipes` event KubeJS has `replaceInput` and `replaceOutput` methods which allow the user to edit the inputs and outputs of existing recipes, unfortunately these do not apply to many of TFC's recipes due to the methods only applying to vanilla itemstacks. Thus KubeJS TFC provides several methods to modify the fluid and block inputs and fluid, item stack provider, and extra item outputs. A table for compatibility between recipe types and replace method is available in the collapsible below

<details><summary>Replace Method Table</summary>

|  | replaceInput | replaceOutput | tfcReplaceFluidInput | tfcReplaceFluidOutput | tfcReplaceBlockInput | tfcReplaceItemStackProvider | tfcReplaceExtraItem |
|---|---|---|---|---|---|---|---|
| Alloying | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Anvil Welding | inputs | ❌ | ❌ | ❌ | ❌ | output | ❌ |
| Anvil Working | input | ❌ | ❌ | ❌ | ❌ | output | ❌ |
| Barrel Instant Fluid | ❌ | ❌ | input fluids | output fluid | ❌ | ❌ | ❌ |
| Barrel Instant | input item | ❌ | input fluid | output fluid (if present) | ❌ | output item (if present) | ❌ |
| Barrel Sealed | input item | ❌ | input fluid | output fluid (if present) | ❌ | output item (if present) | ❌ |
| Blast Furnace | input catalyst | ❌ | input fluid | output fluid | ❌ | ❌ | ❌ |
| Bloomery | item catalyst | ❌ | input fluid | ❌ | ❌ | output item | ❌ |
| Casting | mold item | ❌ | input fluid | ❌ | ❌ | output item | ❌ |
| Chiseling | chisel items (if present) | ❌ | ❌ | ❌ | block input | extra drop (if present) | ❌ |
| Collapse/Landslide | ❌ | ❌ | ❌ | ❌ | block input | ❌ | ❌ |
| Heating | input item | ❌ | ❌ | output fluid ( if present) | ❌ | output item (if present) | ❌ |
| Knapping | ❌ | output item | ❌ | ❌ | ❌ | ❌ | ❌ |
| Loom | input item | ❌ | ❌ | ❌ | ❌ | output item | ❌ |
| Simple Pot | input item | output items | input fluid | output fluid | ❌ | ❌ | ❌ |
| Quern | input item | ❌ | ❌ | ❌ | ❌ | output item | ❌ |
| Rock Knapping | input item | output item | ❌ | ❌ | ❌ | ❌ | ❌ |
| Scraping | input item | ❌ | ❌ | ❌ | ❌ | output item | ❌ |
| Adv. Crafting | input item(s) | ❌ | ❌ | ❌ | ❌ | output item | ❌ |
| Damage Inputs Crafting | unknown | unknown | ❌ | ❌ | ❌ | unknown | ❌ |
| Extra Products Crafting | unkown | unknown | ❌ | ❌ | ❌ | unknown | extra output items |
| Drying | input item | ❌ | ❌ | ❌ | ❌ | output item | ❌ |
| Smoking | input item | ❌ | ❌ | ❌ | ❌ | output item | ❌ |
| Mixing Bowl | input items (if present) | output item (if present) | input fluid (if present) | output fluid (if present) | ❌ | ❌ | ❌ |
| Pumpkin Knapping | ❌ | output item | ❌ | ❌ | ❌ | ❌ | ❌ |
| Oven | input item | ❌ | ❌ | ❌ | ❌ | output item | ❌ |
| Vat | input item (if present) | ❌ | input fluid (if present) | output fluid (if present) | ❌ | output item (if present) | ❌ |
| Auto Quern | input item | output item | ❌ | ❌ | ❌ | ❌ | ❌ |
| Extruding Machine | input item | ❌ | ❌ | ❌ | ❌ | output item | ❌ |
| Rolling Machine | input item | ❌ | ❌ | ❌ | ❌ | output item | ❌ |

</details>

### Replacing Fluid Inputs
- *optional 1st argument*: A recipe filter, defaults to ALWAYS_TRUE
- 2nd argument: A [fluid stack ingredient](wrappers/#fluid-stack-ingredient), the fluid ingredient to be replaced
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
- 2nd argument: A [block ingredient](wrappers/#block-ingredient), the block ingredient to be replaced
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
- 2nd argument: An [item stack provider](wrappers/#item-stack-provider), the item provider to be replaced
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
- 1st argument: A [fluid stack ingredient](wrappers/#fluid-stack-ingredient), the fluid ingredient to look for in recipes
- *optional 2nd argument*: A boolean, determines if the filter should be exact, defaults to false

```js
TFCRecipeFilter.fluidInput('#tfc:milks')
```

### Item Provider Filter
- 1st argument: A [item stack provider](wrappers/#item-stack-provider), the item stack provider to look for in recipes
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
Bindings are objects which represent internal Java classes which can be used in scripts without having to directly load the class in your scripts. The three major bindings can be found in the [Wrappers](wrappers/) page. Another is also described above.

### FireResult
Represents the fire result of a [StartFireEvent](events/#start-fire), it has three values:
- `IF_FAILED`: Places a fire block if the event isn't cancelled
- `ALWAYS`: Guarantees a fire block will be placed
- `NEVER`: Forbids a fire block from being placed

```js
FireResult.ALWAYS
```

### FireStrength
Represents the strength of a StartFireEvent, it currently has two valuse:
- `STRONG`: Representing a fire starting where
  - The fire starting is the primary functionality, or
  - Destructive fire starting behavior is desired (creating fire blocks, lighting log piles)
- `WEAK`: Representing a fire starting where
  - The fire starting may have been secondary behavior or a side effect (misclicks)
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
- `getModel(Object)`: Will try its best to get a ClimateModel form the provided object, else returning the default biome-based model
- `getName(ClimateModel)`: Will retrieve the name of the provided climate model
- `getCurrentTemperature(BlockContainerJS)`: Returns the temperature at the specified block at that moment
- `getTemperture(BlcokContainerJS, Long)`: Returns the temperature at the specified block at he provided calendar tick
- `getAverageTemperture(BlockContainerJS)`: Returns the average temperature at the specified block
- `getAverageRainfall(BlockContainerJS)`: Returns the average rainfall at the specified block
- `getFogginess(BlockContainerJS)`: Returns the fogginess at the specified block
- `getWaterFogginess(BlockContainerJS)`: Returns the water fogginess at the specified block
- `isWarnEnoughToRain(BlockContainerJS)`: Returns true if it is warm enough to rain at the specified block

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
- `getTemperatureModifier()`: Returns a number that TFC uses to adjust the temperature during a month
- `next()`: Returns the next month
- `isWithin(Month, Month)`: Returns true if the month is between the two provided months
- `getSeason()`: Returns the season the month is in

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
- `next()`: Returns the next season
- `previous()`: Returns the previous season

```js
Season.FALL.next()
```

### Calendar
A collection of methods for getting information about the calendar. Methods with 'calendar' in their name are synced with the daylight cycle and should not be used to save time stamps as they may go backwards

- `getCalendarTicksInMonth(Integer)`: Returns how many ticks are in a month based upon the provided number of days in a month
- `getCalendarTicksInYear(Integer)`: Returns how many ticks are in a year based upon the provided number of days in a month
- `getTotalMinutes(number)`: Returns how many in-game minutes are in the number of provided time
- `getTotalhours(number)`: Returns how many in-game hours are in the number of provided time
- `getTotalDays(number)`: Returns how many in-game days are in the number of provided time
- `getTotalMonths(number, Integer)`: Returns how many in-game months are in the number of provided time for the provided number of days in a month
- `getTotalYears(number, Integer)`: Returns how many in-game years are in the number of provided time for the provided number of days in a month
- `getMinuteOfHour(number)`: Returns the minute of the hour, [0, 59] of the provided time
- `getHourOfDay(number)`: Returns the hour of the day, [0, 23], of the provided time
- `getDayOfMonth(number, Integer)`: Returns the day of the month of the provided time for the provided number of days in a month
- `getFractionOfMonth(number, Integer)`: Returns how far through a month, [0, 1], the provided time is for the given number of days in a month
- `getFractionOfYear(number, Integer)`: Returns how far through a year, [0, 1], the provided time is for the given number of days in a month
- `getMonthOfYear(number, Integer)`: Returns the month of the provided time for the given number of days in a month
- `getTimeAndDate(number, Integer)`: Returns a text component displaying text component displaying an exact time stamp of the provided time and number of days in a month
- `getTimeAndDat(Integer, Integer, Month, Integer, number)`: Returns a text component displaying an exact time stamp of the provided hour, minute, month, day, and year
- `getTimeDelta(number, Integer)`: Returns a text component displaying the amount of time in hour/day/month/year format for the provided number of ticks and number of days in a month

The following methods return a Calendar object
- `getCalendar()`: Returns a Calendar, may be the server or client side calendar depending on if the calling location appears to be server or client side
- `getCalendar(boolean)`: Returns a Calendar. If true returns the client calendar, else the server calendar
- `getCalendar(LevelReader)`: Returns the provided level's calendar
- `getCalendar(LevelJS)`: Returns the provided LevelJS's calendar

The calendars have the following methods available
- `getTicks()`: Returns the amount of ticks since the world was created
- `getCalendarTicks()`: Returns the amount of ticks since Jan 1, 1000
- `getCalendarDaysInMonth()`: Returns the amount of days in a month
- `ticksToCalendarTicks(number)`: Returns the calendar tick corresponding to the given tick
- `getTotalHours()`: Returns the total amount of hours passed
- `getTotalCalendarHours()`: Returns the total number of hours passed since Jan 1, 1000
- `getTotaldays()`: Returns the total amount of days passed
- `getTotalCalendarDays()`: Returns the total amount of days passed since Jan 1, 1000
- `getTotalMonths()`: Returns the total amount of months passed
- `getTotalCalendarMonths()`: Returns the total amount of months passed since Jan 1, 1000
- `getTotalYears()`: Returns the total amount of years passed
- `getTotalCalendarYears()`: Returns the total amount of years passed since Jan 1, 1000
- `getCalendarDayTime()`: Returns the equivalent total world time; 0 = 6:00 which is calendar time 6000
- `getCalendarDayOfMonth()`: Returns the current day of the month
- `getCalendarFractionOfMonth()`: Returns the progress through the month
- `getCalendarFractionOfYear()`: Returns the progress though the year
- `getCalendarDayOfYear()`: Returns a text component displaying the current day of the week
- `getCalendarMonthOfYear()`: Returns a text component displaying the current month of the year
- `getCalendarTicksInMonth()`: Returns the number of ticks in a month
- `getCalendarTicksInYear()`: Returns the number of ticks in a year
- `getCalendarTimeAndDate()`: Returns a text component displaying an exact time stamp
- `getTimeDelta(number)`: Returns a text component displaying a length of time based upon the number given

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
    // registers a trait which increases the rate of decay
    event.registerTrait(1.4, 'kubejs:trash')
    // Registers a trait which slows the rate of decay and adds a tooltip of 'Saran Wrapped!'
    event.registerTraitWithName(0.3, 'kubejs:saran_wrapped', 'Saran Wrapped!')
})
```