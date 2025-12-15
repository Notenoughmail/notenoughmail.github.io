---
layout: page
title: Commands
permalink: /kubejs_tfc/1.20.1/commands/
parent: 1.20.1
grand_parent: KubeJS TFC
desc: Documentation for the commands added by KubeJS TFC, useful for modpack debugging
---

# Commands

KubeJS TFC adds several commands which can be used for debugging or prototyping certain parts of scripts. They all require permission level `3` or higher to use

There are commands for:

- [Listing the contents of a data type](#list-ids)
- [Describing the contents of a data entry](#describe)
- [Searching for the applicable data on a item/fluid/block/entity type](#search)
- [Printing the TFC world settings of the current level](#print-world-settings)
- [Printing the TFC rock settings of the current level](#print-rock-settings)
- [Printing the `ChunkData` in the current chunk](#print-chunk-data)
- ['Solving' a tree template for use in structures](#tree-solver)
- [Inspecting `Noise2D` objects](#inspect-2d-noise)
- [Inspecting `Noise3D` objects](#inspect-3d-noise)

## List IDs

The list ids commands prints a list of data entries handled by a data type. Each entry can be clicked to [describe](#describe) it. Additionally, the results are printed in alphabetical order and paginated with ten entries per page. Below the printed list will be gold arrows, which can be clicked to see the previous or next page

The command has the following form:

`/kubejs_tfc list_ids <data_type> [<page>]`{:.language-command}

- `<data_type>`{:.v}: The data type to list entries of. Will take the form of `<mod_id>.<type_name>`. All data types will suggested
- `[<page>]`{:.m}: A positive integer, the page to list. Will be clamped to last page of results. Optional

An example: `/kubejs_tfc list_ids tfc.fuels 2`{:.language-command}

## Describe

The describe command prints a overview of the data contained in a data entry

The command has the following form:

`/kubejs_tfc describe <data_type> <id>`{:.language-command}

- `<data_type>`{:.v}: The data type to retrieve the entry from. Will take the form of `<mod_id>.<type_name>`. All data types will be suggested
- `<id>`{:.m}: The id of the entry to describe. The ids of all entries handled by the data type will be suggested

Example: `/kubejs_tfc describe tfc.fuels tfc:coal`{:.language-command}

## Search

The search command prints a list of data entries which apply to a registry entry. Each entry can be clicked to [describe](#describe) it

The command has the following form:

`/kubejs_tfc search <data_type> <value>`{:.language-command}

- `<data_type>`{:.v}: The data type to retrieve the list from. Will take the form of `<mod_id>.<type_name>`. All data types will be suggested
- `<value>`{:.m}: The registry id of the item/block/fluid/entity type that has a data entry in the data type. All objects that have data associated with them will be suggested

Examples:

- `/kubejs_tfc search tfc.metals tfc:metal/copper`{:.language-command}
- `/kubejs_tfc search tfc.entity_damage_resistances minecraft:creeper`{:.language-command}
- `/kubejs_tfc search tfc.fertilizers tfc:powder/wood_ash`{:.language-command}

## Print World Settings

The print world settings command, as the name would suggest, prints the [TFC Settings](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/world-preset/) of the current level if its chunk generator is TFC-like[^1]

[^1]: Implements TFC's [`ChunkGeneratorExtension`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/ChunkGeneratorExtension.java)

The command has the following form:

`/kubejs_tfc print_world_settings`{:.language-command}

The rock layer settings within the TFC settings will not be printed, due to their tendency to fill the entire message history. Instead, `~~~` will be printed in yellow; this can be clicked to [print them separately](#print-rock-settings)

## Print Rock Settings

The print rock settings command, as one might imagine, prints the [rock layer settings](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/world-preset/#rock-layer-settings) of the current level if its chunk generator is TFC-like[^1]

The command has the following form:

`/kubejs_tfc print_rock_settings`{:.language-command}

## Print Chunk Data

The print chunk data command, as could be intuited, prints the server [`ChunkData`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/chunkdata/ChunkData.java) of the current chunk in a somewhat readable format. Only the information available will be printed. That is to say, if the status is `EMPTY`{:.e}, `CLIENT`{:.e} (somehow), or `INVALID`{:.e} no additional information will be printed; and the surface and aquifer heights will only be printed if the status is `FULL`{:.e}

The command has the following form:

`/kubejs_tfc print_chunk_data`{:.language-command}

## Tree Solver

The tree solver command converts one or more in-world tree templates into trees which properly interact with TFC's logging mechanic, primarily intended for easily making tree structures for [forests]({% link kubejs_tfc/1.20.1/worldgen.md %}#forest)

This command replaces template blocks in-world with the selected log and leaves blocks with the correct block state. There are three template blocks:

- `minecraft:light_blue_stained_glass`: Marks a root position, or the bottom of a tree[^2]. This is the only block that actually needs to be within the scan area. Must have a `minecraft:brown_stained_glass` block immediately above it; and for a `<trunk_size>`{:.v} of `2`{:.v}, it should be in a two by two pattern
- `minecraft:brown_stained_glass`: Marks a log position. The solver climbs upwards from the root marker(s) breadth-first along this block. The solver can connect to any log marker in the 3 by 3 by 3 area centered at the current position, though the lowest order[^3] connection that can be made will be the one used
- `minecraft:green_stained_glass`: Marks a leaf position. Markers beyond the decay range of the leaves block will *not* be replaced

[^2]: While this is the bottom of a tree, there is nothing preventing a branch from 'drooping' to heights lower than that of a root position

[^3]: Order 1: share a face, order 2: share an edge, order 3: share a vertex

All root positions within the scan area will be solved and converted into trees, though the command will fail to run if it encounters a root that does not have the same size as the `<trunk_size>`{:.v} argument or a root marker does not have a log marker above it

The command has the following form:

`/kubejs_tfc tree_solver <trunk_size> <log_block> <leaves_block> <from> <to>`{:.language-command}

- `<trunk_size>`{:.v}: An integer, either `1`{:.v} or `2`{:.v}, the trunk size of the templates to solve
- `<log_block>`{:.m}: A block. Is limited to and will only suggest blocks with TFC's branch direction property. See the [log block type]({% link kubejs_tfc/1.20.1/custom.md %}#log) for custom logs
- `<leaves_block>`{:.s}: A block. Is limited to and will only suggest TFC leaves blocks. See the [leaves block type]({% link kubejs_tfc/1.20.1/custom.md %}#leaves) for custom leaves
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

The inspect 2D noise command displays the selected registered [`Noise2D`{: .language-kube-20 }]({% link kubejs_tfc/1.20.1/type-explanations.md %}#noise2d) in-world with the given parameters. In order to inspect a noise, it must be [registered]({% link kubejs_tfc/1.20.1/bindings/misc.md %}#noise-inspection-registration)

The command has the following form:

`/kubejs_tfc inspect_2d_noise <from> <to> <input_range> <output_range> <noise>`{:.language-command}

- `<from>`{:.v}: A block position, one corner of the display area. Supports relative positions
- `<to>`{:.m}: A block position, the other corner of the display area. Supports relative positions
- `<input_range>`{:.s}: A range[^4], the range which the noise will be sampled over for the x and z axes
- `<output_range>`{:.r}: A range[^4], the expected range for output values of the noise
- `<noise>`{:.nb}: The name of the noise to inspect

[^4]: A pair of numbers

This command fills space in-world by sampling the noise over the `<input_range>`{:.s} in the largest x-z *square* bounded by the `<from>`{:.v} and `<to>`{:.m} positions' x and z coordinates. The value of the noise at the sampled position will then be mapped to a y position within the bounds of `<from>`{:.v} and `<to>`{:.m} and white stained glass will be placed at that position. If the value is beyond the bounds of `<output_range>`{:.r}, then red stained glass will be placed at the edge of the y-boundaries instead. If the value is infinite, then lime stained glass will be placed instead. If the value is [`NaN`](https://en.wikipedia.org/wiki/NaN), then purple stained glass will be placed instead

## Inspect 3D Noise

The inspect 3D noise command displays the selected registered [`Noise3D`{: .language-kube-20 }]({% link kubejs_tfc/1.20.1/type-explanations.md %}#noise3d) in-world with the given parameters. In order to inspect a noise, it must be [registered]({% link kubejs_tfc/1.20.1/bindings/misc.md %}#noise-inspection-registration)

The command has the following form:

`/kubejs_tfc inspect_3d_noise <from> <to> <input_range> <output_range> <noise> [<y_value>]`{:.language-command}

- `<from>`{:.v}: A block position, one corner of the display area. Supports relative positions
- `<to>`{:.m}: A block position, the other corner of the display area. Supports relative positions
- `<input_range>`{:.s}: A range[^4], the range which the noise will be sampled over for the x, y, and z axes
- `<output_range>`{:.r}: A range[^4], the expected range for output values of the noise
- `<noise>`{:.nb}: The name of the noise to inspect
- `[<y_value>]`{:.o}: A number. If present, the 3D noise is treated as a 2D noise by only sampling it at the given y-value and displayed in-world as if it were a 2D noise

This command fills space in-world by sampling the noise over the `<input_range>`{:.s} in the largest x-y-z *cube* bounded by the `<from>`{:.v} and `<to>`{:.m} positions' x, y, and z coordinates. The value of the noise at the sampled position will then be mapped onto a gradient of stained glass, as described below, and the block will be placed at that position. If the value is beyond the bounds of `<output_range>`{:.r}, then the position will be filled with air

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
