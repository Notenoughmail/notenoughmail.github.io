---
layout: page
title: Miscellaneous Features
permalink: /kubejs_tfc/1.20.1/misc/
parent: 1.20.1
grand_parent: KubeJS TFC
---

# Miscellaneous Features

This page is for features which don't deserve their own page and/or don't fit into another page

- [Recipe Components](#recipe-components)
- [Configuration](#configuration)
- [Commands](#commands)

## Recipe Components

KubeJS handles recipes through *recipe schemas*, which are made up of *recipe components*, essentially a mirror to a recipe type's json (de)serialization process. For the most part recipe schemas are made through addons, but KubeJS does have a startup event for registering custom recipe schemas in your scripts.

{: .notice }
This is *not* meant to be a tutorial on how to use that event, merely an acknowledgement of the recipe components KubeJS TFC adds to the event

### Provided Components

KubeJS TFC adds 6 recipe component types

- `tfc:outputItemStackProvider`: An output [ItemProviderComponent](https://github.com/Notenoughmail/KubeJS-TFC/blob/1.20.1/src/main/java/com/notenoughmail/kubejs_tfc/recipe/component/ItemProviderComponent.java), used by recipes which support [ISP]({% link kubejs_tfc/1.20.1/bindings/isp.md %}) outputs
- `tfc:otherItemStackProvider`: An [ItemProviderComponent](https://github.com/Notenoughmail/KubeJS-TFC/blob/1.20.1/src/main/java/com/notenoughmail/kubejs_tfc/recipe/component/ItemProviderComponent.java), used by recipes which support [ISP]({% link kubejs_tfc/1.20.1/bindings/isp.md %}) intermediates
- `tfc:fluidIngredient`: A [FluidIngredientComponent](https://github.com/Notenoughmail/KubeJS-TFC/blob/1.20.1/src/main/java/com/notenoughmail/kubejs_tfc/recipe/component/FluidIngredientComponent.java), used by recipes which support [fluid ingredients]({% link kubejs_tfc/1.20.1/bindings.md %}#fluid-ingredient)
- `tfc:fluidStackIngredient`: A [FluidStackIngredientComponent](https://github.com/Notenoughmail/KubeJS-TFC/blob/1.20.1/src/main/java/com/notenoughmail/kubejs_tfc/recipe/component/FluidIngredientComponent.java), used by recipes which support [fluid stack ingredients]({% link kubejs_tfc/1.20.1/bindings.md %}#fluid-stack-ingredient)
- `tfc:alloyPart`: An [AlloyPartComponent](https://github.com/Notenoughmail/KubeJS-TFC/blob/1.20.1/src/main/java/com/notenoughmail/kubejs_tfc/recipe/component/AlloyPartComponent.java), used by alloy recipes for their [alloy parts]({% link kubejs_tfc/1.20.1/bindings.md %}#alloy-part)
- `tfc:blockIngredient`: A [BlockIngredientComponent](https://github.com/Notenoughmail/KubeJS-TFC/blob/1.20.1/src/main/java/com/notenoughmail/kubejs_tfc/recipe/component/BlockIngredientComponent.java), used by recipes which support [block ingredients]({% link kubejs_tfc/1.20.1/bindings.md %}#block-ingredient)

## Configuration

In KubeJS's `dev.properties` file there is an option for `debugInfo`, if set to `true`{:.p}, KubeJS TFC will print various debug info to the log

Additionally, in the `dev.properties` file

- `tfc/insertSelfTestsIntoConsole`: If `true`{:.p}, TFC's self test warnings will be inserted into the KubeJS console. Allows for warnings about items/fluids missing tags for proper recipe functionality to appear on world load. Defaults to `true`{:.p}.
- `tfc/deduplicateConsoleErrors`: If `true`{:.p}, any TFC self test warnings that are inserted into Kube's console will *not* be written to the normal log/console. Only has an effect when `tfc/insertSelfTestsIntoConsole` is `true`{:.p}. Defaults to `true`{:.p}.

## Commands

KubeJS TFC adds several commands used for investigating some of TFC's (and some addons) data. They all require level 3 or higher to use.

### List IDs

The `/kubejs_tfc list_ids`{:.language-command} command has a single argument, a data type, all available options will be suggested

Using this command will print a list the ids of data files handled by that data type to the chat

Example: `/kubejs_tfc list_ids tfc.fuels`{:.language-command}

### Describe

The `/kubejs_tfc describe`{:.language-command} command has two arguments: a data type and a resource location, the id of the data value to describe

Using this command will print a formatted description of the requested data value to the chat

Example: `/kubejs_tfc describe tfc.fuels tfc:coal`{:.language-command}

### Search

The `/kubejs_tfc search`{:.language-command} command has two arguments: a data type and a resource location, the registry id to search for in the data type

Using the command will print a list of data definitions which apply to the given item/block/fluid/entity type, each entry can be clicked on to describe it via `/kubejs_tfc describe`{:.language-command}

Examples: `/kubejs_tfc search tfc.metals tfc:metal/copper`{:.language-command}, `/kubejs_tfc search tfc.entity_damage_resistances minecraft:creeper`{:.language-command}, `/kubejs_tfc search tfc.fertilizers tfc:powder/wood_ash`{:.language-command}

### Print World Settings

The `/kubejs_tfc print_world_settings`{:.language-command} command has no arguments.

Using the command will print out the [TFC Settings](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/world-preset/) of the current level if its generator is TFC-like (implements TFC's `ChunkGeneratorExtension`).

The rock layer settings will not be printed, due to them usually filling the entirety of the message history itself. Instead, `~~~` will be printed in its place with a click interaction to run the command that [prints rock settings](#print-rock-settings).

### Print Rock Settings

The `/kubejs_tfc print_rock_settings`{:.language-command} command has no arguments.

Using this command will print out the [rock layer settings](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/world-preset/#rock-layer-settings) of the current level if its generator is TFC-like (implements TFC's `ChunkGeneratorExtension`).

### Print Chunk Data

The `/kubejs_tfc print_chunk_data`{:.language-command} command has no arguments.

Using the command will print out the server [ChunkData](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/chunkdata/ChunkData.java) of the current chunk in a somewhat readable format. Only the information available will be printed. That is to say, if the status is `EMPTY`{:.e}, `CLIENT`{:.e}, or `INVALID`{:.e}, no additional information will be printed; and the surface and aquifer heights will only be printed if the status is `FULL`{:.e}.

### Tree Solver

The `/kubejs_tfc tree_solver`{:.language-command} command has five arguments

- `trunk_size`{:.v}: Either `1`{:.v} or `2`{:.v}, the size of the tree trunk to solve for within the scan area
- `log_block`{:.m}: The block to use as the log of the tree. Is limited to and will only suggest blocks with TFC's branch direction state property. See the [log block type]({% link kubejs_tfc/1.20.1/custom.md %}#log) for custom logs
- `leaves_block`{:.s}: The block to use as the leaves of the tree. Is limited to and will only suggest TFC [leaves]({% link kubejs_tfc/1.20.1/custom.md %}#leaves) blocks. See the [leaves block type]({% link kubejs_tfc/1.20.1/custom.md %}#leaves) for custom leaves
- `from`{:.r}: A block pos, one corner of the scan area. Supports relative positions
- `to`{:.f}: A block pos, the other corner of the scan area. Supports relative positions

This command replaces blocks within the world for use in creating tree structures which work with TFC's tree logging mechanic. This is done through the use of marker blocks which are replaced with the correct block and state

- `minecraft:light_blue_stained_glass`: Marks a root position, or the bottom of a tree[^1]. This is the only block that actually needs to be within the scan area. Must have a `minecraft:brown_stained_glass` immediately above; and for trunk size `2`{:.n}, should be in a two by two pattern
- `minecraft:brown_stained_glass`: Marks a log position. The solver climbs upwards from the root marker breadth-first along brown glass. The solver can connect to any log marker in the 3 by 3 by 3 area centered at the current position, though blocks prefer the lowest order connection they can make (order 1: share a face, order 2: share an edge, order 3: share a vertex)
- `minecraft:green_stained_glass`: Marks where leaves will go.

[^1]: While this is the bottom of a tree, it does not prevent branches 'drooping' to heights lower than that of the root position

All root positions within the scan area will will be solved and converted into trees, though errors will occur if a root does not have the same size as the `trunk_size`{:.v} argument

<details>
    <summary>As an example</summary>
    <img src="/assets/images/kjs_tfc/tree_solver/pre_solve.png" alt="A tree template using the marker blocks. The tree solver command is typed in the chat box" class="center-image">
    <img src="/assets/images/kjs_tfc/tree_solver/post_solve.png" alt="A tree, as solved fro mthe template in the previous image" class="center-image">
</details>

<details>
    <summary>It can also handle rather strange forms</summary>
    <img src="/assets/images/kjs_tfc/tree_solver/pre_solve_dumb.png" alt="A tree template, though the log markers are in a large brick form" class="center-image">
    <img src="/assets/images/kjs_tfc/tree_solver/post_solve_dumb.png" alt="The solved tree of the previous template." class="center-image">
</details>
