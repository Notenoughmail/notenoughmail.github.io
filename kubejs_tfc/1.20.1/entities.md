---
title: Entities
layout: page
permalink: /kubejs_tfc/1.20.1/entities/
parent: 1.20.1
grand_parent: KubeJS TFC
---

# Entities

If [EntityJS](https://modrinth.com/mod/entityjs) is installed, some TFC entity types will be available

- [Mammal](#mammal)
- [Oviparous](#oviparous)
- [Wooly](#wooly)
- [Diary](#dairy)

In addition, there is a new method, `withFaunaDefinition` for all living entity builders that registers a [fauna](../data#fauna) definition for the entity. This method takes a `SpawnPlacements$Type` and a `Heightmap$Types` and returns the builder

```js
StartupEvents.register('entity_type', event => {
    event.create('my_entity', 'tfc:mammal')
        .withFaunaDefinition('on_ground', 'world_surface_wg')
})
```

## Mammal

Creates a new mammal entity type

Inherits the methods of animal builders

**Type**: `tfc:mammal`

### Extra methods

- `.configs(configBuilder: Consumer<MammalConfigBuilder>)`: Sets the default values of the type's config
    - `gestationDays(i: number)`: Sets the number of days the mammal will gestate young for
    - `childCount(i: number)`: Sets the number of children the mammal will have
    - `animalName(name: string)`: Sets the name of the mammal in hte config file
    - `daysToAdult(i: number)`: Sets the number of days the mammal will take to reach adulthood
    - `uses(i: number)`: Sets the number of uses the mammal has
    - `maxFamiliarity(d: number)`: Sets the maximum familiarity, in the range [0, 1], that an adult mammal may be brought up to
    - `eastRottenFood(eats: boolean)`: Sets if the animal will eat rotten food
- `foodTag(tag: string)`: Sets the item tag the mammal will consider food
- `sounds(ambient: string, death: string, hurt: string, step: string, attack: string, sleep: string)`: Accepts the registry ids of and sets the sound events the entity uses, `attack`, and `sleep` may be null

### Example

```js
StartupEvents.registry('entity_type', event => {
    event.create('my_mammal', 'tfc:mammal')
        .foodTag('kubejs:my_very_special_food_type_only_for_my_mammal')
})
```

## Oviparous

Creates a new oviparous entity type

Inherits the methods of animal builders

**Type**: `tfc:oviparous`

### Extra Methods

- `.crows(crows: boolean)`: If the animal should crow every so often, defaults to `false`
- `.productReadyMessage(message: Component)`: Sets the message displayed when the animal has a product ready
- `.configs(configBuilder: Consumer<OviparousConfigBuilder>)`: Sets the default values of the type's config
    - `hatchDays(i: number)`: Sets the number of days the animal will take to hatch
    - `animalName(name: string)`: Sets the name of the animal in hte config file
    - `daysToAdult(i: number)`: Sets the number of days the animal will take to reach adulthood
    - `uses(i: number)`: Sets the number of uses the animal has
    - `maxFamiliarity(d: number)`: Sets the maximum familiarity, in the range [0, 1], that an adult animal may be brought up to
    - `eastRottenFood(eats: boolean)`: Sets if the animal will eat rotten food
- `foodTag(tag: string)`: Sets the item tag the mammal will consider food
- `sounds(ambient: string, death: string, hurt: string, step: string, attack: string, sleep: string)`: Accepts the registry ids of and sets the sound events the entity uses, `attack`, and `sleep` may be null

### Example

```js
StartupEvents.registry('entity_type', event => {
    event.create('oviparous_example', 'tfc:oviparous')
        .crows(true)
        .productReadyMessage("Egg's Ready!")
        .configs(config => {
            config.hatchDays(5)
            config.uses(56)
        })
})
```

## Wooly

Creates a new wooly animal entity type

Inherits the methods of animal builders

**Type**: `tfc:wooly_animal`

### Extra Methods

- `.configs(configBuilder: Consumer<ProducingConfigBuilder>)`: Sets the default values of the type's config
    - `ticksToProduce(i: number)`: Sets the number of ticks the animal will take to create produce
    - `produceFamiliarity(d: number)`: Sets the familiarity, in the range [0, 1], that is required for the animal to have its product harvested
    - `animalName(name: string)`: Sets the name of the animal in hte config file
    - `daysToAdult(i: number)`: Sets the number of days the animal will take to reach adulthood
    - `uses(i: number)`: Sets the number of uses the animal has
    - `maxFamiliarity(d: number)`: Sets the maximum familiarity, in the range [0, 1], that an adult animal may be brought up to
    - `eastRottenFood(eats: boolean)`: Sets if the animal will eat rotten food
- `foodTag(tag: string)`: Sets the item tag the mammal will consider food
- `sounds(ambient: string, death: string, hurt: string, step: string, attack: string, sleep: string)`: Accepts the registry ids of and sets the sound events the entity uses, `attack`, and `sleep` may be null

### Example

```js
StartupEvents.registry('entity_type', event => {
    event.create('my_wooly_animal', 'tfc:wooly_animal')
        .sounds('kubejs:wooly.ambient', 'kubejs:wooly.death', 'kubejs:wooly.hurt', 'kubejs:wooly.step', null, null)
})
```

## Dairy

Create a new dairy animal entity type

Inherits the methods of animal builders

**Type**: `tfc:dairy_animal`

### Extra Methods

- `.configs(configBuilder: Consumer<ProducingConfigBuilder>)`: Sets the default values of the type's config
    - `ticksToProduce(i: number)`: Sets the number of ticks the animal will take to create produce
    - `produceFamiliarity(d: number)`: Sets the familiarity, in the range [0, 1], that is required for the animal to have its product harvested
    - `animalName(name: string)`: Sets the name of the animal in hte config file
    - `daysToAdult(i: number)`: Sets the number of days the animal will take to reach adulthood
    - `uses(i: number)`: Sets the number of uses the animal has
    - `maxFamiliarity(d: number)`: Sets the maximum familiarity, in the range [0, 1], that an adult animal may be brought up to
    - `eastRottenFood(eats: boolean)`: Sets if the animal will eat rotten food
- `foodTag(tag: string)`: Sets the item tag the mammal will consider food
- `sounds(ambient: string, death: string, hurt: string, step: string, attack: string, sleep: string)`: Accepts the registry ids of and sets the sound events the entity uses, `attack`, and `sleep` may be null

### Example

```js
StartupEvents.registry('entity_type', event => {
    event.create('my_dairy_animal', 'tfc:dairy_animal')
        .configs(config => {
            config.eatsRottenFood(true)
            config.daysToAdult(12)
        })
})
```
