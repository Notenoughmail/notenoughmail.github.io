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
    resistance: {
        entity: TagKey<EntityType<?>>,
        damages?: {
            piercing?: number,
            slashing?: number,
            crushing?: number
        }
    },
    id?: ResourceLocation
example: |-
    {
        entity: 'minecraft:fish',
        damages: {
            piercing: -800
        }
    },
    'fish:get_pierced'
---

- 1st argument: The entity resistance data, a map of parameters to values:
    - `entity: TagKey<EntityType<?>>`{:.language-kube-21}: The entities the resistance applies to
    - `damages?: PhysicalDamage`{:.language-kube-21}: Th resistance values, a map of types to values
        - `piercing?: number`{:.language-kube-21}: The piercing resistance
            - Negative values make the entity weak to piercing damage
            - [[ def_0 ]]
        - `slashing?: number`{:.language-kube-21}: The slashing resistance
            - Negative values make the entity weak to slashing damage
            - [[ def_0 ]]
        - `crushing?: number`{:.language-kube-21}: The crushing resistance
            - Negative values make the entity weak to crushing damage
            - [[ def_0 ]]
- *Optional 2nd argument*: A `ResourceLocation`{:.language-kube-21}, the id of the resistance
