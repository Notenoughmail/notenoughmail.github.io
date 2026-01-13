---
type: startup
name: defaultWorldSettings
title: Default World Settings
anchor: default-world-settings
cat:
    - kubejs_tfc
    - 1.21.1
    - event
layers:
    - l:
        - Volcanic
        - volcanic
    - l:
        - OceanFloor
        - ocean_floor
        - ocean-floor
    - l:
        - Land
        - land
    - l:
        - Uplift
        - uplift
example:
    - event.finiteContinents()
    - event.flatBedrock()
    - event.setTemperatureScale(5000)
    - event.setRainfallScale(7500)
    - ''
    - event.addRock('vanilla', {
    - "    raw: 'minecraft:stone'"
    - "    hardened: 'minecraft:deepslate'"
    - "    gravel: 'minecraft:gravel'"
    - "    cobble: 'minecraft:cobblestone'"
    - "    sand: 'minecraft:sand'"
    - "    sandstone: 'minecraft:sandstone'"
    - "    mafic: true"
    - '}, false)'
    - ''
    - event.defineLayer('mc_1', {
    - "    vanilla: 'bottom'"
    - "    granite: 'diorite'"
    - '})'
    - event.defineLayer('mc_2', {
    - "    vanilla: 'mc_1'"
    - "    diorite: 'mc_1'"
    - '})'
    - ''
    - event.addUpliftLayer('mc_2')
    - event.addUpliftLayer('mc_1')
    - event.addVolcanicLayer('mc_1')
---

Allows for editing the default values of the TFC chunk generator at world creation, including editing the rock layers

{: #{{ page.anchor }}-methods }

## Methods

- `.flatBedrock(flat?: boolean): void`{: .language-kube-21 #{{ page.anchor }}-flat-bedrock }: Set if the world should have flat bedrock, defaults to `false`{:.p}. Calling without any arguments sets to `true`{:.p}
- `.getFlatBedrock(): boolean`{: .language-kube-21 #{{ page.anchor }}-get-flat-bedrock }: If, with the current settings, the world will have flat bedrock
- `.setSpawnDistance(distance: int): void`{: .language-kube-21 #{{ page.anchor }}-set-spawn-distance }: Set the maximum distance from the spawn center players may spawn
- `.getSpawnDistance(): int`{: .language-kube-21 #{{ page.anchor }}-get-spawn-distance }: Get, with the current settings, the maximum distance from the spawn center players may spawn
- `.setSpawnCenterX(x: int): void`{: .language-kube-21 #{{ page.anchor }}-set-spawn-center-x }: Set the x-coordinate of the spawn center
- `.getSpawnCenterX(): int`{: .language-kube-21 #{{ page.anchor }}-get-spawn-center-x }: Get, with the current settings, the x-coordinate of the spawn center
- `.setSpawnCenterZ(z: int): void`{: .language-kube-21 #{{ page.anchor }}-set-spawn-center-z }: Set the z-coordinate of the spawn center
- `.getSpawnCenterZ(): int`{: .language-kube-21 #{{ page.anchor }}-get-spawn-center-z }: Get, with the current settings, the z-coordinate of the spawn center
- `.setSpawnCenter(x: int, z: int): void`{: .language-kube-21 #{{ page.anchor }}-set-spawn-center }: Set the spawn center position
- `.setTemperatureScale(scale: int): void`{: .language-kube-21 #{{ page.anchor }}-set-temperature-scale }: Set the temperature scale, the distance from pole-to-pole, of the world
- `.getTemperatureScale(): int`{: .language-kube-21 #{{ page.anchor }}-get-temperature-scale }: Get, with the current settings, the temperature scale
- `.setTemperatureConstant(constant: number): void`{: .language-kube-21 #{{ page.anchor }}-set-temperature-constant }: Set the temperature constant of the world, the base temperature to use if the temperature scale is `0`{:.n}
- `.getTemperatureConstant(): number`{: .language-kube-21 #{{ page.anchor }}-get-temperature-constant }: Get, with the current settings, the temperature constant
- `.setRainfallScale(scale: int): void`{: .language-kube-21 #{{ page.anchor }}-set-rainfall-scale }: Set the rainfall scale, the distance from pole-to-pole, of the world
- `.getRainfallScale(): int`{: .language-kube-21 #{{ page.anchor }}-get-rainfall-scale }: Get, with the current settings, the rainfall scale
- `.setRainfallConstant(constant: number): void`{: .language-kube-21 #{{ page.anchor }}-set-rainfall-constant }: Set the rainfall constant of the world, the base rainfall to use if the rainfall scale is `0`{:.n}
- `.getRainfallConstant(): number`{: .language-kube-21 #{{ page.anchor }}-get-rainfall-constant }: Get, with the current settings, the rainfall constant
- `.setContinentalNess(continentalness: number): void`{: .language-kube-21 #{{ page.anchor }}-set-continentalness }: Set the portion of the world that is land instead of water. Defaults to `0.5`{:.n}
- `.getContinentalness(): number`{: .language-kube-21 #{{ page.anchor }}-get-continentalness }: Get, with the current settings, the continentalness of the world
- `.setGrassDensity(density: number): void`{: .language-kube-21 #{{ page.anchor }}-set-grass-density }: Set the grass density of the world, defaults to `0.5`{:.n}
- `.getGrassDensity(): number`{: .language-kube-21 #{{ page.anchor }}-get-grass-density }: Get, with the current settings, the grass density of the world
- `.finiteContinents(finite?: boolean): void`{: .language-kube-21 #{{ page.anchor }}-finite-continents }: Set if the world should only generate a finite number of continents, defaults to `false`{:.p}. Calling without any arguments sets to `true`{:.p}
- `.getFiniteContinents(): boolean`{: .language-kube-21 #{{ page.anchor }}-get-finite-continents }: If, with the current settings, the world should only generate a finite number of continents
- `.addRock(name: String, rock: RockSettings, bottom: boolean): void`{: .language-kube-21 #{{ page.anchor }}-add-rock }: Add the given `rock`{:.v} to the generator's pool of available rocks
    - `name: String`{:.language-kube-21}: The name the rock can be referenced by
    - `rock: RockSettings`{:.language-kube-21}: The `RockSettings` to add, can be created as a map of parameters to values
        - `raw: Block`{:.language-kube-21}: The raw rock block
        - `hardened: Block`{:.language-kube-21}: The hardened rock block
        - `gravel: Block`{:.language-kube-21}: The gravel block
        - `cobble: Block`{:.language-kube-21}: The cobble block
        - `sand: Block`{:.language-kube-21}: The sand block
        - `sandstone: Block`{:.language-kube-21}: The sandstone block
        - `spike?: Block`{:.language-kube-21}: The spike block. Optional
        - `loose?: Block`{:.language-kube-21}: The loose pebble block. Optional
        - `mossyLoose?: Block`{:.language-kube-21}: The mossy loose pebble block. Optional
        - `karst?: boolean`{:.language-kube-21}: If the rock has karst surface rocks. Optional, defaults to `false`{:p}
        - `mafic?: boolean`{:.language-kube-21}: If the rock is considered mafic. Optional, defaults to `false`{:.p}
    - `bottom: boolean`{:.language-kube-21}: If the `rock`{:.v} should be added to the `bottom` pseudo-layer
- `.getRock(name: String): @Nullable RockSettings`{: .language-kube-21 #{{ page.anchor }}-get-rock }: Get the named `RockSettings`
- `.getRockNames(): Set<String>`{: .language-kube-21 #{{ page.anchor }}-get-rock-names }: Get a collection of the names of all rocks in the generator's pool of available rocks
- `.removeRock(String name): void`{: .language-kube-21 #{{ page.anchor }}-remove-rock }: Remove the given rock from the generator
- `.addToBottom(name: String): void`{: .language-kube-21 #{{ page.anchor }}-add-to-bottom }: Add the given rock to the `bottom` pseudo-layer
- `.removeFromBottom(name: String): void`{: .language-kube-21 #{{ page.anchor }}-remove-from-bottom }: Remove the given rock from the `bottom` pseudo layer
- `.defineLayer(id: String, rockMap: Map<String, String>): void`{: .language-kube-21 #{{ page.anchor }}-define-layer }: Define a new rock layer
    - `id: String`{:.language-kube-21}: The id of the layer
    - `rockMap: Map<String, String>`{:.language-kube-21}: A map of rock names to layer ids, associates a rock with the layer that will be generate below it
- `.removeLayer(id: String): void`{: .language-kube-21 #{{ page.anchor }}-remove-layer }: Remove the given layer from the generator
- `.getLayerIds(): List<String>`{: .language-kube-21 #{{ page.anchor }}-get-layer-ids }: Get, with the current settings, a collection of the ids of all layers in the generator
- `.cleanSlate(): void`{: .language-kube-21 #{{ page.anchor }}-clean-slate }: Removes all rocks and layer from the generator{% for l in page.layers %}
- `.add{{ l['l'][0] }}Layer(id: String): void`{: .language-kube-21 #{{ page.anchor }}-add-{{ l['l'] | get_or_default: 2, 1 }}-layer }: Add the given layer to the `{{ l['l'][1] }}` layer type
- `.remove{{ l['l'][0] }}Layer(id: String): void`{: .language-kube-21 #{{ page.anchor }}-remove-{{ l['l'] | get_or_default: 2, 1 }}-layer }: remove the given layer from the `{{ l['l'][1] }}` layer type
- `.get{{ l['l'][0] }}Layers(): List<String>`{: .language-kube-21 #{{ page.anchor }}-get-{{ l['l'] | get_or_default: 2, 1 }}-layers }: Get, with the current settings, the layers in the `{{ l['l'][1] }}` layer type{% endfor %}
