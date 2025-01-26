---
layout: page
title: Customization
permalink: /tfcgv/1.20.1/customization/
parent: 1.20.1
grand_parent: TFCGenViewer
has_children: false
has_toc: false
---

# Customization

The colors used for the different visualizer types can be changed via resource packs, this page describes how to do so

- [Rivers and Mountains](#rivers-and-mountains)
- [Rock Types](#rock-types)
- [Rocks](#rocks)
- [Biomes](#biomes)
- [Rainfall](#rainfall)
- [Temperature](#temperature)
- [Biome Altitude](#biome-altitude)
- [Inland Height](#inland-height)
- [Fill Ocean](#fill-ocean)
- [Spawn Overlay](#spawn-overlay)
- [Color Definition](#color-definition)
- [Color Gradient Definition](#color-gradient-definition)

## Rivers and Mountains

The colors for the *Rivers and Mountains* visualizer are defined in `assets/tfcgenviewer/tfcgenviewer/rivers_and_mountains/*.json`

- `rivers_and_mountains/river.json`: A [color definition](#color-definition), the color used for rivers
- `rivers_and_mountains/lake.json`: A [color definition](#color-definition), the color used for lakes
- `rivers_and_mountains/oceanic_volcanic_mountain.json`: A [color definition](#color-definition), the color used by oceanic and volcanic mountains
- `rivers_and_mountains/inland_mountain.json`: A [color definition](#color-definition), the color used by inland mountains

{: .comment }
> tfcgenviewer/tfcgenviewer/rivers_and_mountains/lake.json default
>
> ```json
> {
>     "color": {
>         "r": 150,
>         "g": 160,
>         "b": 255
>     },
>     "key": "biome.tfc.lake"
> }
> ```

## Rock Types

The colors of the rock types are defined by a [color gradient definition](#color-gradient-definition) in a resource pack. The definitions are located at `assets/tfcgenviewer/tfcgenviewer/rock_types/oceanic.json`, `assets/tfcgenviewer/tfcgenviewer/rock_types/volcanic.json`, `assets/tfcgenviewer/tfcgenviewer/rock_types/land.json`, and `assets/tfcgenviewer/tfcgenviewer/rock_types/uplift.json`

An example from the mod:

{: .comment }
> tfcgenviewer/tfcgenviewer/rock_types/uplift.json default
>
> ```json
> {
>     "reference": "uplift",
>     "key": "tfcgenviewer.rock_type.uplift"
> }
> ```

## Rocks

The color of a rock is defined by a [color definition](#color-definition) in a resource pack matching the registry id of the the *raw* block of that rock layer. For a rock layer with `minecraft:dirt` as its raw block, the definition would need to be at `assets/minecraft/tfcgenviewer/rocks/dirt.json`

An example from the mod:

{: .comment }
> tfc/tfcgenviewer/rocks/rock/raw/andesite.json default
>
> ```json
> {
>     "color": {
>         "r": 96,
>         "g": 96,
>         "b": 96
>     },
>     "key": "rock.tfc.andesite",
>     "sort": 12
> }
> ```

Additionally, the color definition for unknown rocks is located at `assets/tfcgenviewer/tfcgenviewer/rocks/unknown.json`

## Biomes

The color of a biome is defined by a [color definition](#color-definition) in a resource pack matching the registry id of the biome. For the biome `tfc:canyons`, the definition would need to be at `assets/tfc/tfcgenviewer/biomes/canyons.json`

An example from the mod:

{: .comment }
> tfc/tfcgenviewer/biomes/plains.json default
>
> ```json
> {
>     "color": {
>         "r": 100,
>         "g": 200,
>         "b": 100
>     },
>     "key": "biome.tfc.plains",
>     "sort": 21
> }
> ```

Additionally, the color definition for unknown biomes is located at `assets/tfcgenviewer/tfcgenviewer/biomes/unknown.json`

## Rainfall

A [color gradient definition](#color-gradient-definition) at `assets/tfcgenviewer/tfcgenviewer/colors/rainfall.json` that defines the gradient used for land in the *Rainfall* visualizer

{: .comment }
> Default
>
> ```json
> {
>     "reference": "climate",
>     "key": "tfcgenviewer.climate.rainfall"
> }
> ```

## Temperature

A [color gradient definition](#color-gradient-definition) at `assets/tfcgenviewer/tfcgenviewer/colors/temperature.json` that defines the gradient used for land in the *Temperature* visualizer

{: .comment }
> Default
>
> ```json
> {
>     "reference": "climate",
>     "key": "tfcgenviewer.climate.temperature"
> }
> ```

## Biome Altitude

The colors for land in the *Biome Altitude* visualizer are defined in  `assets/tfcgenviewer/tfcgenviewer/biome_altitude/*.json`

- `biome_altitude/low.json`: A [color definition](#color-definition), the color for low altitude land
- `biome_altitude/medium.json`: A [color definition](#color-definition), the color for medium altitude land
- `biome_altitude/high.json`: A [color definition](#color-definition), the color for high altitude land
- `biome_altitude/mountain.json`: A [color definition](#color-definition), the color for mountain land

{: .comment }
> tfcgenviewer/tfcgenviewer/biome_altitude/medium.json default
>
> ```json
> {
>     "color": {
>         "r": 26,
>         "g": 133,
>         "b": 26
>     },
>     "key": "tfcgenviewer.biome_altitude.medium"
> }
> ```

## Inland Height

The colors for the *Inland Height* visualizer are defined in `assets/tfcgenviewer/tfcgenviewer/inland_height/*.json`

- `inland_height/land.json`: A [color gradient definition](#color-gradient-definition), the gradient used on the land
- `inland_height/shallow_water.json`: A [color definition](#color-definition), the color used for shallow water
- `inland_height/deep_water.json`: A [color definition](#color-definition), the color used for deep water
- `inland_height/very_deep_water.json`: A [color definition](#color-definition), the color used for very deep water

{: .comment }
> tfcgenviewer/tfcgenviewer/inland_height/shallow_water.json default
>
> ```json
> {
>     
>     "color": {
>         "r": 150,
>         "g": 160,
>         "b": 255
>     },
>     "key": "tfcgenviewer.inland_height.shallow_water"
> }
> ```

## Fill Ocean

A [color gradient definition](#color-gradient-definition) at `assets/tfcgenviewer/tfcgenviewer/colors/fill_ocean.json` that defines the gradient of colors used for the ocean in the *Rainfall*, *Temperature*, *Biome Altitude*, and *Rivers and Mountains* visualizers

{: .comment }
> Default
>
> ```json
> {
>     "reference": "blue",
>     "key": "biome.tfc.ocean"
> }
> ```

## Spawn Overlay

The colors for the spawn overlay are defined in `assets/tfcgenviewer/tfcgenviewer/spawn/border.json` and `assets/tfcgenviewer/tfcgenviewer/spawn/reticule.json`

- `spawn/border.json`: A [Color Definition](#color-definition), the color used to illustrate the maximum spawning radius
- `spawn/reticule.json`: A [Color Definition](#color-definition), the color used to illustrate the center of the spawning radius

{: .comment }
> Border default
>
> ```json
> {
>     "color": {
>         "r": 50,
>         "g": 50,
>         "b": 50
>     }
> }
> ```

## Color Definition

A color definition is an object with up to three fields

### Properties

- `color`: Mandatory. A [color](#color), defines the color of the definition
- `key`: Optional. A string, defines the lang key used to describe the color in the color key, defaults to an autogenerated value based on the context used
- `sort`: Optional. An integer which defines the sort order of rocks and biomes, defaults to `100`. Only relevant for the *Rivers and Mountains* and *Rocks* visualizers

### Color

A Color may be:

- An object with fields `r`, `g`, and `b` which are integers in the range [0, 255]. The red, green, and blue properties of the color
- An object with fields `h`, `s`, and `v` which are numbers in the range [0, 1]. The hue, saturation, and value properties of the color
- A string. A base 16 representation of a rgb number
- A number. An rgb number

Examples:

{: .comment }
> rgb object
>
> ```json
> {
>     "r": 65,
>     "g": 41,
>     "b": 245
> }
> ```

{: .comment }
> hsv object
>
> ```json
> {
>     "h": 0.234,
>     "s": 0.812,
>     "v": 0.473
> }
> ```

{: .comment }
> String
>
> ```json
> "F24DE9"
> ```

{: .comment }
> Number
>
> ```json
> 15879657
> ```

## Color Gradient Definition

A color gradient definition is an object with 2 fields:

- `gradient` or `reference`: Mandatory. May use one or the other, gradient will be used if both are present
    - `gradient`: Any of:
        - An object with `from` and `to` fields
            - `from`: A [color](#color), the 'low' end of the gradient
            - `to`: A [color](#color), the 'high' end of the gradient
        - A [color](#color), a constant gradient
        - An array whose members are [colors](#color), the first element is the 'low' end of the gradient and the last element is the 'high' end
    - `reference`: Any of:
        - `blue`, `ocean`: A gradient from <span style="color:#323296;">#323296</span> to <span style="color:#648cff;">#648CFF</span>
        - `green`, `land`: A gradient from <span style="color:#006400;">#006400</span>  to <span style="color:#50c850;">#50C850</span>
        - `climate`, `temp`, `temperature`, `rain`, `rainfall`: A gradient through <span style="color:#b414f0;">#B414F0</span>, <span style="color:#00b4f0;">#00B4F0</span>, <span style="color:#b4b4dc;">#B4B4DC</span>, <span style="color:#d2d200;">#D2D200</span>, <span style="color:#c8783c;">#C8783C</span>, and <span style="color:#c82828;">#C82828</span>
        - `volcanic`, `volcanic_rock`: A gradient from <span style="color:#c80064;">#C80064</span>  to <span style="color:#c86464;">#C86464</span>
        - `uplift`, `uplift_rock`: A gradient from <span style="color:#b400c8;">#B400C8</span>  to <span style="color:#b4b4c8;">#B4B4C8</span>
- `key`: Optional. Defines the lang key used, defaults to an autogenerated value based on the context used

Examples:

{: .comment }
> Reference: tfcgenviewer/tfcgenviewer/rock_types/oceanic.json
>
> ```json
> {
>     "reference": "blue",
>     "key": "tfcgenviewer.rock_type.oceanic"
> }
> ```

{: .comment }
> An example of the object form of a gradient
>
> ```json
> {
>     "gradient": {
>         "from": {
>             "r": 12,
>             "g": 0,
>             "b": 164
>         },
>         "to": {
>             "h": 0.44,
>             "s": 0.1222,
>             "v": 0.36
>         }
>     }
> }
> ```

{: .comment }
> An example of the array from of a gradient
>
> ```json
> {
>     "gradient": [
>         "B4B4C8",
>         "C8783C",
>         "B4B4DC",
>         "50C850",
>         {
>             "r": 32,
>             "g": 48,
>             "b": 120
>         }
>     ]
> }
> ```
