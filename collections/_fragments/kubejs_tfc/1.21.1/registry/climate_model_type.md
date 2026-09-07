---
title: Climate Model Type
anchor: climate-model-type
cat:
    - kubejs_tfc
    - 1.21.1
    - reg
desc: Climate models define the temperature, rainfall, and other climatic factors of a world. They are created and [added]({% link kubejs_tfc/1.21.1/events.md %}#selected-climate-model) to a level at world-start, but must have a registered type. KubeJS TFC adds the ability to create types and easily create models from them
reg: 'tfc:climate_model'
name: hell
example: |-
    .wind((model, level, pos, calendarTick, daysInMonth, wind) => {
        let direction = calendarTick / 1000
        return wind.blow(Math.sin(direction), Math.cos(direction)).scale(Math.cos(direction) * 100)
    })
    .thunder((model, calendarTick) => true)
    .rainIntensity((model. calendarTick) => 2)
    .averageTemperature((model, level, pos) => {
        return pos.y > 20 ? 88 : 92
    })
    .instantaneousTemperature((model, level, pos, calendarTick, daysInMonth) => {
        let yearLength = daysInMonth * 12 * TFC.calendar.CALENDAR_TICKS_IN_DAY
        let yearPortion = (calendarTick % yearLength) / yearLength
        // +/- 7 degrees dependent on progress through year
        let currentDeviation = Math.cos(yearPortion * 2 * Math.PI) * 7
        // use the model's average temperate (as calculated above) as a base
        return model.getAverageTemperature(level, pos) + currentDeviation
    })
---

{% capture timeless_anchor %}{{ page.anchor }}-timeless-value-function{% endcapture %}
{% capture climate_anchor %}{{ page.anchor }}-value-function{% endcapture %}

{% capture calendar %}[calendar]({% link kubejs_tfc/1.21.1/bindings/calendar.md %}){% endcapture %}
{% capture model %}[`ClimateModel`]({% link kubejs_tfc/1.21.1/type-explanations.md %}#climate-model){% endcapture %}
{% capture timeless %}[`TimelessClimateValueFunction`{:.f}](#{{ timeless_anchor }}){:.preserve-color}{% endcapture %}
{% capture climate %}[`ClimateValueFunction`{:.f}](#{{ climate_anchor }}){:.preserve-color}{% endcapture %}

- `.wind(wind: WindFunction)`{: .language-kube-21 #{{ page.anchor }}-wind }: Sets the wind calculation of the model, accepts a callback with the params
    - `model: ClimateModel`{:.language-kube-21}: The {{ model }} the wind is being calculated for
    - `level: Level`{:.language-kube-21}: The level wind is being calculated for
    - `pos: BlockPos`{:.language-kube-21}: The position the wind is being calculated for
    - `calendarTick: int`{:.language-kube-21}: The {{ calendar }} tick at which wind is being calculated at
    - `daysInMonth: int`{:.language-kube-21}: The number of days in a month
    - `wind: Function<number, number, Vec2>`{:.language-kube-21}: A helper function to create a `Vec2` without reflection. Use `.blow(x: float, z: float)`{:.language-kube-21} to do so
    - `return: Vec2`{:.language-kube-21}: The calculated horizontal wind vector
- `.fog(fog: TimelessClimateValueFunction)`{: .language-kube-21 #{{ page.anchor }}-fog }: A {{ timeless }}, the fog calculation of the model
    - Returned values will be clamped to {% range_unit %}
- `.calendarFog(fog: ClimateValueFunction)`{: .language-kube-21 #{{ page.anchor }}-calendar-fog }: A {{ climate }}, the fog calculation of the model
    - Returned values will be clamped to {% range_unit %}
- `.averageTemperature(temp: TimelessClimateValueFunction)`{: .language-kube-21 #{{ page.anchor }}-average-temperature }: A {{ timeless }}, the average temperature, in °C, calculation of the model
- `.averageRainfall(rain: TimelessClimateValueFunction)`{: .language-kube-21 #{{ page.anchor }}-average-rain }: A {{ timeless }}, the average rainfall calculation of the model
    - Returned values will be clamped to {% range 0,,) %}
- `.rainVariance(variance: TimelessClimateValueFunction)`{: .language-kube-21 #{{ page.anchor }}-rain-variance }: A {{ timeless }}, the rain variance calculation of the model
    - Returned values will be clamped to {% range -1,1 %}
- `.thunder(thunder: BiPredicate<ClimateModel, int>)`{: .language-kube-21 #{{ page.anchor }}-thunder }: The calculation for if its currently thundering at a calendar tick, given it is raining. Accepts a callback with the params
    - `model: ClimateModel`{:.language-kube-21}: The {{ model }} the calculation is for
    - `calendarTick: int`{:.language-kube-21}: The {{ calendar }} tick being evaluated at
    - `return: boolean`{:.language-kube-21}: If it is thundering at the tick
- `.rainIntensity(intensity: BiFunction<ClimateModel, int, number>)`{: .language-kube-21 #{{ page.anchor }}-rain-intensity }: Sets the calculation for the rain intensity. Accepts a callback with the parameters
    - `model: ClimateModel`{:.language-kube-21}: The {{ model }} the calculation is for
    - `calendarTick: int`{:.language-kube-21}: The {{ calendar }} tick being evaluated at
    - `return: number`{:.language-kube-21}: The intensity, typically {% in_unit %}, but may be greater to indicate extreme rain intensity or negative to indicate it is not raining
- `.instantaneousTemperature(temp: ClimateValueFunction)`{: .language-kube-21 #{{ page.anchor }}-instantaneous-temperature }: A {{ climate }}, the calculation for the instantaneous temperature of the model
- `.instantaneousRainfall(rain: ClimateValueFunction)`{: .language-kube-21 #{{ page.anchor }}-instantaneous-rainfall }:A {{ climate }}, the calculation for the instantaneous rainfall of the model
- `.baseGroundwater(groundwater: TimelessClimateValueFunction)`{: .language-kube-21 #{{ page.anchor }}-base-groundwater }: A {{ timeless }}, the groundwater calculation of the model
    - Returned values will be clamped to {% range 0,,) %}

{: #{{ timeless_anchor }} }

## `TimelessClimateValueFunction`{:.f}

A callback with the following parameters

- `model: ClimateModel`{:.language-kube-21}: The {{ model }} the value is being calculated for
- `level: LevelReader`{:.language-kube-21}: The level the value is being calculated in
- `pos: BlockPos`{:.language-kube-21}: The position the value is being calculated at
- `return: number`{:.language-kube-21}: The calculated value

{: #{{ climate_anchor }} }

## `ClimateValueFunction`{:.f}

A callback with the following parameters

- `model: ClimateModel`{:.language-kube-21}: The {{ model }} the value is being calculated for
- `level: LevelReader`{:.language-kube-21}: The level the value is being calculated in
- `pos: BlockPos`{:.language-kube-21}: The position the value is being calculated at
- `calendarTick: int`{:.language-kube-21}: The {{ calendar }} tick at which the value is being calculated at
- `daysInMonth: int`{:.language-kube-21}: The number of days in a month
- `return: number`{:.language-kube-21}: The calculated value
