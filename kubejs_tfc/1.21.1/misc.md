---
layout: page
title: Miscellaneous Features
permalink: /kubejs_tfc/1.21.1/misc/
parent: 1.21.1
grand_parent: KubeJS TFC
desc: Collated minor features without their own pages
---

# Miscellaneous Features

This page is for features which don't warrant their own page. The link anchors on this page are not guaranteed to be stable due to the potential for subjects to be moved/merged as KubeJS TFC develops

- [Configuration](#configuration)
- [Recipe Schemas](#recipe-schemas)

## Configuration

The `/kubejs/config/tfc.json`{:.language-fs} file of your installation contains KubeJS TFC's configuration properties. Four boolean properties exist, controlling certain logging events

- `debug`: If a debug message for certain events should be add to the log. Defaults to `false`{:.p}
- `insert_into_console`: If TFC's self tests and data manager errors and warning should be inserted into KubeJS's server console. Defaults to `true`{:.p}
- `deduplicate_self_test_warnings`: If TFC's self test warnings should be removed from the MC log. Defaults to `true`{:.p}
- `deduplicate_data_manager_warnings`: If data manager warnings should be removed from the MC log. Defaults to `true`{:.p}

## Recipe Schemas

KubeJS primarily handles recipe additions through *recipe schemas*, which are mostly made up of *recipe components*, effectively a mirror to a recipe type's codec. It is possible to add new schemas through datapacks

{: .notice }
> This is not meant to be a tutorial for creation of recipe schemas, merely an acknowledgement of the additions KubeJS TFC provides for TFC types

{: #recipe-components }

### Components

KubeJS TFC adds several component types

- `kubejs_tfc:isp`: An [`ItemStackProvider`]({% link kubejs_tfc/1.21.1/type-explanations.md %}#item-stack-provider)
- `kubejs_tfc:optional_isp`: An optional [`ItemStackProvider`]({% link kubejs_tfc/1.21.1/type-explanations.md %}#item-stack-provider) which supports serializing empty ISPs
- `kubejs_tfc:block_ingredient`: A [`BlockIngredient`]({% link kubejs_tfc/1.21.1/bindings/ingredient.md %}#block-ingredient)
- `kubejs_tfc:alloy_range`: An `AlloyRange`, the components of [alloying recipes]({% link kubejs_tfc/1.21.1/recipes.md %}#alloy)
- `kubejs_tfc:forge_rule`: A `ForgeRule`{:.e}, for [anvil recipes]({% link kubejs_tfc/1.21.1/recipes.md %}#anvil)
- `kubejs_tfc:welding_bonus_behavior`: A [welding]({% link kubejs_tfc/1.21.1/recipes.md %}#welding) `BonusBehavior`{:.e}
- `kubejs_tfc:fixed_size_pattern`: A string pattern grid with a fixed size. Used for [sewing recipes]({% link kubejs_tfc/1.21.1/recipes.md %}#sewing). Has two additional fields
    - `width`: An integer, the width of each pattern row
    - `height`: An integer, the number of pattern rows
- `kubejs_tfc:block_state`: A variation of the default block state component that will properly parse inline block states from json

{: #recipe-functions }

### Functions

KubeJS TFC adds a single function type

- `kubejs_tfc:multi_set`: Creates a method on the recipe type which can set the given keys. Has one additional field
    - `keys`: A list of strings, the recipe keys the generated function will have parameters for and set when calling
