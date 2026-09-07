---
title: Inspect 3D Noise
anchor: inspect-3d-noise
cat:
    - kubejs_tfc
    - 1.21.1
    - command
group: noise
desc: Inspecting `Noise3D`{:.f} objects
form: inspect_3d_noise <from> <to> <input_range> <output_range> <noise> [<y_value>]
args:
    - '`<from>`[[1]]: A block position, one corner of the display area. Supports relative positions'
    - '`<to>`[[2]]: A block position, the other corner of the display area. Supports relative positions'
    - '`<input_range>`[[3]]: A range[[ fn_range ]], the range which the noise will be sampled over for the x, y, and z axes'
    - '`<output_range>`[[4]]: A range[[ fn_range ]], the expected range for output values of the noise'
    - '`<noise>`[[5]]: The name of the noise to inspect'
    - '`[<y_value>]`[[6]]: A number. If present, the 3D noise is treated as a 2D noise by only sampling it at the given y-value displayed as if it were a 2D noise'
exp: Displays the selected registered [`Noise3D`{:.f}]({% link kubejs_tfc/1.21.1/type-explanations.md %}#noise-3d){:.preserve-color} in-world with the given parameters. In order to inspect a noise, it must be [registered]({% link kubejs_tfc/1.21.1/bindings/noise.md %}#inspect-3d)
---

This command fills space in-world by sampling the noise over the `<input_range>`{:.s} in the largest x-y-z *cube* bounded by the `<from>`{:.v} and `<to>`{:.m} positions. The value of the noise at the sampled position will then be mapped onto a gradient of stained glass, as described below, and the block will be placed at that position. If the value is beyond the bounds of `<output_range>`{:.r}, then the position will be filled with air

The gradient, from lowest to highest, is represented as:

- {% color F0F0F0|▮ %} White Stained Glass
- {% color D88198|▮ %} Pink Stained Glass
- {% color B3312C|▮ %} Red Stained Glass
- {% color EB8844|▮ %} Orange Stained Glass
- {% color DECF2A|▮ %} Yellow Stained Glass
- {% color 41CD34|▮ %} Lime Stained Glass
- {% color 6689D3|▮ %} Light Blue Stained Glass
- {% color ABABAB|▮ %} Light Gray Stained Glass
- {% color 434343|▮ %} Gray Stained Glass
- {% color 287697|▮ %} Cyan Stained Glass
- {% color 3B511A|▮ %} Green Stained Glass
- {% color 253192|▮ %} Blue Stained Glass
- {% color C354CD|▮ %} Magenta Stained Glass
- {% color 7B2FBE|▮ %} Purple Stained Glass
- {% color 51301A|▮ %} Brown Stained Glass
- {% color 1E1B1B|▮ %} Black Stained Glass
