---
layout: page
title: Data
permalink: /kubejs_tfc/1.21.1/data/
parent: 1.21.1
grand_parent: KubeJS TFC
desc: Documentation on Creating TFC's data types in scripts
---

# Data

TFC's data types can be created through the `TFCEvents.data` event in the `server_scripts` folder

- [Climate Range](#climate-range)
- [Deposit](#deposit)
- [Drinkable](#drinkable)
- [Entity Damage Resistance](#entity-damage-resistance)
- [Fauna](#fauna)
- [Fertilizer](#fertilizer)
- [Fluid Heat](#fluid-heat)
- [Food](#food)
- [Fuel](#fuel)
- [Heat](#heat)
- [Item Damage Resistance](#item-damage-resistance)
- [Item Size](#item-size)
- [Knapping Type](#knapping-type)
- [Lamp Fuel](#lamp-fuel)
- [Support](#support)

{: .notice #general-notice }
> Most of these methods have an optional final argument which specifies the id of the virtual json file the data will be placed in. For instance, if an id of `fish:get_pierced` was used for an entity damage resistance, the resulting file would effectively be at `data/fish/tfc/entity_damage_restances/get_pierced.json`{: .language-fs }; the `tfc/<data_type>`{: .language-fs } folders do not need to be provided
>
> If no id is provided, one will automatically be generated with the namespace `kubejs` and, unless other wise noted, a path matching the base 16 hash of the (usually) 1st argument's `.toString()`{: .language-kube-21 } value
>
> Additionally, for data types that use ingredients, if there are multiple definitions with the same valid item/block/fluid/entity, then there is no guarentee as to which will take precedence. This situation can be confirmed by using the [search command]({% link kubejs_tfc/1.21.1/commands.md %}#search) and fixed by either overriding the exisint definition or changing the entries in the tag it uses

## Climate Range

## Deposit

## Drinkable

## Entity Damage Resistance

## Fauna

## Fertilizer

## Fluid Heat

## Food

## Fuel

## Heat

## Item Damage Resistance

## Item Size

## Knapping Type

## Lamp Fuel

## Support
