---
title: Inspect 2D Noise
anchor: inspect-2d-noise
cat:
    - kubejs_tfc
    - 1.21.1
    - command
group: noise
desc: Inspecting `Noise2D`{:.f} objects
form: inspect_2d_noise <from> <to> <input_range> <output_range> <noise>
args:
    - '`<from>`[[1]]: A block position, one corner of the display area. Supports relative positions'
    - '`<to>`[[2]]: A block position, the other corner of the display area. Supports relative positions'
    - '`<input_range>`[[3]]: A range[[ fn_range ]], the range which the noise will be sampled over for the x and z axes'
    - '`<output_range>`[[4]]: A range[[ fn_range ]], the expected range for output values of the noise'
    - '`<noise>`[[5]]: The name of the noise to inspect'
exp: 'Displays the selected registered [`Noise2D`{:.f}]({% link kubejs_tfc/1.21.1/type-explanations.md %}#noise-2d){:.preserve-color} in-world with the given parameters. In order to inspect a noise, it must be [registered]({% link kubejs_tfc/1.21.1/bindings/noise.md %}#inspect-2d)'
---

This command fills space in-world by sampling the noise over the `<input_range>`{:.s} in the largest x-z *square* bounded by the `<from>`{:.v} and `<to>`{:.m} positions' x and z coordinates. The value of the noise at the sampled position will then be mapped to a y-position within the bounds of `<from>`{:.v} and `<to>`{:.m} and white stained glass will be placed at that position. If the value is beyond beyond the bounds of `<output_range>`{:.r}, the red stained glass will be placed at the edge of the y-boundaries instead. If the value is infinite, then lime stained glass will be placed instead. If the value is [`Nan`](https://en.wikipedia.org/wiki/NaN), then purple stained glass will be placed instead.
