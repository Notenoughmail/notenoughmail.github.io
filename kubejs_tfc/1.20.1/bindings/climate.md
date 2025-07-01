---
layout: page
title: Climate Bindings
permalink: /kubejs_tfc/1.20.1/bindings/climate/
parent: Bindings
grand_parent: 1.20.1
---

# Climate Bindings

TFC uses climate models to determine the the temperature, rainfall, and several other things, these can be [created]({% link kubejs_tfc/1.20.1/events.md %}#register-climate-model) and [added]({% link kubejs_tfc/1.20.1/events.md %}#select-climate-model) to the world to be used

These methods provide a convenient way of accessing the information about a world's climate

These are available under the `TFC.climate` field

## Method Signatures

```js
TFC.climate.getModel(o: any): @Nullable ClimateModel
TFC.climate.getName(model: ClimateModel): ResourceLocation
TFC.climate.getCurrentTemperature(level: Level, pos: BlockPos): number
TFC.climate.getTemperature(level: Level, pos: BlockPos, calendarTicks: number): number
TFC.climate.getAverageTemperature(level: Level, pos: BlockPos): number
TFC.climate.getAverageRainfall(level: Level, pos: BlockPos): number
TFC.climate.getFogginess(level: Level, pos: BlockPos): number
TFC.climate.getWaterFogginess(level: Level, pos: BlockPos): number
TFC.climate.getWindVector(level: Level, pos: BlockPos): number
TFC.climate.isWarmEnoughToRain(level: Level, pos: BlockPos): Vec2
```

- `.getModel(o: any)`{: .language-javascript .m-link #get-model }: Attempts to get a climate model from the provided object, will return null if it cannot do so
- `.getName(model: ClimateModel)`{: .language-javascript .m-link #get-name}: Returns the name of the provided climate model
- `.getCurrentTemperature(level: Level, pos: BlockPos)`{: .language-javascript .m-link #get-current-temp }: Returns the current temperature at the given level and position
- `.getTemperature(level: Level, pos: BlockPos, calendarTicks: number)`{: .language-javascript .m-link #get-temp }: Returns the temperature at the given level, position, and calendar tick
- `.getAverageTemperature(level: Level, pos: BlockPos)`{: .language-javascript .m-link #get-avg-temp }: Returns the yearly average temperature at the given level and position
- `.getAverageRainfall(level: Level, pos: BlockPos)`{: .language-javascript .m-link #get-rain}: Returns the yearly average temperature at the given level and position
- `.getFogginess(level: Level, pos: BlockPos)`{: .language-javascript .m-link #get-fog }: Returns the current air fog value at the given level and position
- `.getWaterFogginess(level: Level, pos: BlockPos)`{: .language-javascript .m-link #get-water-fog }: Returns the current water fog value at the given level and position
- `.getWindVector(level: Level, pos: BlockPos)`{: .language-javascript .m-link #get-wind }: Returns the current `Vec2` wend vector at the given level and position
- `.isWarmEnoughToRain(level: Level, pos: BlockPos)`{: .language-javascript .m-link #warm-enough-to-rain }: Returns `true`{:.p} if it is currently warm enough to rain at the given level and position

## Example

```js
PlayerEvents.tick(event => {
    if (event.level.gameTime % 20 < 1) {
        if (TFC.climate.getCurrentTemperature(event.level, event.player.blockPosition()) > 40) {
            event.player.data['tfc:player_data'].addThirst(3)
        }
    }
})
```
