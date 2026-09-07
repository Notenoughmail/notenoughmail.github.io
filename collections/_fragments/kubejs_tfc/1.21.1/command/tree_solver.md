---
title: Tree Solver
anchor: tree-solver
cat:
    - kubejs_tfc
    - 1.21.1
    - command
desc: "'Solving' a tree template for use in TFC tree structures & configured features"
form: tree_solver <trunk_size> <log_block> <leaves_block> <from> <to>
args:
    - '`<trunk_size>`[[1]]: An integer, either `1`[[1]] or `2`[[1]], the trunk size of the templates to solve'
    - "`<log_block>`[[2]]: A block. Is limited to and will only suggest blocks with TFC's branch direction property. See the [log block type]({% link kubejs_tfc/1.21.1/blocks.md %}#log) for custom logs"
    - '`<leaves_block>`[[3]]: A block. Is limited to and will only suggest TFC leaves blocks. See the [leaves block type]({% link kubejs_tfc/1.21.1/blocks.md %}#leaves) for custom leaves'
    - '`<from>`[[4]]: A block position, one corner of the scan area. Supports relative positions'
    - '`<to>`[[5]]: A block position, the other corner of the scan area. Supports relative positions'
exp: |
    <p markdown="1">Converts one or more in-world tree templates into trees which properly interact with TFC's logging mechanic, primarily intended for easily making tree structures for [forests]({% link kubejs_tfc/1.21.1/worldgen.md %}#forest)

    This command replaces template blocks in-world with the selected log and leaves blocks in the correct block state. There are three template blocks:

    - `minecraft:light_blue_stained_glass`: Marks a root position, or the 'origin' of a tree. This is the only block *required* to be within the scan area. Must have a `minecraft:brown_stained_glass` block immediately above it; and for a `<trunk_size>`[[1]] of `2`[[1]], it should be in a two by two pattern
    - `minecraft:brown_stained_glass`: Marks a log position. The solver climbs upwards from the root marker(s) breadth-first along this block. The solver will connect to any log marker in the 3 by 3 by 3 area centered at the current position, though the lowest order[[ fn_order ]] connection that is valid will be used
    - `minecraft:green_stained_glass`: Marks a leaf position. Markers beyond the decay range of the leaves block will *not* be replaced
    
    All root positions within the scan area will be solved and converted into trees, though the command will fail to run if it encounters a root that does not have the same size as the `<trunk_size>`[[1]] argument or a root marker does not have a log marker above it</p>
---

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
