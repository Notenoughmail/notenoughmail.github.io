---
layout: page
title: Custom Blocks
permalink: /kubejs_tfc/1.21.1/blocks/
parent: 1.21.1
grand_parent: KubeJS TFC
desc: Custom block types
fragment-filter:
    - kubejs_tfc
    - 1.21.1
    - block
---

# Custom Blocks

KubeJS TFC allows for the creation of some of TFC's block types

{% assign blocks = site.fragments | multi_where: 'cat', page.fragment-filter | clean_fragments | sort: 'title' %}

{% for block in blocks %}

- [{{ block.title }}](#{{ block.anchor }}) -- `{{ block.type }}`

{% endfor %}

It also provides a few block entity attachment types

- [Inventory](#inventory) -- `tfc:inventory`
- [Sealable Inventory](#sealable-inventory) -- `tfc:sealable_inventory`
- [Heat Consumer](#heat-consumer) -- `tfc:heat_consumer`
- [Calendar Tracking](#calendar-tracking) -- `tfc:calendar_tracking`

---

{% for block in blocks %}

{: #{{ block.anchor }}}

## {{ block.title }}

**Type**: `{{ block.type }}`

{{ block.clean }}

{: #{{ block.anchor }}-example }

### Example

```js-21
StartupEvents.registry('block', event => {
    event.create('{{ block | get_or_default: 'name', 'anchor' }}', '{{ block.type }}'){% for ex in block.example %}
        {{ ex }}{% endfor %}
})
```

{% endfor %}

---

### Extended Properties

Some of TFC's blocks have extended properties which offer greater definition of their behavior. builders for such blocks have a method that takes a consumer with the following methods

- `.flammable(flammability: int, fireSpreadSpeed: int)`{: .language-kube-21 #extended-properties-flammable}: Set the block's burning properties
    - `flammability: int`{:.language-kube-21}: How fast the block burns, higher values means a shorter lifetime
    - `fireSpreadSpeed: int`{:.language-kube-21}: How much fire spreads for the block, higher values means more spreading
- `.flammableLikeLogs()`{: .language-kube-21 #extended-properties-flammable-like-logs }: Set the block to burn like logs
- `.flammableLikePlanks()`{: .language-kube-21 #extended-properties-flammable-like-planks }: Set the block to burn like planks
- `.flammableLikeLeaves()`{: .language-kube-21 #extended-properties-flammable-like-leaves }: Set the block to burn like leaves
- `.flammableLikeWool()`{: .language-kube-21 #extended-properties-flammable-like-wool }: Set the block to burn like wool
- `.pathType(type: PathType)`{: .language-kube-21 #extended-properties-path-type }: Set the block's pathing type, used by mobs to determine if they want to walk over the block or not
- `.enchantPower(power: number)`{: .language-kube-21 #extended-properties-enchant-power-0 }: Set the block's enchanting power
- `.enchantPower(powerGetter: Function<BlockState, number>)`{: .language-kube-21 #extended-properties-enchant-power-1 }: Set the block's enchant power per-block state
- `.cloneEmpty()`{: .language-kube-21 #extended-properties-clone-empty }: Set the block's clone item (creative mode middle click) to empty
- `.cloneItem(cloneItemStack: @Nullable Item)`{: .language-kube-21 #extended-properties-clone-item }: Set the block's clone item (creative mode middle click). Passing `null`{:.p} will make the block the clone stack, which is the default
- `.noCollission()`{: .language-kube-21 #extended-properties-no-collision }: Set the block as having no collision
- `.noOcclusion()`{: .language-kube-21 #extended-properties-no-occlusion }: Set the block as non-occluding
- `.friction(friction: number)`{: .language-kube-21 #extended-properties-friction }: Set the block's friction
- `.speedFactor(speedFactor: number)`{: .language-kube-21 #extended-properties-speed-factor }: Set the block's speed factor
- `.jumpFactor(jumpFactor: number)`{: .language-kube-21 #extended-properties-jump-factor }: Set the block's jump factor
- `.sound(sound: SoundType)`{: .language-kube-21 #extended-properties-sound }: Set the sound type of the block
- `.lightLevel(lightLevel: Function<BlockState, int>)`{: .language-kube-21 #extended-properties-light-level }: Set the light level of the block per-block state
- `.strength(destroyTime: number, explosionResistance: number)`{: .language-kube-21 #extended-properties-strength-0 }: Set the strength of the block
    - `destroyTime: number`{:.language-kube-21}: The base time it takes to destroy the block
    - `explosionResistance: number`{:.language-kube-21}: The resistance to explosions
- `.instabreak()`{: .language-kube-21 #extended-properties-instabreak }: Makes the block instabreak, like slime blocks
- `.strength(strength: number)`{: .language-kube-21 #extended-properties-strength-1 }: Sets the strength of the block
- `.randomTicks()`{: .language-kube-21 #extended-properties-random-ticks }: Marks the block as randomly ticking
- `.dynamicShape()`{: .language-kube-21 #extended-properties-dynamic-shape }: Marks the block as having a dynamic shape
- `.noLootTable()`{: .language-kube-21 #extended-properties-no-loot-table }: Marks the block as no having any drops
- `.dropsLike(block: Block)`{: .language-kube-21 #extended-properties-drops-like-0 }: Makes the block use the same loot table as the provided block
- `.dropsLike(block: Supplier<Block>)`{: .language-kube-21 #extended-properties-drops-like-1 }: Makes the block use the same loot table as the provided block
- `.air()`{: .language-kube-21 #extended-properties-air }: Marks the block as being air-like
- `.isValidSpawn(isValidSpawn: BlockBehaviour$StateArgumentPredicate<EntityType<?>>)`{: .language-kube-21 #extended-properties-is-valid-spawn }: Determines if an entity many spawn on the block
- `.isRedstoneConductor(isRedstoneConductor: BlockBehaviour$StatePredicate)`{: .language-kube-21 #extended-properties-is-redstone-conductor }: Determines if the block can conduct redstone
- `.isSuffocating(isSuffocating: BlockBehaviour$StatePredicate)`{: .language-kube-21 #extended-properties-is-suffocating }: Determines if the block is suffocating
- `.isViewBlocking(isViewBlocking: BlockBehaviour$StatePredicate)`{: .language-kube-21 #extended-properties-is-view-blocking }: Determines if the block is view blocking
- `.hasPostProcess(hasPostProcess: BlockBehaviour$StatePredicate)`{: .language-kube-21 #extended-properties-has-post-process }: Determines if the block has post processing during world generation
- `.emissiveRendering(emissiveRendering: BlockBehaviour$StatePredicate)`{: .language-kube-21 #extended-properties-emissive-rendering }: Determines if the block has emissive rendering
- `.requiresCorrectToolsForDrops()`{: .language-kube-21 #extended-properties-requires-correct-tools-for-drops }: Set the block as requiring the correct tool for it drop items
- `.mapColor(color: MapColor)`{: .language-kube-21 #extended-properties-map-color-0 }: Set the map color of the block
- `.mapColor(mapColor: Function<BlockState, MapColor>)`{: .language-kube-21 #extended-properties-map-color-1 }: Set the map color of the block per-block state
- `.mapColor(color: DyeColor)`{: .language-kube-21 #extended-properties-map-color-2 }: Set the map color of the block based on a dye color
- `.destroyTime(destroyTime: number)`{: .language-kube-21 #extended-properties-destroy-time }: Set the block's destroy time
- `.explosionResistance(explosionResistance: number)`{: .language-kube-21 #extended-properties-explosion-resistance }: Set the block's explosion resistance
- `.ignitedByLava()`{: .language-kube-21 #extended-properties-ignited-by-lava }: Marks the block as being able to be ignited by lava
- `.liquid()`{: .language-kube-21 #extended-properties-liquid }: Marks the block as being a liquid
- `.forceSolidOn()`{: .language-kube-21 #extended-properties-force-solid-on }: Forces the block to be solid (?)
- `.forceSolidOff()`{: .language-kube-21 #extended-properties-force-solid-off }: Forces the block to be non-solid (?)
- `.pushReaction(reaction: PushReaction)`{: .language-kube-21 #extended-properties-push-reaction }: Set the block's reaction to being pushed by pistons
- `.offsetType(type: BlockBehaviour$OffsetType)`{: .language-kube-21 #extended-properties-offset-type }: Set the block's hitbox offset type
- `.requiredFeatures(flags...: FeatureFlag[])`{: .language-kube-21 #extended-properties-required-features }: Mark the block as requiring the given feature flags to be obtainable/usable in-game
- `.instrument(instrument: NoteBlockInstrument)`{: .language-kube-21 #extended-properties-instrument }: Set the note block instrument of the block
- `.defaultInstrument()`{: .language-kube-21 #extended-properties-default-instrument }: Set the block's instrument as `harp`{:.e}
- `.replaceable()`{: .language-kube-21 #extended-properties-replaceable }: Mark the block as being replaceable

---

<span id="attachments"></span>

## Inventory

**Type**: `tfc:inventory`

An inventory attachment type that can have its contents restricted based on TFC's size and weight values

{: #inventory-definition }

### Definition

- `width: int`{:.language-kube-21}: An integer number, how wide the container is. Identical to the width of KubeJS's default inventory. Required
- `height: int`{:.language-kube-21}: An integer number, how tall the container is. Identical to the height of KubeJS's default inventory. Required
- `inputFilter?: ItemPredicate`{:.language-kube-21}: An item predicate, what items may enter the container. Identical to the input filter of KubeJS's default inventory. Optional
- `sizeFilter?: Predicate<Size>`{:.language-kube-21}: A size predicate, a filter on the size of items that can enter the container. Optional
- `weightFilter?: Predicate<Weight>`{:.language-kube-21}: A weight predicate, a filter on the size of items that can enter the container. Optional

This attachment type has all the same methods as the base inventory attachment

{: #inventory-example }

### Example

```js-21
StartupEvents.registry('block', event => {
    event.create('inventory')
        .blockEntity(be => {
            be.attach('inv', 'tfc:inventory', [], {
                width: 9,
                height: 1,
                sizeFilter: size => size.isSmallerThan('normal')
            })
            be.rightClickOpensInventory('inv')
        })
})
```

## Sealable Inventory

**Type**: `tfc:sealable_inventory`

A [TFC inventory attachment](#inventory) that can be sealed to apply a food trait to its contents

{: #sealable-inventory-definition }

### Definition

- `width: int`{:.language-kube-21}: An integer number, how wide the container is. Identical to the width of KubeJS's default inventory. Required
- `height: int`{:.language-kube-21}: An integer number, how tall the container is. Identical to the height of KubeJS's default inventory. Required
- `inputFilter?: ItemPredicate`{:.language-kube-21}: An item predicate, what items may enter the container. Identical to the input filter of KubeJS's default inventory. Optional
- `sizeFilter?: Predicate<Size>`{:.language-kube-21}: A size predicate, a filter on the size of items that can enter the container. Optional
- `weightFilter?: Predicate<Weight>`{:.language-kube-21}: A weight predicate, a filter on the size of items that can enter the container. Optional
- `trait: Holder<FoodTrait>`{:.language-kube-21}: The trait to apply to items while the inventory is sealed. Required

{: #sealable-inventory-methods }

### Extra Methods

This attachment type has all the same methods as the base inventory attachment and

- `.seal(): void`{:.language-kube-21}: Seals the inventory, preventing modification of its contents
- `.unseal(): void`{:.language-kube-21}: Unseals the inventory, allowing modification of its contents
- `.toggleSeal(): boolean`{:.language-kube-21}: Toggles the sealed state of the inventory and returns if the inventory is sealed *after* toggling
- `.isSealed(): boolean`{:.language-kube-21}: If the inventory is currently sealed

{: #sealable-inventory-example }

### Example

```js-21
StartupEvents.registry('block', event => {
    event.create('sealable_inventory')
        .blockEntity(be => {
            be.attach('inv', 'tfc:sealable_inventory', [], {
                width: 9,
                height: 1,
                trait: 'kubejs:trait'
            })
        })
        .rightClick(e => {
            let { player } = e
            let { inv } = e.block.entity.attachments
            if (!player.shiftKeyDown) {
                player.openInventoryGUI(inv, event.block.blockState.block.name)
            } else {
                inv.toggleSeal()
            }
        })
})
```

## Heat Consumer

**Type**: `tfc:heat_consumer`

An [`IHeatConsumer`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/common/component/heat/IHeatConsumer.java) attachment which exposes TFC's `tfc:heat` block capability. Will accept heat from heated device blocks, like the charcoal forge, below it and provide it to the first inventory attachment also present on the block

{: #heat-consumer-definition }

### Definition

- `decayAmount: number`{:.language-kube-21}: How much the temperature should decrease (°C) per tick. Required
- `onlyHeatIfHigher?: boolean`{:.language-kube-21}: If the internal temperature should only be set if the provided temperature is higher than the current temperature. Optional, defaults to `true`{:.p}

{: #heat-consumer-methods }

### Methods

- `.getTemperature(): number`{:.language-kube-21}: Get the current temperature
- `.setTemperature(temperature: number): void`{:.language-kube-21}: Set the current temperature

{: #heat-consumer-example }

### Example

```js-21
StartupEvents.registry('block', event => {
    event.create('heat_consumer')
        .blockEntity(be => {
            be.attach('heat', 'tfc:heat_consumer', [], {
                decayAmount: 0.1
            })
            be.inventory('inv', [], 9, 1) // For simple demonstration of the application of heat to inventories
            be.rightClickOpensInventory('inv')
        })
        .tag('tfc:charcoal_forge_invisible') // Required for charcoal forges to not extinguish when the blcok is placed above them
})
```

## Calendar Tracking

**Type**: `tfc:calendar_tracking`

An attachment which stores a [timestamp]({% link kubejs_tfc/1.21.1/type-explanations.md %}#icalendar-get-ticks)

{: #calendar-tracking-methods }

### Methods

- `.set(): void`{:.language-kube-21}: Set the stored timestamp to now
- `.set(tick: int): void`{:.language-kube-21}: Set the stored timestamp to the given timestamp
- `.get(): int`{:.language-kube-21}: Get the currently stored timestamp
- `.reset(): void`{:.language-kube-21}: Set the stored timestamp to `-1`{:.n}, a notionally un-set value

{: #calendar-tracking-example }

### Example

```js-21
StartupEvents.registry('block', event => {
    event.create('calendar_tracking')
        .blockEntity(be => {
            be.attach('cal', 'tfc:calendar_tracking', [], {})
        })
        .rightClick(e => {
            e.block.entity.attachments['cal'].set()
        })
})
```
