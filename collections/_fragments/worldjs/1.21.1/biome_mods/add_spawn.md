---
title: Add Spawns
anchor: add-spawns
type: add_spawns
name: add_zombies
cat:
    - worldjs
    - 1.21.1
    - biome_mod
example:
    - ".biomes('#kubejs:needs_more_zombies')"
    - ".spawns(["
    - "    {"
    - "        entityType: 'minecraft:zombie',"
    - "        weight: 3,"
    - "        minCount: 1,"
    - "        maxCount: 5"
    - "    },"
    - "    {"
    - "        entityType: 'minecraft:husk',"
    - "        weight: 2,"
    - "        minCount: 2,"
    - "        maxCount: 3"
    - "    }"
    - "])"
---

- [[ biomes ]]
- `.spawns(spawns: List<Spawn>)`{: .language-kube-21 #{{ page.anchor }}-spawns }: Set the spawn(s) to add to the biome(s). Accepts a list of `Spawn`, which can be created as a map of parameters to values
    - `entityType: EntityType<?>`{:.language-kube-21}: The entity type to spawn
    - `weight: int`{:.language-kube-21}: The spawn weight
    - `minCount: int`{:.language-kube-21}: The minimum group size
    - `maxCount: int`{:.language-kube-21}: The maximum group size
