---
s: climate_model
title: '`ClimateModel`'
anchor: climate-model
cat:
    - kubejs_tfc
    - 1.21.1
    - type_exp
---

A climate model is TFC's way of calculating information about a level's temperature, rainfall, groundwater, wind, and other climatic properties at a position at a specific time or for a yearly average

Climate models have several methods to retrieve the above mentioned information

{% capture tick %}[calendar tick](#icalendar-get-calendar-ticks){% endcapture %}

- `.hemisphereScale(): number`{: .language-kube-21 #{{ page.anchor }}-hemisphere-scale }: The hemisphere scale. Effectively the distance between the polar and equatorial region in blocks
- `.getAverageTemperature(level: LevelReader, pos: BlockPos): number`{: .language-kube-21 #{{ page.anchor }}-get-average-temperature }: Get the yearly average temperature, in °C, at the given position
- `.getInstantTemperature(level: LevelReader, pos: BlockPos): number`{: .language-kube-21 #{{ page.anchor }}-get-instant-temperature-0 }: Get the current temperature, in °C, at the given position
- `.getInstantTemperature(level: LevelReader, pos: BlockPos, calendarTick: int, daysInMonth: int): number`{: .language-kube-21 #{{ page.anchor }}-get-instant-temperature-1 }: Get the temperature, in °C, at the given {{ tick }} and position
- `.getTimeAverageTemperature(level: LevelReader, pos: BlockPos, fromTick: int, toTick: int, daysInMonth: int): number`{: .language-kube-21 #{{ page.anchor }}-get-time-average-temperature }: Get the average temperature, in °C, at the given position over the given {{ tick }} range
- `.getAverageRainfall(level: LevelReader, pos: BlockPos): number`{: .language-kube-21 #{{ page.anchor }}-get-average-rainfall }: Get the yearly average rainfall, in mm/yr, at the given position
- `.getRainfallVariance(level: LevelReader, pos: BlockPos): number`{: .language-kube-21 #{{ page.anchor }}-get-rainfall-variance }: Get the annual rainfall variance, {% in_range -1,1 %}, at the given position. Positive values indicate wet summers, while negative values indicate wet winters
- `.getInstantRainfall(level: LevelReader, pos: BlockPos): number`{: .language-kube-21 #{{ page.anchor }}-get-instant-rainfall-0 }: Get the current rainfall, in mm/yr, at the given position
- `.getInstantRainfall(level: LevelReader, pos: BlockPos, calendarTick: int, daysInMonth: int): number`{: .language-kube-21 #{{ page.anchor }}-get-instant-rainfall-1 }: Get the rainfall, in mm/yr, at the given {{ tick }} and position
- `.getTimeAverageRainfall(level: LevelReader, pos: BlockPos, fromTick: int, toTick: int, daysInMonth: int): number`{: .language-kube-21 #{{ page.anchor }}-get-time-average-rainfall }: Get the average rainfall, in mm/yr, at the given position over the given {{ tick }} range
- `.getBaseGroundwater(level: LevelReader, pos: BlockPos): number`{: .language-kube-21 #{{ page.anchor }}-get-base-groundwater }: Get the base groundwater level, in mm, at the given position
- `.getAverageGroundwater(level: LevelReader, pos: BlockPos): number`{: .language-kube-21 #{{ page.anchor }}-get-average-groundwater }: Get the yearly average base groundwater level, in mm, at the given position
- `.getInstantGroundwater(level: LevelReader, pos: BlockPos): number`{: .language-kube-21 #{{ page.anchor }}-get-instant-groundwater-0 }: Get the current groundwater level, in mm, at the given position
- `.getInstantGroundwater(level: LevelReader, pos: BlockPos, calendarTick: int, daysInMonth: int): number`{: .language-kube-21 #{{ page.anchor }}-get-instant-groundwater-1 }: Get the base groundwater, in mm, at the given {{ tick }} and position
- `.getTimeAverageGroundwater(level: LevelReader, pos: BlockPos, fromTick: int, toTick: int, daysInMonth: int): number`{: .language-kube-21 #{{ page.anchor }}-get-time-average-groundwater }: Get the average groundwater level, in mm, at the given position over the given {{ tick }} range
- `.getRain(calendarTick: int): number`{: .language-kube-21 #{{ page.anchor }}-get-rain }: Get the rainfall intensity, generally {% in_unit %}, at the given {{ tick }}
- `.getThunder(calendarTick: int): boolean`{: .language-kube-21 #{{ page.anchor }}-get-thunder }: Get if it is thundering at the given {{ tick }}
- `.supportsRain(): boolean`{: .language-kube-21 #{{ page.anchor }}-supports-rain }: If the model supports historical querying of rainfall and if TFC should override a level's rainfall intensity with that of the model
- `.getWind(level: Level, pos: BlockPos): Vec2`{: .language-kube-21 #{{ page.anchor }}-get-wind-0 }: Get the current wind vector at the given position
- `.getWind(level: Level, pos: BlockPos, calendarTick: int, daysInMonth: int): Vec2`{: .language-kube-21 #{{ page.anchor }}-get-wind-1 }: Ge the wind vector at the given {{ tick }} and position
- `.getFog(level: LevelReader, pos: BlockPos): number`{: .language-kube-21 #{{ page.anchor }}-get-fog }: Get the current fog value, {% in_unit %}, for the given position
