---
layout: page
title: Configured & Placed Features
permalink: /worldjs/1.21.1/features/
parent: 1.21.1
grand_parent: WorldJS
has_children: true
has_toc: false
desc: All of the configured and placed feature types provided by WorldJS 
fragment-filter:
    - worldjs
    - 1.21.1
    - feature
fragment-sort:
    - group
    - sort_pos
    - title
---

# Configured & Placed Features

[Configured features](https://minecraft.wiki/w/Configured_feature) define what is placed in-world. WorldJS adds the ability to create all of vanilla's configured feature types through KubeJS's `ServerEvents.registry('worldgen/configured_feature', event => {})`{:.language-kube-21} event

{% capture directions %}{% include enum_list.html summary='Reveal/hide list of directions' values='up,down,east,west,north,south' %}{% endcapture %}

{% map replacements %}
{% base Inherits the methods of the [no op](#no-op) builder %}
{% vertical_anchor %}[`VerticalAnchor`]({% link worldjs/1.21.1/wrappers.md %}#vertical-anchor){% end_vertical_anchor %}
{% block_state_provider %}[`BlockStateProvider`]({% link worldjs/1.21.1/wrappers.md %}#block-state-provider){% end_block_state_provider %}
{% rule_test [`RuleTest`](https://minecraft.wiki/w/Processor_list?oldid=3572989#Rule_test) %}
{% struct_proc [`StructureProcessorList`](https://minecraft.wiki/w/Processor_list?oldid=3572989) %}
{% directions %}<p>{{ directions }}</p>{% end_directions %}
! These 2 need to be a link out to the mc wiki or kube wrapper docs, can't find either
{% int %}`IntProvider`{% end_int %}
{% float %}`FloatProvider`{% end_float %}
{% block_predicate %}[`BlockPredicate`]({% link worldjs/1.21.1/wrappers.md %}#block-predicate){% end_block_predicate %}
{% required %}**Must** be set{% end_required %}
{% unit %}Must be {% in_unit %}{% end_unit %}
{% def_0 %}Defaults to `0`{:.n}{% end_def_0 %}
{% def_1 %}Defaults to `1`{:.n}{% end_def_1 %}
{% endmap %}

{% assign features = site.fragments | multi_where: 'cat', page.fragment-filter | replace_in_fragments: replacements | clean_fragments | multi_sort: page.fragment-sort %}

{% grid n=3 %}

{% for feature in features %}

- [<img src="https://minecraft.wiki/images/{{ feature | get_or_else: 'sprite', 'EnvSprite' }}_{{ feature | get_or_default: 'icon', 'anchor' }}.png" alt="" class="inline bg" decoding="async" loading="lazy" /> {{ feature.title }}](#{{ feature.anchor }})

{% endfor %}

</div>

[Placed features](https://minecraft.wiki/w/Placed_feature) define the placement conditions of configured features. They can be made with KubeJS's `ServerEvents.registry('worldgen/placed_feature', event => {})`{:.language-kube-21} event, as described [below](#placed-features)

WorldJS also adds the ability to define [custom feature types](#custom-feature-types)

{% for feature in features %}

{: #{{ feature.anchor }}}

## <img src="https://minecraft.wiki/images/{{ feature | get_or_else: 'sprite', 'EnvSprite' }}_{{ feature | get_or_default: 'icon', 'anchor' }}.png" alt="" class="inline bg" decoding="async" loading="lazy" /> {{ feature.title }}

**Type**: `{{ feature.type }}`

{% if feature.wiki_link %}

Creates a [minecraft:{{ feature.type }}]({{ feature.wiki_link }}) configured feature

{% endif %}

{% if feature.inherit %}

Inherits the methods of the [{{ feature.inherit-display }}](#{{ feature.inherit }}) builder

{% endif %}

{{ feature.clean }}

{: #{{ feature.anchor }}-example }

### Example

```js-21
ServerEvents.registry('worldgen/configured-feature', event => {
    event.create('{{ feature | get_or_default: 'name', 'type' }}', '{{ feature.type }}')
        {{ feature.example | with_indent }}
})
```

{% endfor %}

---

## Placed Features

Placed features can be created using the JS event or via the [`.withPlacement(...)`{:.language-kube-21}](#no-op-with-placement){:.preserve-color} method of a configured feature builder

- `.configuredFeature(feature: Holder$Reference<ConfiguredFeature<?, ?>>)`{: .language-kube-21 #placed-feature-configured-feature }: Sets the configured feature the placed feature will place
    - **Note**: Will be ignored if the placed feature is derived from a configured feature builder
- `.modifier(modifier: PlacementModifier)`{: .language-kube-21 #placed-feature-modifier }: Add the provided placement modifier
- `.jsonModifier(json: JsonElement)`{: .language-kube-21 #placed-feature-json-placement }: Add the provided json-defined placement modifier
- `.modifiers(modifiers: Consumer<PlacedFeatureBuilder$Modifiers>)`{: .language-kube-21 #placed-feature-modifiers-func }: Add pre-defined placement modifiers via [namespaced methods](#placed-feature-modifiers)
- `.tag(tag...: ResourceLocation[])`{: .language-kube-21 #{{ page.anchor }}-tag }: Adds the tag(s) to the placed feature

{: #placed-features-example }

### Example

```js-21
ServerEvents.registry('worldgen/placed_feature', event => {
    event.create('sugar_cane_everywhere')
        .configuredFeature('minecraft:patch_sugar_cane')
        .modifiers(modifiers => {
            let { minecraft } = modifiers
            minecraft.biome()
                .inSquare()
                .heightmap('world_surface_wg')
        })
})
```

## Placed Feature Modifiers

{% capture vertical_anchor %}[vertical anchor]({% link worldjs/1.21.1/wrappers.md %}#vertical-anchor){% endcapture %}
{% capture heightmap_types %}{% include enum_list.html summary='Reveal/hide list of heightmap types' values='motion_blocking,motion_blocking_no_leaves,ocean_floor,ocean_floor_wg,world_surface,world_surface_wg' %}{% endcapture %}

Placement modifiers are created and added to placed features through a namespaced system of methods. The namespaces can be retrieved from the `PlacedFeatureBuilder$Modifiers` provided in the callback of [`.modifiers(...)`{:.language-kube-21}](#placed-feature-modifiers-func){:.preserve-color}. All methods available from a namespace return the namespace, allowing for multiple modifiers from the same namespace to be added with minimal friction

By default WorldJS adds the following [vanilla placement modifiers](https://minecraft.wiki/w/Placed_feature#Placement_modifiers) under the `minecraft` namespace, but other mods can add namespaces and methods of their own

- `.biome()`{: .language-kube-21 #modifier-biome }: Add a [minecraft:biome](https://minecraft.wiki/w/Placed_feature#biome) modifier. Restricts the feature to only place in biomes that include this feature
- `.inSquare()`{: .language-kube-21 #modifier-in-square }: Add a [minecraft:in_square](https://minecraft.wiki/w/Placed_feature#in_square) modifier. Adds a random x and z offset to the placement position between 0 and 15
- `.count(count: IntProvider)`{: .language-kube-21 #modifier-count }: Add a [minecraft:count](https://minecraft.wiki/w/Placed_feature#count) modifier
    - `count: IntProvider`{:.language-kube-21}: The number of times to place at the position, {% in_range 0,256 %}
- `.fixed(positions: BlockPos[])`{: .language-kube-21 #modifier-fixed }: Add a [minecraft:fixed_placement](https://minecraft.wiki/w/Placed_feature#fixed_placement) modifier
    - `positions: BlockPos[]`{:.language-kube-21}: The positions to place at, if in the same chunk as the placement is occurring in
- `.rarityFilter(chance: int)`{: .language-kube-21 #modifier-rarity-filter }: Add a [minecraft:rarity_filter](https://minecraft.wiki/w/Placed_feature#rarity_filter) modifier
    - `chance: int`{:.language-kube-21}: The chance the feature will successfully place at a position as `1 / chance`
- `.carvingMask(carvingStep: GenerationStep$Carving)`{: .language-kube-21 #modifier-carving-mask }: Add a [minecraft:carving_mask](https://minecraft.wiki/w/Placed_feature#carving_mask) modifier
    - `carvingStep: GenerationStep$Carving`{:.language-kube-21}: The carving step volume for which the feature will try to place in. Does not include blocks 'carved' out by noise caves
        {% include enum_list.html summary='Reveal/hide list of carving steps' values='air,liquid' %}
- `.heightmap(heightmap: Heightmap$Types)`{: .language-kube-21 #modifier-heightmap }: Add a [minecraft:heightmap](https://minecraft.wiki/w/Placed_feature#heightmap) modifier
    - `heightmap: Heightmap$Types`{:.language-kube-21}: The heightmap to place on
        {{ heightmap_types }}
- `.noiseBasedCount(noiseToCountRatio: int, noiseFactor: float, noiseOffset?: float)`{: .language-kube-21 #modifier-noise-based-count }: Add a [minecraft:noise_based_count](https://minecraft.wiki/w/Placed_feature#noise_based_count) modifier
    - `noiseToCountRatio: int`{:.language-kube-21}: The ratio of noise value to count
    - `noiseFactor: float`{:.language-kube-21}: The horizontal scale factor of the noise. Higher values make wider, more spaced out peaks
    - `noiseOffset?: float`{:.language-kube-21}: The vertical offset of the noise. Optional, defaults to 0
- `.noiseThresholdCount(noiseLevel: float, belowNoise: int, aboveNoise: int)`{: .language-kube-21 #modifier-noise-threshold-count }: Add a [minecraft:noise_threshold_count](https://minecraft.wiki/w/Placed_feature#noise_threshold_count) modifier
    - `noiseLevel: float`{:.language-kube-21}: The threshold for determining if `aboveNoise`{:.v} or `belowNoise`{:.v} should be used
    - `belowNoise: int`{:.language-kube-21}: The count to use when below the threshold
    - `aboveNoise: int`{:.language-kube-21}: The count to use when above the threshold
- `.randomOffset(xzSpread: IntProvider, ySpread: IntProvider)`{: .language-kube-21 #modifier-random-offset }: Add a [minecraft:random_offset](https://minecraft.wiki/w/Placed_feature#random_offset) modifier
    - `xzSpread: IntProvider`{:.language-kube-21}: The horizontal spread, {% in_range -16,16 %}
    - `ySpread: IntProvider`{:.language-kube-21}: The vertical spread, {% in_range -16,16 %}
- `.verticalRandomOffset(ySpread: IntProvider)`{: .language-kube-21 #modifier-vertical-random-offset }: Add a purely vertical [minecraft:random_offset](https://minecraft.wiki/w/Placed_feature#random_offset) modifier
    - `ySpread: IntProvider`{:.language-kube-21}: The vertical spread, {% in_range -16,16 %}
- `.horizontalRandomOffset(xzSpread: IntProvider)`{: .language-kube-21 #modifier-horizontal-random-offset }: Add a purely horizontal [minecraft:random_offset](https://minecraft.wiki/w/Placed_feature#random_offset) modifier
    - `xzSpread: IntProvider`{:.language-kube-21}: The horizontal spread, {% in_range -16, 16 %}
- `.countOnEveryLayer(count: IntProvider)`{: .language-kube-21 #modifier-count-on-every-layer }: Add a [minecraft:count_on_every_layer](https://minecraft.wiki/w/Placed_feature#count_on_every_layer) modifier
    - `count: IntProvider`{:.language-kube-21}: The count on each layer, {% in_range 0,256 %}
- `.environmentScan(directionOfSearch: Direction, targetCondition: BlockPredicate, allowedSearchCondition?: BlockPredicate, maxSteps: int)`{: .language-kube-21 #modifier-environment-scan }: Add a [minecraft:environment_scan](https://minecraft.wiki/w/Placed_feature#environment_scan) modifier
    - `directionOfSearch: Direction`{:.language-kube-21}: The direction to search in
        {{ directions }}
    - `targetCondition: BlockPredicate`{:.language-kube-21}: The block predicate to search for
    - `allowedSearchCondition?: BlockPredicate`{:.language-kube-21}: The block predicate to validate each step to the `targetCondition`{:.v}. Optional, approves everything if not specified
    - `maxSteps: int`{:.language-kube-21}: the maximum number of blocks, {% in_range 1,32 %}, out from the original position to search for
- `.surfaceRelativeThreshold(heightmap: Heightmap$Types, minInclusive: int, maxInclusive: int)`{: .language-kube-21 #modifier-surface-relative-threshold }: Add a [minecraft:surface_relative_threshold_filter](https://minecraft.wiki/w/Placed_feature#surface_relative_threshold_filter) modifier
    - `heightmap: Heightmap$Types`{:.language-kube-21}: The heightmap to be within range of
        {{ heightmap_types }}
    - `minInclusive: int`{:.language-kube-21}: The minimum elevation difference from the heightmap
    - `maxInclusive: int`{:.language-kube-21}: The maximum elevation difference from the heightmap
- `.surfaceRelativeThresholdMax(heightmap: Heightmap$Types, maxInclusive: int)`{: .language-kube-21 #modifier-surface-relative-threshold-max }: Add a [minecraft:surface_relative_threshold_filter](https://minecraft.wiki/w/Placed_feature#surface_relative_threshold_filter) modifier with no minimum bound
    - `heightmap: Heightmap$Types`{:.language-kube-21}: The heightmap to be within range of
        {{ heightmap_types }}
    - `maxInclusive: int`{:.language-kube-21}: The maximum elevation difference from the heightmap
- `.surfaceRelativeThresholdMin(heightmap: Heightmap$Types, minInclusive: int)`{: .language-kube-21 #modifier-surface-relative-threshold-min }: Add a [minecraft:surface_relative_threshold_filter](https://minecraft.wiki/w/Placed_feature#surface_relative_threshold_filter) modifier with no maximum bound
    - `heightmap: Heightmap$Types`{:.language-kube-21}: The heightmap to be within range of
        {{ heightmap_types }}
    - `minInclusive: int`{:.language-kube-21}: The minimum elevation difference from the heightmap
- `.surfaceWaterDepth(maxWaterDepth: int)`{: .language-kube-21 #modifier-surface-water-depth }: Add a [minecraft:surface_water_depth_filter](https://minecraft.wiki/w/Placed_feature#surface_water_depth_filter) modifier
    - `maxWaterDepth: int`{:.language-kube-21}: The maximum depth of water under which the feature can be placed
- `.blockPredicate(predicate: BlockPredicate)`{: .language-kube-21 #modifier-block-predicate }: Add a [minecraft:block_predicate_filter](https://minecraft.wiki/w/Placed_feature#block_predicate_filter) modifier
    - `predicate: BlockPredicate`{:.language-kube-21}: The validator for a placing at a position
- `.heightRange(height: HeightProvider)`{: .language-kube-21 #modifier-height-range }: Add a [minecraft:height_range](https://minecraft.wiki/w/Placed_feature#height_range) modifier
    - `height: HeightProvider`{:.language-kube-21}: The [height range]({% link worldjs/1.21.1/wrappers.md %}#height-provider) over which the feature can place
- `.uniformHeightRange(minInclusive: VerticalAnchor, maxInclusive: VerticalAnchor)`{: .language-kube-21 #modifier-uniform-height-range }: Add a [minecraft:height_range](https://minecraft.wiki/w/Placed_feature#height_range) modifier that has a uniform chance of placing anywhere in the bounds
    - `minInclusive: VerticalAnchor`{:.language-kube-21}: A {{ vertical_anchor }}, the lower placement bound
    - `maxInclusive: VerticalAnchor`{:.language-kube-21}: A {{ vertical_anchor }}, the upper placement bound
- `.triangleHeightRange(minInclusive: VerticalAnchor, maxInclusive: VerticalAnchor)`{: .language-kube-21 #modifier-triangle-height-range }: Add a [minecraft:height_range](https://minecraft.wiki/w/Placed_feature#height_range) modifier that has the highest chance of placing the feature in the center of the bounds
    - `minInclusive: VerticalAnchor`{:.language-kube-21}: A {{ vertical_anchor }}, the lower placement bound
    - `maxInclusive: VerticalAnchor`{:.language-kube-21}: A {{ vertical_anchor }}, the upper placement bound
- `.constantHeightRange(height: VerticalAnchor)`{: .language-kube-21 #modifier-constant-height-range }: Add a [minecraft:height_range](https://minecraft.wiki/w/Placed_feature#height_range) modifier that places the feature at the exact height given
    - `height: VerticalAnchor`{:.language-kube-21}: A {{ vertical_anchor }}, the height to place at

## Custom Feature Types

Custom feature types can be creating using the `StartupEvents.registry('worldgen/feature', e => {})`{:.langauge-kube-21} event

Each feature type created via the default builder will have a corresponding builder type (with the same id as the feature type is register with) added to the `ServerEvents.registry('worldgen/configured_feature', e => {})`{:.langauge-kube-21} event for easy creation. The builder type will inherit the methods of the [no op](#no-op) builder

- `.placeFunction(function: KubeFeaturePlaceFunction)`: The placement function which defines how and where the feature places blocks. Accepts a callback with the params:
    - `level: WorldgenLevel`{:.langauge-kube-21}: The level in which the feature is being placed
    - `chunkGenerator: ChunkGenerator`{:.langauge-kube-21}: The chunk generator the feature is being placed by
    - `random: RandomSource`{:.langauge-kube-21}: A source of random values
    - `origin: BlockPos`{:.langauge-kube-21}: The position the feature is being placed at *after* modifications by placement modifiers
    - `return: boolean`{:.langauge-kube-21}: `true`{:.p} if the feature successfully placed, else `false`{:.p}

{: #custom-feature-type-example }

### Example

```js-21
StartupEvents.registry('worldgen/feature', event => {
    event.create('evil_spikes')
        .placeFunction((level, chunkGenerator, random, origin) => {
            random = random.forkPositional().at(origin)
            let height = 18 + random.nextInt(27)
            let baseRadius = 5.5
            let tipRadius = 0.35
            let maxTilt = 5.0
            let bend = 1.2
            let curl = 7.0
            let buriedDepth = 10
            let taperCurve = 1.25
            let surfaceNoise = 0.85
            let accentChance = 0.08
            let tiltX = (random.nextDouble() * 2.0 - 1.0) * maxTilt
            let tiltZ = (random.nextDouble() * 2.0 - 1.0) * maxTilt
            let bendPhase = random.nextDouble() * Math.PI * 2.0
            let noiseSeed = random.nextLong()
            let placed = false
            let pos = origin.mutable()

            for (let y = -buriedDepth; y < height; y++) {
                let buried = y < 0
                let t = buried ? 0.0 : height == 1 ? 1.0 : y / (height - 1)
                let buriedT = buried && buriedDepth > 0 ? -y / buriedDepth : 0.0
                let mainRadius = Math.max(tipRadius, baseRadius * Math.pow(1.0 - t, taperCurve) + tipRadius * t)
                let radius = buried ? Math.max(tipRadius, baseRadius * (1.0 - buriedT * 0.45)) : mainRadius
                let curlT = t <= 0.5 ? 0.0 : (t - 0.5) * 2.0
                let curlRadius = curl * curlT * curlT
                let curlAngle = bendPhase + curlT * Math.PI * 1.35
                let centerX = origin.getX() + tiltX * t + Math.sin(t * Math.PI + bendPhase) * bend + Math.cos(curlAngle) * curlRadius
                let centerZ = origin.getZ() + tiltZ * t + Math.cos(t * Math.PI + bendPhase) * bend + Math.sin(curlAngle) * curlRadius
                let blockY = origin.getY() + y
                pos.setY(blockY)

                if (blockY <= level.getMinBuildHeight() || blockY >= level.getMaxBuildHeight()) {
                    continue
                }

                let minX = Math.floor(centerX - radius)
                let maxX = Math.ceil(centerX + radius)
                let minZ = Math.floor(centerZ - radius)
                let maxZ = Math.ceil(centerZ + radius)

                for (let x = minX; x <= maxX; x++) {
                    pos.setX(x)
                    for (let z = minZ; z <= maxZ; z++) {
                        pos.setZ(z)
                        let dx = x + 0.5 - centerX
                        let dz = z + 0.5 - centerZ
                        let edgeNoise = (noise(x, blockY, z, noiseSeed) - 0.5) * surfaceNoise
                        if (dx * dx + dz * dz > (radius + edgeNoise) * (radius + edgeNoise)) {
                            continue
                        }

                        if (!canReplace(level.getBlockState(pos), buried || y <= 2)) {
                            continue
                        }

                        let accent = random.nextFloat() < accentChance && (radius < baseRadius * 0.45 || random.nextFloat() < 0.35)
                        level.setBlock(pos, chooseSpikeState(random, accent).defaultBlockState(), 2)
                        placed = true
                    }
                }
            }

            return placed
            // Kindly provided by Liopyu
        })
})

function chooseSpikeState(random, accent) {
    let roll = random.nextInt(accent ? 13 : 27)

    if (accent) {
        if (roll < 7) return Blocks.CRYING_OBSIDIAN
        if (roll < 12) return Blocks.BLACKSTONE
        return Blocks.DIAMOND_ORE
    }

    if (roll < 14) return Blocks.OBSIDIAN
    if (roll < 23) return Blocks.BLACKSTONE
    if (roll < 26) return Blocks.CRYING_OBSIDIAN
    return Blocks.DIAMOND_ORE
}

function noise(x, y, z, seed) {
    let value = Math.sin(x * 12.9898 + y * 78.233 + z * 37.719 + Number(seed) * 0.000001) * 43758.5453
    return value - Math.floor(value)
}

function canReplace(state, forceIntoGround) {
    if (state.is(Blocks.BEDROCK)) return false
    return forceIntoGround || state.isAir() || state.canBeReplaced()
}

// Define a configured & placed feature which use the custom feature type
ServerEvents.registry('worldgen/configured_feature', event => {
    event.create('evil_spikes', 'kubejs:evil_spikes')
        .withPlacement(p => p.modifiers(m => {
            let { minecraft } = m
            minecraft
                .rarityFilter(12)
                .inSquare()
                .heightmap('ocean_floor_wg')
                .biome()
        }))
})

// Add features to biomes
ServerEvents.registry('neoforge:biome_modifier', event => {
    event.create('add_evil_spikes', 'add_features')
        .biomes('#c:is_overworld')
        .step('surface_structures')
        .features('kubejs:evil_spikes')
})
```

{% comment %}

## no op

## no op with placement

## placed feature modifiers func

## random patch

{% endcomment %}
