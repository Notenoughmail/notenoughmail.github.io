---
title: Remove Spawns
anchor: remove-spawns
type: remove_spawns
name: no_zombies
cat:
    - worldjs
    - 1.21.1
    - biome_mod
example:
    - ".biomes('#kubejs:no_zombies')"
    - ".entityTypes('#kubejs:zombies')"
---

- [[ biomes ]]
- `.entityTypes(entityTypes: HolderSet<EntityType<?>>)`{: .language-kube-21 #{{ page.anchor }}-entity-types }: Set the entity(s) to remove spawns for
