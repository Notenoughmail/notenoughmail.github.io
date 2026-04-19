---
title: Remove Spawn Costs
anchor: remove-spawn-costs
type: remove_spawn_costs
name: soul_skeletons
cat:
    - worldjs
    - 1.21.1
    - biome_mod
example:
    - ".biomes('minecraft:soul_sand_valley')"
    - ".entityTypes('minecraft:skeleton')"
---

- [[ biomes ]]
- `.entityTypes(entityTypes: HolderSet<EntityType<?>>)`{: .language-kube-21 #{{ page.anchor }}-entity-types }: The entity(s) to remove spawn costs for
