---
layout: page
title: Climate Bindings
permalink: /kubejs_tfc/1.21.1/bindings/climate/
parent: Bindings
grand_parent: 1.21.1
desc: Bindings for interacting with TFC's climate model system
field: climate
---

# {{ page.title }}

{{ page.desc }}

```js-21
declare class CilmateBindings {

    // These can be accessed via TFC.climate.*

    getModel(level: Level): ClimateModel
    getCurrentTemperature(level: Level, pos: BlockPos): number
    getAverageTemperature(level: Level, pos: BlockPos): number
    getCurrentRainfall(level: Level, pos: BlockPos): number
    getAverageRainfall(level: Level, pos: BlockPos): number
    getRainfallVariance(level: Level, pos: BlockPos): number
    getCurrentGroundwater(level: Level, pos: BlockPos): number
    getAverageGroundwater(level: Level, pos: BlockPos): number
    getCurrentWind(level: Level, pos: BlockPos): Vec2
    getFogginess(level: Level, pos: BlockPos): number
}
```

- `.getModel(level: Level)`{: .language-kube-21 #get-model }: Gets the [`ClimateModel`]({% link kubejs_tfc/1.21.1/type-explanations.md %}#climate-model) of the level
- `.getCurrentTemperature(level: Level, pos: BlockPos)`{: .language-kube-21 #get-current-temperature }: Gets the current temperature at the level and position
- `.getAverageTemperature(level: Level, pos: BlockPos)`{: .language-kube-21 #get-average-temperature }: Gets the average temperature at the level and position
- `.getCurrentRainfall(level: Level, pos: BlockPos)`{: .language-kube-21 #get-current-rainfall }: Gets the current rainfall at the level and position
- `.getAverageRainfall(level: Level, pos: BlockPos)`{: .language-kube-21 #get-average-rainfall }: Gets the average rainfall at the level and position
- `.getRainfallVariance(level: Level, pos: BlockPos)`{: .language-kube-21 #get-rainfall-variance }: Gets the rainfall variance at the level and position
- `.getCurrentGroundwater(level: Level, pos: BlockPos)`{: .language-kube-21 #get-current-groundwater }: Gets the current groundwater at the level and position
- `.getAverageGroundwater(level: Level, pos: BlockPos)`{: .language-kube-21 #get-average-groundwater }: Gets the average groundwater at the level and position
- `.getCurrentWind(level: Level, pos: BlockPos)`{: .language-kube-21 #get-current-wind }: Gets the current wind vector at the level and position
- `.getFogginess(level: Level, pos: BlockPos)`{: .language-kube-21 #get-fogginess }: Gets the current fogginess at the level and position
