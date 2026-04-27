---
layout: page
title: Configured & Placed Features
permalink: /worldjs/1.21.1/features/
parent: 1.21.1
grand_parent: WorldJS
has_children: true
has_toc: false
fragment-filter:
    - worldjs
    - 1.21.1
    - feature
fragment-sort:
    - sort
    - title
---

# Configured & Placed Features

[Configured features](https://minecraft.wiki/w/Configured_feature) are define what is placed in-world. WorldJS adds the ability to create all of vanilla's configured feature types through KubeJS's `ServerEvents.registry('worldgen/configured_feature', event => {})`{:.language-kube-21} event

{% map replacements %}
{% base Inherits the methods of the [no op](#no-op) builder %}
{% endmap %}

{% assign features = site.fragments | multi_where: 'cat', page.fragment-filter | replace_in_fragments: replacements | clean_fragments | multi_sort: page.fragment-sort %}

{% for feature in features %}

- [{{ feature.title }}](#{{ feature.anchor }})

{% endfor %}

[Placed features](https://minecraft.wiki/w/Placed_feature) define the placement restrictions of configured features. They can be made with KubeJS's `ServerEvents.registry('worldgen/placed_feature', event => {})`{:.language-kube-21} event, as described [below](#placed-features)

{% for feature in features %}

{: #{{ feature.anchor }}}

## {{ feature.title }}

**Type**: `{{ feature.type }}`

{{ feature.clean }}

{: #{{ feature.anchor }}-example }

### Example

```js-21
ServerEvents.registry('worldgen/configured-feature', event => {
    event.create('{{ feature | get_or_default: 'name', 'type' }}', '{{ feature.type }}'){% for ex in feature.example %}
        {{ ex }}{% endfor %}
})
```

{% endfor %}

## Placed Features

Placed features can be created using the JS event or via the [`.withPlacement(...)`{:.language-kube-21}](#no-op-with-placement){:.preserve-color} method of a configured feature builder

- `.configuredFeature(feature: Holder$Reference<ConfiguredFeature<?, ?>>)`{: .language-kube-21 #placed-feature-configured-feature }: Sets the configured feature the placed feature will place. Will be ignored if the placed feature was derived from a configured feature builder
- `.modifier(modifier: PlacementModifier)`{: .language-kube-21 #placed-feature-modifier }: Add the provided placement modifier
- `.jsonModifier(json: JsonElement)`{: .language-kube-21 #placed-feature-json-placement }: Add the provided json-defined placement modifier
- `.modifiers(modifiers: Consumer<PlacedFeatureBuilder$Modifiers>)`{: .language-kube-21 #placed-feature-modifiers-func }: Add pre-defined placement modifiers via [namespaced methods](#placed-feature-modifiers)

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
{% capture heightmap_types %}{% include enum_list.html summary='Reveal/hide list of valid heightmap types' values='motion_blocking,motion_blocking_no_leaves,ocean_floor,ocean_floor_wg,world_surface,world_surface_wg' %}{% endcapture %}

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
        {% include enum_list.html summary='Reveal/hide list of valid carving steps' values='air,liquid' %}
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
        {% include enum_list.html summary='Reveal/hide list of allowed directions' values='up,down,east,west,north,south' %}
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

{% comment %}

# no op

## no op with placement

## placed feature modifiers func

{% endcomment %}
