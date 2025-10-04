---
layout: page
title: 1.20.1
permalink: /tfcgv/1.20.1/
parent: TFCGenViewer
has_children: true
has_toc: false
---

# 1.20.1

- [Features](#features)
- [Client Config](#config)
- [Customization](#customization)
- [Permissions](#permissions)
- [Demo](#demo)

## Features

In the "More" tab of the create world screen there is a new button, "Preview World", which opens the preview screen. This screen has the same options as TFC's world customization screen (plus some additional options) to left, the world preview in the middle, and some information about the preview to the right.

### Options

Has all of TFC's options

- Flat bedrock
- Spawn distance
- Spawn center x/z
- Temperature/rainfall scale
- Temperature/rainfall constant
- Continentalness
- Grass density

In addition, there are options to set the x and z offset of the preview (centered on (0,0) by default), the visualizer type, spawn overlay toggle, the preview size, and a seed field

- Visualizer Type: Determines what the preview will show, defaults to *Rivers and Mountains*, clicking will toggle through: *Rock Types*, *Rocks*, *Biomes*, *Rainfall*, *Temperature*, *Climate Restricted Features*, *Biome Altitude*, *Inland Height*, and back to *Rivers and Mountains*
    - Biomes: Colors the preview based on the biome that was sampled at that point
        - {% color 0000dc|▮ %}: Ocean
        - {% color 46a0fa|▮ %}: Ocean Reed
        - {% color 0000a0|▮ %}: Deep Ocean
        - {% color 000050|▮ %}: Deep Ocean Reef
        - {% color 1e1eff|▮ %}: Lake
        - {% color b4b4ff|▮ %}: Mountainous Lake
        - {% color 00c8ff|▮ %}: River
        - {% color ff00ff|▮ %}: Oceanic Mountain
        - {% color b43cff|▮ %}: Canyon
        - {% color c86eff|▮ %}: Low Canyons
        - {% color dc96e6|▮ %}: Lowlands
        - {% color ff3232|▮ %}: Mountain
        - {% color f06464|▮ %}: Old Mountain
        - {% color d27878|▮ %}: Plateau
        - {% color ff9600|▮ %}: Badlands
        - {% color f09600|▮ %}: Inverted Badlands
        - {% color e6d282|▮ %}: Shore
        - {% color 14501e|▮ %}: Highlands
        - {% color 326432|▮ %}: Rolling Hills
        - {% color 508250|▮ %}: Hills
        - {% color 64c864|▮ %}: Plains
    - Rainfall: Overlays the rainfall onto the land, purple is 0mm and dark red is 500mm
    - Temperature: Overlays the temperature onto the land, purple is -20°C and dark red is 30°C
    - Climate Restricted Features: Display the ranges where certain features will spawn
    - Biome Altitude: Overlays the general height of biomes onto the land, lighter greens means higher altitudes
    - Inland Height: Overlays an approximation of the distance from the coast.
        - Green: Land; lighter is further from the coast
        - Blue: Ocean; darker is further from the coast
    - Rivers and Mountains: The same as Biome Altitude with rivers and mountains displayed
        - Light Blue: A river
        - Gray: Inland mountains
        - Orange: Oceanic/volcanic mountains
    - Rock Types: Displays the rock types that will generate by color, different rock types are indicated by different shades
        - Blue: Oceanic rock types
        - Green: Land rock types
        - Magenta: Uplift rock types
        - Pink/Salmon: Volcanic rock types
    - Rocks: Displays the rock that will likely generate at that position
        - {% color 55464A|▮ %}: Granite
        - {% color 8e8e8e|▮ %}: Diorite
        - {% color 5d5544|▮ %}: Gabbro
        - {% color 464346|▮ %}: Shale
        - {% color 8d6644|▮ %}: Claystone
        - {% color 887f6b|▮ %}: Limestone
        - {% color 6f7165|▮ %}: Conglomerate
        - {% color 3c4659|▮ %}: Dolomite
        - {% color 7a4e46|▮ %}: Chert
        - {% color c7c7c1|▮ %}: Chalk
        - {% color 736267|▮ %}: Rhyolite
        - {% color 1d2021|▮ %}: Basalt
        - {% color 606060|▮ %}: Andesite
        - {% color 7a7b7b|▮ %}: Dacite
        - {% color 8c8180|▮ %}: Quartzite
        - {% color 7d7467|▮ %}: Slate
        - {% color 949da9|▮ %}: Phyllite
        - {% color 4d5441|▮ %}: Schist
        - {% color 736d60|▮ %}: Gneiss
        - {% color e3ebeb|▮ %}: Marble
- Spawn Overlay: Draws a box on the preview showing where the possible spawn points as determined by the spawn distance and center options
- Preview Size: Determines the size the preview will display, has 7 options
    - 4.1 km
    - 8.2 km
    - 16.4 km
    - 32.8 km *Default, unless changed by config*
    - 65.5 km
    - 131.1 km
    - 262.1 km
- Preview Export: Exports the currently displayed preview to a file in `screenshots/tfcgenviewer/`{:.language-fs}
- Seed: Sets the seed to use in the preview

Underneath those options are three buttons, *Apply*, *Export Preview* and *Edit Rocks*. *Apply* recreates the preview with the current options, *Export Preview* saves the current preview to a file in the `screenshots/tfcgenveiwer/`{:.language-fs} folder, and *Edit Rocks* opens the [rock editor sub-screen](rock-editor/)

### Buttons

At the bottom of the screen there are 3 buttons, "Save", "Cancel", and "Current seed"

- Save: Saves the options and exits to the world creation screen
- Cancel: Discards all changes to options and exits to the world creation screen
- Current seed: Displays the seed being displayed and copies it to the clipboard when clicked

Additionally, clicking on the preview itself will toggle between three display modes

- None: Nothing is shown
- Coordinates: Shows the coordinates which the mouse is currently over, will be skipped if the server has disabled viewing coordinates
- Color Description: Shows a description of the pixel that the mouse is currently over

### Side Info

To the right of the preview there is some info about the preview

- The number of regions generated in the preview
- How long it took to generate the preview
- The dimensions of the preview
- The x/z coordinates the preview is centered on
- The visualizer used in the preview
- A color key for the preview
- A compass pointing North

### Technical Info

You may have noticed that the preview is not a block-to-pixel representation of the world being created, in actuality each pixel is one *grid*, the "smallest unit generated by [TFC's] region system" and are equal to 8 chunks or 128 blocks. For more on this, see TFC's [Units class](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/region/Units.java)

## Config

TFCGenViewer has five client config options

### defaultPreviewSize

An int in the range [0, 6], defaulting to 3. Determines which preview size the *Preview Scale* slider defaults to. This value can be converted to km via the equation:

2<span style="vertical-align: baseline; position: relative; top: -0.6em;">(defaultPreviewSize + 5)</span> * 128 / 1000

### loadingIcon

A boolean, defaulting to true. Determines if the preview screen should display a loading icon while generating a new preview. If disabled, the previous preview will remain until the new one is completed

### dingWhenGenerated

A boolean, defaulting to true. Determines if the a sound should play when a preview finishes generating

### generationProgress

A boolean, defaulting to true. Determines if a progress bar should show along the bottom of the preview space while generating

### cancelPreviewOnError

A boolean, defaulting to true. Determines if progress should be canceled if an error is encountered during preview generation. If disabled, generation will continue, using empty data at the point of failure and the error only printed to the log

## Customization

To change the colors of the preview, see the [customization page](customization/)

## Permissions

The information available in the in-world preview can be configured, see the [permissions page](permissions/)

## Demo

{: .notice }
This video is from before the overhaul of the preview screen in 1.1.0 and lacks features introduced in later updates

<iframe width="560" height="315" src="https://www.youtube.com/embed/jfreS69Sb-Q?si=SjwpFwlBY_dKuwzF" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
