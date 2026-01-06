---
layout: page
title: Commands
permalink: /kubejs_tfc/1.21.1/commands/
parent: 1.21.1
grand_parent: KubeJS TFC
desc: Commands added by KubeJS TFC, primarily for modpack/script debugging
---

# Commands

KubeJS TFC adds several commands for debugging TFC-related parts of scripts and information. They all require a permission level of `3` or higher to use

There are commands for:

- [Listing the contents of a data type](#list-ids)
- [Describing the contents of a data entry](#describe)
- [Searching for the applicable data on an item/fluid/block/entity type](#search)
- [Printing the TFC world settings of the current level](#print-world-settings)
- [Printing the TFC rock settings of the current level](#print-rock-settings)
- [Printing the TFC `ChunkData` in the player's current chunk](#print-chunk-data)
- ['Solving' a tree template for use in TFC tree structures & configured features](#tree-solver)
- [Inspecting `Noise2D` objects](#inspect-2d-noise)
- [Inspecting `Noise3D` objects](#inspect-3d-noise)
- [Reloading KubeJS TFC's config](#reload-kubejs-tfc-config)

## List IDs

Prints a list of data entries handled by a data type. Each entry can be clicked to [describe](#describe) it. The entries are printed in alphabetical order in a paginated view. The gold arrows below the list of entries can be used to see the previous and next pages

The command has the following form:

`/kubejs_tfc list_ids <data_type> [<page>]`{: .language-command }

- `<data_type>`{:.v}: The data type to list entries of. All data types will be suggested
- `[<page>]`{:.m}: A positive integer, the page to list. Will be clamped to available pages of results. Optional

An example: `/kubejs_tfc list_ids tfc:fuel 2`{: .language-command }

## Describe

Prints an overview of the data contained in a data entry.

The command has the following form:

`/kubejs_tfc describe <data_type> <id>`{: .language-command }

- `<data_type>`{:.v}: The data type to retrieve the entry from. All data types will be suggested
- `<id>`{:.m}: The id of the entry to describe. The ids of all entries handled by the data type will be suggested

An example: `/kubejs_tfc describe tfc:fuel tfc:coal`{: .language-command }

## Search

Prints a list of data entries which apply to a registry entry. Each entry can be clicked to [describe](#describe) it

The command has the following form:

`/kubejs_tfc search <data_type> <value>`{: .language-command }

- `<data_type>`{:.v}: The data type to retrieve the list from. All searchable data types will be suggested
- `<value>`{:.m}: The registry id of the item/block/fluid/entity type that has a data entry in the data type. All objects with an associated data entry will be suggested

Examples:

- `/kubejs_tfc search tfc:fluid_heat tfc:metal/copper`{; .language-command }
- `/kubejs_tfc search tfc:entity_damage_resistance minecraft:creeper`{; .language-command }
- `/kubejs_tfc search tfc:fertilizer tfc:powder/wood_ash`{: .language-command }

## Print World Settings

Prints the [TFC Settings](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/world-preset/) of the current level if the chunk generator is TFC-like[^1]

[^1]: Implements TFC's [`ChunkGeneratorExtension`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/world/ChunkGeneratorExtension.java)

The command has the following form:

`/kubejs_tfc print_world_settings`{: .language-command }

The rock layer settings within the TFC settings will not be printed as they have a tendency to fill the entire message history. Instead, `~~~` will be printed in its place; this can be clicked to [print them separately](#print-rock-settings)

## Print Rock Settings

Prints the [rock layer settings](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/world-preset/#rock-layer-settings) of the current level if the chunk generator is TFC-like[^1]

The command has the following form:

`/kubejs_tfc print_rock_settings`{: .language-command }

## Print Chunk Data

Prints the server [`Chunkdata`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/world/chunkdata/ChunkData.java) of the current chunk in an ostensibly readable format. Only the infomration available will be printed. That is to say, if the status is `EMPTY`{:.e}, `CLIENT`{:.e} (somehow), or `INVALID`{:.e} no additional information will be printed; and the surface and aquifer heights will only be printed if the status is `FULL`{:.e}

The command has the following form:

`/kubejs_tfc print_chunk_data`

## Tree Solver

Converts one or more in-world tree templates into trees which properly interact with TFC's logging mechanic, primarily intended for easily making tree structures for [forests]({% link kubejs_tfc/1.21.1/worldgen.md %}#forest)

This command replaces template blocks in-world with the selected log and leaves blocks in the correct block state. There are three template blocks:

- `minecraft:light_blue_stained_glass`: Marks a root position, or the 'origin' of a tree. This is the only block *required* to be within the scan area. Must have a `minecraft:brown_stained_glass` block immediately above it; and for a `<trunk_size>`{:.v} of `2`{:.v}, it should be in a two by two pattern
- `minecraft:brown_stained_glass`: Marks a log position. The solver climbs upwards from the root marker(s) breadth-first along this block. The solver will connect to ant log marker in the 3 by 3 by 3 area centered at the current position, though the lowest order[^2] connection that is valid will be used
- `minecraft:green_stained_glass`: Marks a leaf position. Markers beyond the decay range of the leaves block will *not* be replaced

[^2]: Order 1: share a face, order 2: share an edge, order 3: share a vertex

All root positions within the scan area will be solved and converted into trees, though the command will fail to run if it encounters a root that does not have the same size as the `<trunk_size>`{:.v} argument or a root marker does not have a log marker above it

The command has the following form:

`/kubejs_tfc tree_solver <trunk_size> <log_block> <leaves_block> <from> <to>`{: .language-command }

- `<trunk_size>`{:.v}: An integer, either `1`{:.v} or `2`{:.v}, the trunk size of the templates to solve
- `<log_block>`{:.m}: A block. Is limited to and will only suggest blocks with TFC's branch direction property. See the [log block type]({% link kubejs_tfc/1.21.1/blocks.md %}#log) for custom logs
- `<leaves_block>`{:.s}: A block. Is limited to and will only suggest blocks TFC leaves blocks. See the [leaves block type]({% link kubejs_tfc/1.21.1/blocks.md %}#leaves) for custom leaves
- `<from>`{:.r}: A block position, one corner of the scan area. Supports relative positions
- `<to>`{:.nb}: A block position, the other corner of the scan area. Supports relative positions

<details>
    <summary>As an example</summary>
    <figure>
        <img src="/assets/images/kjs_tfc/tree_solver/pre_solve.png" alt="pre-solve" />
        <figcaption>A tree template using the marker blocks. The tree solver command is typed in the chat box</figcaption>
    </figure>
    <br />
    <figure>
        <img src="/assets/images/kjs_tfc/tree_solver/post_solve.png" alt="post-solve" />
        <figcaption>A tree, as solved from the template in the previous image</figcaption>
    </figure>
    <br />
</details>
<details>
    <summary>It can also handle rather strange forms</summary>
    <figure>
        <img src="/assets/images/kjs_tfc/tree_solver/pre_solve_dumb.png" alt="pre-solve" />
        <figcaption>A tree template, though the log markers are in a large brick form</figcaption>
    </figure>
    <br />
    <figure>
        <img src="/assets/images/kjs_tfc/tree_solver/post_solve_dumb.png" alt="post-solve" />
        <figcaption>A brick of logs as solved from the template in the previous image. Ostensibly, a tree</figcaption>
    </figure>
    <br />
</details>

## Inspect 2D Noise

Displays the selected registered [`Noise2D`{: .language-kube-21 }]({% link kubejs_tfc/1.21.1/type-explanations.md %}#noise-2d) in-world with the given parameters. In order to inspect a noise, it must be [registered]({% link kubejs_tfc/1.21.1/bindings/noise.md %}#inspect-2d)

The command has the following form:

`/kubejs_tfc inspect_2d_noise <from> <to> <input_range> <output_range> <noise>`{: .language-command }

- `<from>`{:.v}: A block position, one corner of the display area. Supports relative positions
- `<to>`{:.m}: A block position, the other corner of the display area. Supports relative positions
- `<input_range>`{:.s}: A range[^3], the range which the noise will be samples over for the x and z axes
- `<output_range>`{:.r}: A range[^3], the expected range for output values of the noise
- `<noise>`{:.nb}: The name of the noise to inspect

[^3]: A pair of numbers

This command fills space in-world by sampling the noise over the `<input_range>`{:.s} in the largest x-z *square*bounded by the `<from>`{:.v} and `<to>`{:.m} positions' x and z coordinates. The value of the noise at the sampled position will then be mapped to a y-position within the bounds of `<from>`{:.v} and `<to>`{:.m} and white stained glass will be placed at that position. If the value is beyond beyond the bounds of `<output_range>`{:.r}, the red stained glass will be placed at the edge of the y-boundaries instead. If the value is infinite, then lime stained glass will be placed instead. If the value is [`Nan`](https://en.wikipedia.org/wiki/NaN), then purple stained glass will be placed instead.

## Inspect 3D Noise

Displays the selected registered [`Noise3D`{: .language-kube-21 }]({% link kubejs_tfc/1.21.1/type-explanations.md %}#noise-3d) in-world with the given parameters. In order to inspect a noise, it must be [registered]({% link kubejs_tfc/1.21.1/bindings/noise.md %}#inspect-3d)

The command has the following form:

`/kubejs_tfc inspect_3d_noise <from> <to> <input_range> <output_range> <noise> [<y_value>]`{: .language-command }

- `<from>`{:.v}: A block position, one corner of the display area. Supports relative positions
- `<to>`{:.m}: A block position, the other corner of the display area. Supports relative positions
- `<input_range>`{:.s}: A range[^3], the range which the noise will be sampled over for the x, y, and z axes
- `<output_range>`{:.r}: A range[^3], the expected range for output values of the noise
- `<noise>`{:.nb}: The name of the noise to inspect
- `[<y_value>]`{:.o}: A number. If present, the 3D noise is treated as a 2D noise by only sampling it at the given y-value and displayed in-world as if it were a 2D noise

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

## Reload KubeJS TFC Config

Reloads and prints the [KubeJS TFC config]({% link kubejs_tfc/1.21.1/misc.md %}#configuration)

The command has the following form:

`/kubejs_tfc reload_config`{: .language-command }
