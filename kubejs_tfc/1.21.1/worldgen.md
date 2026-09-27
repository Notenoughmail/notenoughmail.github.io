---
layout: page
title: Worldgen
permalink: /kubejs_tfc/1.21.1/worldgen/
parent: 1.21.1
grand_parent: KubeJS TFC
desc: Documentation on how to create some of TFC's configured features
---

# Worldgen

{: .notice #worldjs-notice }
> All the functionality mentioned on this page requires [WorldJS]({% link worldjs/index.md %}) to work

Worldgen features are primarily done through placed and configured features. KubeJS TFC adds the ability to make these through builders in the `worldgen/configured_feature` server registry event

{% map replacements %}
{% base %}Inherits the methods of the [no op]({% link worldjs/1.21.1/features.md %}#no-op) builder{% end_base %}
{% required %}**Must** be set{% end_required %}
{% unit %}Must be {% in_unit %}{% end_unit %}
{% def_0 %}Defaults to `0`{:.n}{% end_def_0 %}
{% def_1 %}Defaults to `1`{:.n}{% end_def_1 %}
{% def_f %}Defaults to `false`{:.p}{% end_def_f %}
{% def_t %}Defaults to `true`{:.p}{% end_def_t %}
{% pos %}Must be {% in_range 1,,) %}{% end_pos %}
{% non_neg %}Must be {% in_range 0,,) %}{% end_non_neg %}
{% weight %}[`WeightedValue`]({% link worldjs/1.21.1/wrappers.md %}#weighted-value){% end_weight %}
{% cluster %}Inherits the methods of the [cluster vein](#cluster-vein) builder{% end_cluster %}
{% n_inf %}Defaults to `-Infinity`{:.language-kube-21}{% end_n_inf %}
{% p_inf %}Defaults to `Infinity`{:.n}{% end_p_inf %}
{% endmap %}

{% assign features = site | fragments_replace: replacements, 'kubejs_tfc', '1.21.1', 'conf_feature' | multi_sort: 'group', 'sort_pos', 'title' %}

{% grid n=3 %}

{% for feature in features %}

- [{{ feature.title }}](#{{ feature.anchor }})

{% endfor %}

</div>

KubeJS TFC also adds a [`tfc` namespace](#placed-feature-modifiers) to the [modifiers function]({% link worldjs/1.21.1/features.md %}#placed-feature-modifiers-func) of  WorldJS's placed feature builder, which is also used by TFC's configured feature types

{% for feature in features %}

{: #{{ feature.anchor }} }

## {{ feature.title }}

**Type**: `tfc:{{ feature.type }}`

Creates a {% if feature.wiki_link %}[tfc:{{ feature.type }}]({{ feature.wiki_link }}){% else %}`tfc:{{ feature.type }}`{% endif %} configured feature

{% if feature.inherit %}

Inherits the methods of the [{{ feature.inherit-display }}]({{ feature.inherit | render_full }}) builder

{% endif %}

{{ feature.clean }}

{: #{{ feature.anchor }}-example }

### Example

```js-21
ServerEvents.registry('minecraft:configured_feature', event => {
    event.create('{{ feature | get_or_default: 'name', 'type' }}', 'tfc:{{ feature.type }}')
        {{ feature.example | with_indent }}
})
```

{% endfor %}

---

## Placed Feature Modifiers

KubeJS TFC adds the following [placement modifiers]({% link worldjs/1.21.1/features.md %}#placed-feature-modifiers) under the `tfc` namespace

{% capture vertical_anchor %}[vertical anchor]({% link worldjs/1.21.1/wrappers.md %}#vertical-anchor){% endcapture %}

- `.underground()`{: .language-kube-21 #placed-feature-modifier-underground }: Add a `tfc:underground` modifier
- `.noSolidNeighbors()`{: .language-kube-21 #placed-feature-modifier-no-solid-neighbors }: Add a `tfc:no_solid_neighbors` modifier
- `.volcano(minEasing: float, maxEasing: float)`{: .language-kube-21 #placed-feature-modifier-volcano }: Add a `tfc:volcano` modifier
    - `minEasing: float`{:.language-kube-21}: The minimum easing value
    - `maxEasing: float`{:.language-kube-21}: The maximum easing value
- `.volcanoCenter()`{: .language-kube-21 #placed-feature-modifier-volcano-center }: Add a `tfc:volcano` modifier which only accepts positions at the center
- `.tuffCone(minEasing: float, maxEasing: float)`{: .language-kube-21 #placed-feature-modifier-tuff-cone }: Add a `tfc:tuff_cone` modifier
    - `minEasing: float`{:.language-kube-21}: The minimum easing value
    - `maxEasing: float`{:.language-kube-21}: The maximum easing value
- `.tuffConeCenter()`{: .language-kube-21 #placed-feature-modifier-tuff-cone-center }: Add a `tfc:tuff_cone` modifier which only accepts positions at the center
- `.tuya(minEasing: float, maxEasing: float)`{: .language-kube-21 #placed-feature-modifier-tuya }: Add a `tfc:tuya` modifier
    - `minEasing: float`{:.language-kube-21}: The minimum easing value
    - `maxEasing: float`{:.language-kube-21}: The maximum easing value
- `.tuyaCenter()`{: .language-kube-21 #placed-feature-modifier-tuya-center }: Add a `tfc:tuya` modifier which only accepts positions at the center
- `.atoll(minEasing: float, maxEasing: float)`{: .language-kube-21 #placed-feature-modifier-atoll }: Add a `tfc:atoll` modifier
    - `minEasing: float`{:.language-kube-21}: The minimum easing value
    - `maxEasing: float`{:.language-kube-21}: The maximum easing value
- `.atollCenter()`{: .language-kube-21 #placed-feature-modifier-atoll-center }: Add a `tfc:atoll` modifier which only accepts positions at the center
- `.shallowWater(minDepth: int, maxDepth: int)`{: .language-kube-21 #placed-feature-modifier-shallow-water }: Add a `tfc:shallow_water` modifier
    - `minDepth: int`{:.language-kube-21}: The minimum depth of water required
    - `maxDepth: int`{:.language-kube-21}: The maximum depth of water permitted
- `.nearFluid(radius: int, fluids?: List<Fluid>)`{: .language-kube-21 #placed-feature-modifier-near-fluid }: Add a `tfc:near_fluid` modifier
    - `radius: int`{:.language-kube-21}: The radius to check for fluid
    - `fluids?: List<Fluid>`{:.language-kube-21}: The fluids to consider
        - Optional. Considers all fluids valid if not set
- `.intertidal(minElevation: int, maxElevation: int)`{: .language-kube-21 #placed-feature-modifier-intertidal }: Add a `tfc:intertidal` modifier
    - `minElevation: int`{:.language-kube-21}: The minimum valid tide elevation
    - `maxElevation: int`{:.language-kube-21}: The maximum valid tide elevation
- `.intertidalMin(minElevation: int)`{: .language-kube-21 #placed-feature-modifier-intertidal-min }: Add a `tfc:intertidal` modifier which is unbounded on the top
    - `minElevation: int`{:.language-kube-21}: The minimum valid tide elevation
- `.intertidalMax(maxElevation: int)`{: .language-kube-21 #placed-feature-modifier-intertidal-max }: Add a `tfc:intertidal` modifier which is unbounded on the bottom
    - `maxElevation: int`{:.language-kube-21}: The maximum valid tide elevation
- `.flatEnough(flatness: float, radius: int, maxDepth: int)`{: .language-kube-21 #placed-feature-modifier-flat-enough }: Add a `tfc:flat_enough` modifier
    - `flatness: float`{:.language-kube-21}: The minimum flatness of the checked area
        - {{ replacements.unit }}
    - `radius: int`{:.language-kube-21}: The horizontal distance to check
        - {{ replacements.pos }}
    - `maxDepth: int`{:.language-kube-21}: The depth below the initial position to check
        - {{ replacements.pos }}
- `.climate(climate: ClimatePlacementBuilder)`{: .language-kube-21 #placed-feature-modifier-climate }: Add a `tfc:climate` modifier. Accepts a `ClimatePlacementBuilder`, which can be made as a map of parameters to values
    - `minTemp?: number`{:.language-kube-21}: The minimum temperature
        - {{ replacements.n_inf }}
    - `maxTemp?: number`{:.language-kube-21}: The maximum temperature
        - {{ replacements.p_inf }}
    - `minGroundWater?: number`{:.language-kube-21}: The minimum groundwater
        - {{ replacements.n_inf }}
    - `maxGroundwater?: number`{:.language-kube-21}: The maximum groundwater
        - {{ replacements.p_inf }}
    - `minRainVariance?: number`{:.language-kube-21}: The minimum rain variance value
        - Defaults to `-1`{:.n}
    - `maxRainVariance?: number`{:.language-kube-21}: The maximum rain variance value
        - {{ replacements.def_1 }}
    - `absoluteRainVariance?: boolean`{:.language-kube-21}: If the sign of the rain variance should be ignored
        - {{ replacements.def_f }}
    - `fuzzy?: boolean`{:.language-kube-21}: If values should be evaluated fuzzily
        - {{ replacements.def_f }}
    - `ignoreRivers?: boolean`{:.language-kube-21}: If values should be evaluated before river influences
        - {{ replacements.def_f }}
    - `minForestDensity?: int`{:.language-kube-21}: The minimum forest density
        - {{ replacements.non_neg }}
        - {{ replacements.def_0 }}
    - `maxForestDensity?: int`{:.language-kube-21}: The maximum forest density
        - {{ replacements.non_neg }}
        - Defaults to `4`{:.n}
    - `minElevation?: int`{:.language-kube-21}: The minimum y-level
        - Defaults to `-64`{:.n}
    - `maxElevation?: int`{:.language-kube-21}: The maximum y-level
        - Defaults to `320`{:.n}
    - `forestTypes?: List<ForestType>`{:.language-kube-21}: The permitted [forest types]({% link kubejs_tfc/1.21.1/type-explanations.md %}#forest-type-enum) to spawn in
        - Optional, if not set or empty permits all forest types
- `.carvingMask(minY: VerticalAnchor, maxY: VerticalAnchor, step: GenerationStep$Carving)`{: .language-kube-21 #placed-feature-modifier-carving-mask }: Add a `tfc:carving_mask` modifier
    - `minY: VerticalAnchor`{:.language-kube-21}: The minimum valid {{ vertical_anchor }}
    - `maxY: VerticalAnchor`{:.language-kube-21}: The maximum valid {{ vertical_anchor }}
    - `step: GenerationStep$Carving`{:.language-kube-21}: The carving step volume for which the feature will try to place in. Does not include blocks ‘carved’ out by noise caves
        {% include enum_list.html summary='Reveal/hide list of carving steps' values='air,liquid' %}
- `.carvingMaskMin(minY: VerticalAnchor, step: GenerationStep$Carving)`{: .language-kube-21 #placed-feature-modifier-carving-mask-min }: Add a `tfc:carving_mask` modifier which is unbounded above
    - `minY: VerticalAnchor`{:.language-kube-21}: The minimum valid {{ vertical_anchor }}
    - `step: GenerationStep$Carving`{:.language-kube-21}: The carving step volume for which the feature will try to place in. Does not include blocks ‘carved’ out by noise caves
        {% include enum_list.html summary='Reveal/hide list of carving steps' values='air,liquid' %}
- `.carvingMaskMax(maxY: VerticalAnchor, step: GenerationStep$Carving)`{: .language-kube-21 #placed-feature-modifier-carving-mask-max }: Add a `tfc:carving_mask` modifier which is unbounded below
    - `maxY: VerticalAnchor`{:.language-kube-21}: The maximum valid {{ vertical_anchor }}
    - `step: GenerationStep$Carving`{:.language-kube-21}: The carving step volume for which the feature will try to place in. Does not include blocks ‘carved’ out by noise caves
        {% include enum_list.html summary='Reveal/hide list of carving steps' values='air,liquid' %}
- `.onTop(predicate: BlockPredicate)`{: .language-kube-21 #placed-feature-modifier-on-top }: Add a `tfc:on_top` modifier
    - `predicate: BlockPredicate`{:.language-kube-21}: The block required below for a position to be valid
- `.stratovolcano(stratovolcano: StratovolcanoBuilder)`{: .language-kube-21 #placed-feature-modifier-stratovolcano }: Adds a `tfc:stratovolcano` modifier. Accepts a `StratovolcanoBuilder`, which can be made as a map of parameters to values
    - `center?: boolean`{:.language-kube-21}: If the feature should place exclusively near the center of the volcanic features
        - {{ replacements.def_f }}
    - `useOffsetCenter?: boolean`{:.language-kube-21}: If the feature should place exclusively near the offset center of volcanic features, if the variant has an offset center
        - {{ replacements.def_f }}
    - `variant?: String`{:.language-kube-21}: The variant to place in
        - Defaults to `'all'`{:.language-kube-21}
    - `minEasing?: number`{:.language-kube-21}: The minimum easing value
        - {{ replacements.unit }}
        - {{ replacements.def_0 }}
    - `maxEasing?: number`{:.language-kube-21}: The maximum easing value
        - {{ replacements.unit }}
        - {{ replacements.def_1 }}
    - `hashMin?: number`{:.language-kube-21}: The minimum hash value
        - {{ replacements.unit }}
        - {{ replacements.def_0 }}
    - `hashMax?: number`{:.language-kube-21}: The maximum hash value
        - {{ replacements.unit }}
        - {{ replacements.def_1 }}

{% comment %}

## cluster vein

{% endcomment %}
