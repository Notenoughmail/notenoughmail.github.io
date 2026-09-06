---
title: Entity Damage Resistance
anchor: entity-damage-resistance
cat:
    - kubejs_tfc
    - 1.21.1
    - data
desc: Add an entity damage resistance
method: entityDamageResistance
sig: |-
    entity: TagKey<EntityType<?>>,
    resistance: {
        piercing?: number,
        slashing?: number,
        crushing?: number
    },
    id?: ResourceLocation
example: |-
    'minecraft:fish',
    {
        piercing: -800
    },
    'fish:get_pierced'
---

- 1st argument: The entities the resistances applies to
- 2nd argument: The resistance data, a map of types to values
    - `piercing?: number`{:.language-kube-21}: The piercing resistance
        - Negative values make the entity weak to piercing damage
        - [[ def_0 ]]
    - `slashing?: number`{:.language-kube-21}: The slashing resistance
        - Negative values make the entity weak to slashing damage
        - [[ def_0 ]]
    - `crushing?: number`{:.language-kube-21}: The crushing resistance
        - Negative values make the entity weak to crushing damage
        - [[ def_0 ]]
- *Optional 3rd argument*: A `ResourceLocation`{:.language-kube-21}, the id of the resistance
