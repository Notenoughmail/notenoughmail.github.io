---
title: Fauna
anchor: fauna
cat:
    - kubejs_tfc
    - 1.21.1
    - data
desc: Defines the values of an existing, registered fauna, does not create new ones. See [the relevant event]({% link kubejs_tfc/1.21.1/events.md %}#fauna-spawns) for doing so
sig: |-
    builder: Consumer<FaunaBuidler>,
    id: ResourceLocation
example: |-
    fauna => {
        fauna.temperature(-20, 5)
        fauna.forest(1, 3)
        fauna.fuzzy()
        fauna.solid()
    },
    'tfc:fox'
---

- 1st argument: A consumer with several methods
    - `.minTemperature(min: number)`{:.language-kube-21}: Sets the minimum temperature (and the maximum temperature to [[ p_inf ]])
    - `.maxTemperature(max: number)`{:.language-kube-21}: Sets the maximum temperature (and the minimum temperature to [[ n_inf ]])
    - `.temperature(min: number, max: number)`{:.language-kube-21}: Sets the maximum and minimum temperature
    - `.minGroundwater(min: number)`{:.language-kube-21}: Sets the minimum temperature (and the maximum groundwater to [[ p_inf ]])
    - `.maxGroundwater(max: number)`{:.language-kube-21}: Sets the maximum temperature (and the minimum groundwater to [[ n_inf ]])
    - `.groundwater(min: number, max: number)`{:.language-kube-21}: Sets the maximum and minimum groundwater
    - `.minRainVariance(min: number)`{:.language-kube-21}: Sets the minimum rain variance (and maximum rain variance to `1`{:.n} and absolute rain variance to `false`{:.p})
    - `.maxRainVariance(max: number)`{:.language-kube-21}: Sets the maximum rain variance (and minimum rain variance to `-1`{:.n} and absolute rain variance to `false`{:.p})
    - `rainVariance(min: number, max: number, absolute: boolean)`{:.language-kube-21}: Sets the permissible rain variance, {% in_range -1,1 %}, and if the sign of the rain variance should be ignored
    - `.minForest(min: int)`{:.language-kube-21}: Sets the minimum forest density (and maximum forest density to `4`{:.n})
    - `.maxForest(max: int)`{:.language-kube-21}: Sets the maximum forest density (and minimum forest density to `0`{:.n})
    - `.forest(min: int, max: int)`{:.language-kube-21}: Sets the permissible forest density, {% in_range 0,4 %}
    - `.forestType(types...: ForestType[])`{:.language-kube-21}: Restricts spawning to within the given [`ForestType`{:.e}s]({% link kubejs_tfc/1.21.1/type-explanations.md %}#forest-type-enum){:.preserve-color}
    - `.minElevation(min: int)`{:.language-kube-21}: Sets the minimum elevation (and maximum elevation to `320`{:.n})
    - `.maxElevation(max: int)`{:.language-kube-21}: Sets the maximum elevation (and minimum elevation to `-64`{:.n})
    - `.elevation(min: int, max: int)`{:.language-kube-21}: Sets the permissible elevation range
    - `.months(months: List<Month>)`{:.language-kube-21}: Set the [`Month`{:.e}s]({% link kubejs_tfc/1.21.1/type-explanations.md %}#month-enum) during which spawning is valid
    - `.chance(value: int)`{:.language-kube-21}: Sets the spawn chance
    - `.distanceBelowSeaLevel(value: int)`{:.language-kube-21}: Sets the distance below sea level required to spawn
    - `.maxBrightness(value: int)`{:.language-kube-21}: Sets the maximum light level spawning can occur under
    - `.fuzzy()`{:.language-kube-21}: Makes the temperature, groundwater, and rain variance limits fuzzy when evaluating
    - `.solid()`{:.language-kube-21}: Makes it so spawning can only occur on blocks tagged `minecraft:valid_sapwn`
    - `.ignoreRivers()`{:.language-kube-21}: Ignores river contributions to groundwater values
- 2nd argument: A `ResourceLocation`, the id of the fauna
