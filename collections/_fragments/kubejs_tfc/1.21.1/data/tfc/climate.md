---
title: Climate Range
anchor: climate-range
cat:
    - kubejs_tfc
    - 1.21.1
    - data
desc: Defines the values of an existing, registered climate range, does not create new ones
method: climateRange
sig: |-
    range: {
        minHydration?: int,
        maxHydration?: int,
        hydrationWiggleRange?: int,
        minTemperature?: number,
        maxTemperature?: number,
        temperatureWiggleRange?: number
    },
    id: ResourceLocation
example: |-
    {
        minHydration: 15,
        maxHydration: 75,
        minTemperature: -2,
        maxTemperature: 26
    },
    'kubejs:cicada_crop'
---

- 1st argument: The climate range, a map of parameters to values
    - `minHydration?: int`{:.language-kube-21}: The minimum hydration the plant can grow in
        - [[ def_0 ]]
    - `maxHydration?: int`{:.language-kube-21}: The maximum hydration the plant can grow in
        - Defaults to `100`{:.n}
    - `hydrationWiggleRange?: int`{:.language-kube-21}: Additional hydration range in which the plant can survive, but not necessarily grow, in
        - [[ def_0 ]]
    - `minTemperature?: number`{:.language-kube-21}: The minimum temperature, in °C, the plant can grow in
        - Defaults to [[ n_inf ]]
    - `maxTemperature?: number`{:.language-kube-21}: The maximum temperature, in °C, the plant can grow in
        - Defaults to [[ p_inf ]]
    - `temperatureWiggleRange?: number`{:.language-kube-21}: Additional temperature range in which the plant can survive, but not necessarily grow, in
        - [[ def_0 ]]
- 2nd argument: The registered id of the climate range whose values are being defined
