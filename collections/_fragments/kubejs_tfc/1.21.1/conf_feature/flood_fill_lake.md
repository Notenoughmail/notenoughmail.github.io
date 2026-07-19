---
title: Flood Fill Lake
anchor: flood-fill-lake
type: flood_fill_lake
wiki_link: https://terrafirmacraft.github.io/Documentation/1.21.x/worldgen/features/#flood-fill-lake
sort_pos: f
cat:
    - kubejs_tfc
    - 1.21.1
    - conf_feature
example: |-
    // TODO
---

[[ base ]]

- `.fill(state: BlockState)`{: .language-kube-21 #{{ page.anchor }}-fill }: The state to fill the lake with
    - Defaults to `'minecraft:water'`{:.s}
- `.replaceFluids(fluids: List<Fluid>)`{: .language-kube-21 #{{ page.anchor }}-replace-fluids }: The fluids to replace when encountered by a lake
    - Defaults to `[]`
- `.allowOverfill()`{: .language-kube-21 #{{ page.anchor }}-allow-overfill }: Allows the lake to fill a potential basin upwards from the starting position as well as downwards
