---
title: Density Function
anchor: density-function
cat:
    - worldjs
    - 1.21.1
    - wrapper
---

{% capture range %}Must be {% in_range -1000000,1000000 %}{% endcapture %}
{% capture s_range %}Must be {% in_range 0.001,1000 %}{% endcapture %}
{% capture n %}[noise parameters](https://minecraft.wiki/w/Noise) id{% endcapture %}
{% capture noise %}A {{ n }}, the noise to use{% endcapture %}

[Density functions](https://minecraft.wiki/w/Density_function?oldid=3060331) define a function to obtain a number from a position

In scripts they can de defined as

- A `DensityFunction` object: itself
- A string, `ResourceLocation`, or density function `ResourceKey`: The density function previously registered under the given id
- A `number`{:.p}: A `minecraft:constant` density function
    - {{ range }}
- A map:
    - If the map contains a `'type'`{:.s} field, the map is parsed as if it were defined in json, using the specification linked above
    - If the map contains a `'blend_alpha'`{:.s} field, a `minecraft:blend_alpha` density function will be created
    - If the map contains a `'beardifier'`{:.s} field, a `minecraft:beardifier` density function will be created
    - If the map contains a `'old_blend_noise'`{:.s} field, a `minecraft:old_blend_noise` density function will be created
        - The `old_blend_noise` object is expected to be a map with the following fields
            - `'xz_scale'`{:.s}: A `number`{:.p}, the horizontal scale
                - {{ s_range }}
            - `'y_scale'`{:.s}: A `number`{:.p}, the vertical scale
                - {{ s_range }}
            - `'xz_factor'`{:.s}: A `number`{:.p}, the horizontal scale
                - {{ s_range }}
            - `'y_factor'`{:.s}: A `number`{:.p}, the vertical scale
                - {{ s_range }}
            - `'smear_scale_multiplier'`{:.s}: A `number`{:.p}, a multiplier applied to the `y_scale`{:.v}
                - Must be {% in_range 1,8 %}
    - If the map contains a `'interpolated'`{:.s} field, a `minecraft:interpolated` density function will be created
        - The `interpolated` object is expected to be a density function
    - If the map contains a `'flat_cache'`{:.s} field, a `minecraft:flat_cache` density function will be created
        - The `flat_cache` object is expected to be a density function
    - If the map contains a `'cache_2d'`{:.s} field, a `minecraft:cache_2d` density function will be created
        - The `cache_2d` object is expected to be a density function
    - If the map contains a `'cache_once'`{:.s} field, a `minecraft:cache_once` density function will be created
        - The `cache_once` object is expected to be a density function
    - If the map contains a `'cache_all_in_cell'`{:.s} field, a `minecraft:cache_all_in_cell` density function will be made
        - The `cache_all_in_cell` object is expected to be a density function
    - If the map contains a `'noise'`{:.s} field, a `minecraft:noise` density function will be created
        - The `noise` object is expected to be a map with the following fields
            - `'noise'`{:.s}: {{ noise }}
            - `'xz_scale'`{:.s}: A `number`{:.p}, the horizontal scaling before sampling
            - `'y_scale'`{:.s}: A `number`{:.p}, the vertical scaling before sampling
    - If the map contains a `'end_islands'`{:.s} object, a `minecraft:end_islands` density function will be made
    - If the map contains a `'weird_scaled_sampler'`{:.s} field, a `minecraft:weird_scaled_sampler` density function will be created
        - The `weird_scaled_sampler` is expected to be a map with the following fields
            - `'input'`{:.s}: A density function, the function to be scaled
            - `'noise'`{:.s}: {{ noise }}
            - `'rarity_value_mapper'`{:.s}: A `RarityValueMapper`{:.e}, the value mapper type to use
                {% include enum_list.html summary='Reveal/hide valid rarity value mappers' values='type1,type2' %}
    - If the map contains a `'shifted_noise'`{:.s} field, a `minecraft:shifted_noise` density function will be created
        - The `shifted_noise` object is expected to be map with the following fields
            - `'shift_x'`{:.s}: A density function, the shift in the x direction
            - `'shift_y'`{:.s}: A density function, the shift in the y direction
            - `'shift_z'`{:.s}: A density function, the shift in the z direction
            - `'xz_scale'`{:.s}: A `number`{:.p}, the horizontal scaling before sampling
            - `'y_scale'`{:.s}: A `number`{:.p}, the vertical scaling before sampling
            - `'noise'`{:.s}: {{ noise }}
    - If the map contains a `'range_choice'`{:.s} field, a `minecraft:range_choice` density function will be created
        - The `range_choice` object is expected to be a map with the following fields
            - `'input'`{:.s}: A density function, the value to compare
            - `'min_inclusive'`{:.s}: A `number`{:.p}, the lower bound of the range
                - {{ range }}
            - `'max_inclusive'`{:.s}: A `number`{:.p}, the upper bound of the range
                - {{ range }}
            - `'when_in_range'`{:.s}: A density function, the value to use when the `input`{:.v} is within the range
            - `'when_out_of_range'`{:.s}: A density function, the value to use when the `input`{:.v} is outside of the range
    - If the map contains a `'shift_a'`{:.s} field, a `minecraft:shift_a` density function will be created
        - The `shift_a` object is expected to be a {{ n }}, the noise to sample
    - If the map contains a `'shift_b'`{:.s} field, a `minecraft:shift_b` density function will be created
        - The `shift_b` object is expected to be a {{ n }}, the noise to sample
    - If the map contains a `'shift'`{:.s} field, a `minecraft:shift` density function will be created
        - The `shift` field is expected to be a {{ n }}, the noise to sample
    - If the map contains a `'blend_density'`{:.s} field, a `minecraft:blend_density` density function will be created
        - The `blend_density` object is expected to be a density function, the desired density of new chunks
    - If the map contains a `'clamp'`{:.s} field, a `minecraft:clamp` density function will be created
        - The `clamp` object is expected to be a map with the following fields
            - `'input'`{:.s}: A density function, the function be clamped
            - `'min_value'`{:.s}: A `number`{:.p}, the minimum value
                - {{ range }}
            - `'max_value'`{:.s}: A `number`{:.p}, the maximum value
                - {{ range }}
    - If the map contains an `'abs'`{:.s} field, a `minecraft:abs` density function will be created
        - The `abs` object is expected to be a density function, the function to be absolute valued
    - If the map contains a `'square'`{:.s} field, a `minecraft:square` density function will be created
        - The `square` object is expected to be a density function, the function to be squared
    - If the map contains a `'cube'`{:.s} field, a `minecraft:cube` density function will be created
        - The `cube` object is expected to be a density function, the function to be cubed
    - If the map contains a `'half_negative'`{:.s} field, a `minecraft:half_negative` density function will be created
        - The `half_negative` object is expected to be a density function, the function to halve when negative
    - If the map contains a `'quarter_negative'`{:.s} field, a `minecraft:quarter_negative` density function will be created
        - The `quarter_negative` field is expected to be a density function, the function to be quartered when negative
    - If the map contains a `'squeeze'`{:.s} field, a `minecraft:squeeze` density function will be created
        - The `squeeze` object is expected to be a density function, the function to be squeezed
    - If the map contains an `'add'`{:.s} field, a `minecraft:add` density function will be created
        - The `add` object is expected to be a map with two fields
            - `'first'`{:.s}: A density function
            - `'second'`{:.s}: A density function
    - If the map contains a `'mul'`{:.s} field, a `minecraft:mul` density function will be created
        - The `mul` object is expected to be a map with two fields
            - `'first'`{:.s}: A density function
            - `'second'`{:.s}: A density function
    - If the map contains a `'min'`{:.s} field, a `minecraft:min` density function will be created
        - The `min` object is expected to be a map with two fields
            - `'first'`{:.s}: A density function
            - `'second'`{:.s}: A density function
    - If the map contains a `'max'`{:.s} field, a `minecraft:max` density function will be created
        - The `max` object is expected to be a map with two fields
            - `'first'`{:.s}: A density function
            - `'second'`{:.s}: A density function
    - If the map contains a `'spline'`{:.s} field, a `minecraft:spline` density function will be created
        - The `spline` object is expected to be a [spline](#{{ page.anchor }}-spline)
    - If the map contains a `'constant'`{:.s} field, a `minecraft:constant` density function will be created
        - The `constant` field is expected to be A `number`{:.p}, the constant value
            - {{ range }}
    - If the map contains a `'y_clamped_gradient'`{:.s} field, a `minecraft:y_clamped_gradient` density function will be created
        - The `y_clamped_gradient` object is expected to be a map with the following fields
            - `'from_y'`{:.s}: An `int`{:.p}, the value to map to `from_value`{:.v}
                - Must be {% in_range -4064,4062 %}
            - `'to_y'`{:.s}: An `int`{:.p}, the value to map to `to_value`{:.v}
                - Must be {% in_range -4064,4062 %}
            - `'from_value'`{:.s}: A `number`{:.p}, the value to map `from_y`{:.v} to
                - {{ range }}
            - `'to_value'`{:.s}: A `number`{:.p}, the value to map `to_y`{:.v} to
                - {{ range }}

Other values will emit an error

{: #{{ page.anchor }}-spline }

## Spline

In [density functions](#{{ page.anchor }}), splines can be defined in scripts as

- A `number`{:.p}: A constant value
- A map with the following fields
    - `'coordiante'`{:.s}: A string, `ResourceLocation`, or density function `ResourceKey`: The previously registered density function used to determine the location on the spline
    - `'value_transformer'`{:.s}: The transformer applied to constant spline points. A callback with the params
        - `value: number`{:.language-kube-21}: The value of the point
        - `return: number`{:.language-kube-21}: The transformed `value`{:.v}
        - Optional, defaults to `val => val`{:.language-kube-21}
    - `'points'`{:.s}: A list of spline points, which are maps with the following fields
        - For a constant point
            - `'location'`{:.s}: A `number`{:.p}, the location of the point on the spline
            - `'value'`{:.s}: A `number`{:.p}, the value of the point
            - `'derivative'`{:.s}: A `number`{:.p}, the slope at the point
        - For a variable point
            - `'location'`{:.s}: A `number`{:.p}, the location of the point on the spline
            - `'value'`{:.s}: A [spline](#{{ page.anchor }}-spline), the value of the point

Other values will emit an error
