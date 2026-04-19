---
title: Add Spawn Costs
anchor: add-spawn-costs
type: add_spawn_costs
name: add_skeletons
cat:
    - worldjs
    - 1.21.1
    - biome_mod
example:
    - ".biomes('#kubejs:add_skeletons')"
    - ".entityTypes(["
    - "    'minecraft:skeleton',"
    - "    'minecraft:stray'"
    - "])"
    - ".cost(12, 0.7)"
---

- [[ biomes ]]
- `.entityTypes(entityTypes: HolderSet<EntityType<?>>)`{: .language-kube-21 #{{ page.anchor }}-entity-types }: The entity type(s) to add a spawn cost for
- `.cost(spawnBudget: number, costPerSpawn: number)`{: .language-kube-21 #{{ page.anchor }}-cost }: Set the cost
    - `spawnBudget: number`{:.language-kube-21}: The total energy budget for spawning entities
    - `costPerSpawn: number`{:.language-kube-21}: The amount of charge each entity takes up from the budget
