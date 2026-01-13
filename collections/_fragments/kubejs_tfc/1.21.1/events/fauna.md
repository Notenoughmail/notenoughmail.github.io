---
type: startup
title: Fauna Spawns
anchor: fauna-spawns
cat:
    - kubejs_tfc
    - 1.21.1
    - event
example:
    - event.replace('minecraft:pig', event.onGround(), 'world_surface_wg')
    - event.and('minecraft:cow')
---

This event allows for registering a [data driven]({% link kubejs_tfc/1.21.1/data.md %}#fauna) spawn condition of entity types

{: .warning #{{ page.anchor }}-warning }
> This event functions by wrapping the relevant [NeoForge event](https://github.com/neoforged/NeoForge/blob/1.21.1/src/main/java/net/neoforged/neoforge/event/entity/RegisterSpawnPlacementsEvent.java). Typically, this does not cause issues iff all other mods use the event like they're supposed to. Unfortunately, multiloader mods (and Fabric mods via Connector) are unlikely to use NeoForge's event (or the relevant [Architectury event](https://github.com/architectury/architectury-api/blob/1.21/common/src/main/java/dev/architectury/registry/level/entity/SpawnPlacementsRegistry.java) that delegates to Neo's), leading to startup crashes when using this event for entities from said mods
>
> In such cases, please open an issue on the mod's page informing them of the proper way to register spawn placements. If the issue is with a Fabric mod loaded via Connector, a resolution to the issue is unlikely

{: #{{ page.anchor }}-methods }

- `.noRestrictions(): SpawnPlacementType`{: .language-kube-21 #{{ page.anchor }}-no-restrictions }: Get the no restrictions spawn placement type
- `.inWater(): SpawnPlacementType`{: .language-kube-21 #{{ page.anchor }}-in-water }: Get the in water spawn placement type
- `.inLava(): SpawnPlacementType`{: .language-kube-21 #{{ page.anchor }}-in-lava }: Get the in lava spawn placement type
- `.onGround(): SpawnPlacementType`{: .language-kube-21 #{{ page.anchor }}-on-ground }: Get the on ground spawn placement type
- `.replace(entityType: EntityType<? extends Entity>, suffix?: String, placementType: SpawnPlacementType, heightmap: Heightmap$Types): void`{: .language-kube-21 #{{ page.anchor }}-replace }: Registers a fauna-based spawn placement, completely replacing any existing spawn placements
    - `entityType: EntityType<? extends Entity>`{:.language-kube-21}: The entity type to register the spawn for
    - `suffix?: String`{:.language-kube-21}: A string, a suffix to add to the id of the fauna data id. Optional
    - `placementType: SpawnPlacementType`{:.language-kube-21}: A spawn placement type, a pre-filter on a position before the fauna predicate
    - `heightMap: Heightmap$Types`{:.language-kube-21}: The heightmap to spawn the entity with
- `.and(entityType: EntityType<? extends Entity>, suffix?: String)`{: .language-kube-21 #{{ page.anchor }}-and }: Registers a fauna-based spawn placement, ANDing its requirements with any existing spawn placements
    - `entityType: EntityType<? extends Entity>`{:.language-kube-21}: The entity type to register the spawn for
    - `suffix?: String`{:.language-kube-21}: A string, a suffix to add to the id of the fauna data id. Optional
- `.or(entityType: EntityType<? extends Entity>, suffix?: String)`{: .language-kube-21 #{{ page.anchor }}-or }: Registers a fauna-based spawn placement, ORing its requirements with any existing spawn placements
    - `entityType: EntityType<? extends Entity>`{:.language-kube-21}: The entity type to register the spawn for
    - `suffix?: String`{:.language-kube-21}: A string, a suffix to add to the id of the fauna data id. Optional
