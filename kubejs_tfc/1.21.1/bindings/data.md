---
layout: page
title: Data Bindings
permalink: /kubejs_tfc/1.21.1/bindings/data/
parent: Bindings
grand_parent: 1.21.1
desc: Bindings for interacting with/retrieving TFC's various data systems
field: data
---

# {{ page.title }}

{{ page.desc }}

```js-21
declare class DataBindings {

    // These can be accessed via TFC.data.*

    heatLevels: Map<String, Heat>
    woods: Map<ResouceLocation, RegistryWood>
    metals: Map<ResourceLocation, RegistryMetal>
    rocks: Map<ResourceLocation, RegistryRock>

    food: instanceof FoodBindings {
        get(stack: ItemStack): @Nullable IFood
        getDefinition(stack: ItemStack): @Nullable FoodDefinition
        has(stack: ItemStack): boolean
        applyTrait(stack: ItemStack, trait: Holder<FoodTrait>): ItemStack
        removeTrait(stack: ItemStack, trait: Holder<FoodTrait>): ItemStack
        hasTrait(stack: ItemStack, trait: Holder<FoodTrait>): boolean
        isRotten(stack: ItemStack): boolean
        setRotten(stack: ItemStack): ItemStack
        setCreationDate(stack: ItemStack, calendarTick: int): ItemStack
        setTransientNonDecaying(stack: ItemStack): ItemStack
        setnonDecaying(stack: ItemStack, invisible: boolean): ItemStack
    }

    support: instanceof SupportBindings {
        canStartCollapse(level: LevelAccessor, pos: BlockPos): boolean
        tryStartCollapse(level: Level, pos: BlockPos): boolean
        forceCollapse(level: Level, pos: BlockPos): boolean
        findUnsupportedPositions(level: BlockGetter, from: BlockPos, to: BlockPos): Set<BlockPos>
        isSupported(level: BlockGetter, pos: BlockPos): boolean
        getMaximumSupportedAreaAround(minPoint: BlockPos, maxPointL BlockPos): Iterable<BlockPos>
        getCheckRange(): SupportRange
        get(state: BlockState): @Nullable Support
        get(level: BlockGetter, pos: BlockPos): @Nullable Support
    }

    getPlayerInfo(player: Player): IPlayerInfo
    getChunkData(level: LevelReader, pos: BlockPos): ChunkData
    getChunkData(chunk: ChunkAccess): ChunkData
    getHeat(stack: ItemStack): @Nullable IHeat
    hasHeat(stack: ItemStack): boolean
    getHeatLevel(temperature: number): @Nullable Heat
    getSize(stack: ItemStack): Size
    getWeight(stack: ItemStack): Weight
    getFarmlandHydration(level: Level, pos: BlockPos, calendarTick?: int): int
    getFluidHeat(fluid: Fluid): @Nullable FluidHeat
    getLampFuel(fluid: Fluid, state: BlockState): @Nullable LampFuel
    getDrinkable(fluid: Fluid): @Nullable Drinkable
    getFertilizer(stack: ItemStack): @Nullable Fertilizer
    getFuel(stack: ItemStack): @Nullable Fuel
    getDeposit(stack: ItemStack): @Nullable Deposit
}
```

- `.heatLevels`{: .language-kube-21 #heat-levels }: A map between a name and a [`Heat`{:.e}](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/common/component/heat/Heat.java), can be used like `TFC.data.heatLevels.WARMING`{:.language-kube-21}
- `.woods`{: .language-kube-21 #woods }: A map between a pseudo-official id and a [`RegistryWood`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/util/registry/RegistryWood.java), which have the following methods
    - `.woodColor(): MapColor`{:.language-kube-21}: Gets the `MapColor` of the wood
    - `.barkColor(): MapColor`{:.language-kube-21}: Gets the `MapColor` of the wood's barks
    - `.tree(): TreeGrower`{:.language-kube-21}: Gets the tree grower
    - `.ticksToGrow(): Supplier<int>`{:.language-kube-21}: Gets the calendar ticks for a tree to grow
    - `.autumnIndex(): int`{:.language-kube-21}: Gets the vertical coordinate, {% in_range 0,255 %}, on the `foilage_fall` colormap of the wood's leaves
    - `.getBlock(type: Wood$BlockType): @Nullable Supplier<Block>`{:.language-kube-21}: Gets the block of the specified type
        {% include enum_list.html summary='Reveal/hide list of block types' values='log,stripped_log,wood,stripped_wood,leaves,planks,sapling,potted_sapling,bookshelf,door,trapdoor,fence,log_fence,fence_gate,button,pressure_plate,slab,stairs,tool_rack,twig,fallen_leaves,vertical_support,horizontal_support,workbench,trapped_chest,chest,loom,sluice,sign,wall_sign,barrel,lectern,scribing_table,sewing_table,shelf,axle,bladed_axle,encased_axle,clutch,gear_box,windmill,water_wheel' %}
    - `.getBlockSet(): BlockSetType`{:.language-kube-21}: Gets the block set type of the wood
    - `.getVanillaWoodType(): WoodType`{:.language-kube-21}: Gets the vanilla-equivalent `WoodType` of the weed
- `.metals`{: .language-kube-21 #metals }: A map between a pseudo-official id and a [`RegistryMetal`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/util/registry/RegistryMetal.java), which have the following methods
    - `.toolTier(): LevelTier`{:.language-kube-21}: Gets the level-backed tool tier of the metal
    - `.armorMaterial(): Holder<ArmorMaterial>`{:.language-kube-21}: Gets the armor material of the metal
    - `.armorDurability(type: ArmorItem$Type): int`{:.language-kube-21}: Gets the armor durability of the metal for the given type of armor, accepts `helmet`{:.e}, `chestplate`{:.e}, `leggings`{:.e}, `noots`{:.e}, and `body`{:.e}
    - `.getBlock(type: Metal$BlockType): @Nullable Block`{:.language-kube-21}: Gets the block of the specified type
        {% include enum_list.html summary='Reveal/hide list of block types' values='block,exposed_block,weathered_block,oxidized_block,block_slab,exposed_block_slab,weathered_block_slab,oxidized_block_slab,block_stairs,exposed_block_stairs,weathered_block_stairs,oxidized_block_stairs,grate,exposed_grate,weathered_grate,oxidized_grate,anvil,bars,chain,lamp,trapdoor' %}
    - `.mapColor(): MapColor`{:.language-kube-21}: Gets the `MapColor` of the metal
    - `.rarity(): Rarity`{:.language-kube-21}: Gets the metal's `Rarity`{:.e}
    - `.weatheredParts(): boolean`{:.language-kube-21}: If the metal has weathered blocks
    - `.weatheringResistance(): number`{:.language-kube-21}: Gets the weathering resistance of the metal, either {% in_unit %} or `-1`{:.n}
- `.rocks`{: .language-kube-21 #rocks }: A map between a pseudo-official id and a [`RegistryRock`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/util/registry/RegistryRock.java), which have the following methods
    - `.displayCategory(): RockDisplayCategroy`{:.language-kube-21}: Gets the display category of the rock
    - `.category(): RockCategory`{:.language-kube-21}: Gets the geological category of the rock
    - `.color(): MapColor`{:.language-kube-21}: Gets the `MapColor` of the rock
    - `.getBlock(type: Rock$BlockType): @Nullable Supplier<Block>`{:.language-kube-21}: Gets the block of the specified type
        {% include enum_list.html summary='Reveal/hide list of block types' values='raw,hardened,smooth,cobble,bricks,gravel,spike,cracked_bricks,mossy_bricks,mossy_cobble,chiseled,loose,mossy_loose,pressure_plate,button,aqueduct' %}
    - `.getAnvil(): @Nullable Supplier<Block>`{:.language-kube-21}: Gets the anvil block of the rock
    - `.getSlab(type: Rock$BlockType): @Nullable Supplier<Block>`{:.language-kube-21}: Gets the slab of the specified type
    - `.getStair(type: Rock$BlockType): @Nullable Supplier<Block>`{:.language-kube-21}: Gets the stair of the specified type
    - `.getWall(type: Rock%BlockType): @Nullable Supplier<Block>`{:.language-kube-21}: Gets the wall of the specified type
- `.food`{: .language-kube-21 #food }: Gets a sub-binding focusing on food data
    - `.get(stack: ItemStack)`{: .language-kube-21 #food-get }: Gets the `IFood` of the given stack if present
    - `.getDefinition(stack: ItemStack)`{: .language-kube-21 #food-get-definition }: Gets the `FoodDefinition` of the given stack if present
    - `.has(stack: ItemStack)`{: .language-kube-21 #food-has }: If the stack has a food capability
    - `.applyTrait(stack: ItemStack, trait: Holder<FoodTrait>)`{: .language-kube-21 #food-apply-trait }: Applies the given food trait to the stack if possible
    - `.removeTrait(stack: ItemStack, trait: Holder<FoodTrait>)`{: .language-kube-21 #food-remove-trait }: Removes the given food trait from the stack
    - `.hasTrait(stack: ItemStack, Holder<FoodTrait>)`{: .language-kube-21 #food-has-trait }: If the stack has the given food trait
    - `.isRotten(stack: ItemStack)`{: .language-kube-21 #food-is-rotten }: If the stack is rotten
    - `.setRotten(stack: ItemStack)`{: .language-kube-21 #food-set-rotten }: Set the given stack as rotten
    - `.setCreationDate(stack: ItemStack, calendarTick: int)`{: .language-kube-21 #food-set-creation-date }: Sets the stack's creation date to the given calendar timestamp
    - `.setTransientNonDecaying(stack: ItemStack)`{: .language-kube-21 #food-set-transient-non-decaying }: Sets the stack as non-decaying, transiently. This effect will not be carried through stack copying
    - `.setNonDecaying(stack: ItemStack, invisible: boolean)`{: .language-kube-21 #food-set-non-decaying }: Sets the stack as non-decaying, optionally including a tooltip on the stack
- `.support`{: .language-kube-21 #support }: Gets a sub-binding focusing on the support and collapse mechanics
    - `.canStartCollapse(level: LevelAccessor, pos: BlockPos)`{: .language-kube-21 #support-can-start-collapse }: If the given position can start a collapse
    - `.tryStartCollapse(level: Level, pos: BlockPos)`{: .language-kube-21 #support-try-start-collapse }: Attempts to start a collapse at het he given position, returns `true`{:.p} if any blocks collapsed
    - `.forceCollapse(level: Level, pos: BlockPos)`{: .language-kube-21 #support-force-collapse }: Forces a collapse to start at the given position, returns `true` if any blocks collapsed
    - `.findUnsupportedPositions(level: BlockGetter, from: BlockPos, to: BlockPos)`{: .language-kube-21 #support-find-unsupported-positions }: Gets all positions in the given range that are unsupported
    - `.isSupported(level: BlockGetter, pos: BlockPos)`{: .language-kube-21 #support-is-supported }: If the given position is supported
    - `.getMaximumSupportedAreaAround(minPoint: BlockPos, maxPoint: BlockPos)`{: .language-kube-21 #support-get-maximum-supported-area-around }: Gets an iterable view of all positions that could possibly be supported around the box defined by the min and max points
    - `.getCheckRange()`{: .language-kube-21 #support-get-check-range }: Gets the `SupportRange` which is representative of the range TFC checks for supports in collapses
    - `.get(state: BlockState)`{: .language-kube-21 #support-get-0 }: Gets the first `Support` associated with the block
    - `.get(level:  BlockGetter, pos: BlockPos)`{: .language-kube-21 #support-get-1 }: Gets the first `Support` associated with the block at the given position
- `.getPlayerInfo(player: Player)`{: .language-kube-21 #get-player-info }: Gets TFC's `IPlayerInfo` for the given player, which has the following methods
    - `.onDrink(): void`{:.language-kube-21}: Performs internal actions for completion of drinking from an in-world source
    - `.canDrink(): boolean`{:.language-kube-21}: If the player can currently drink
    - `.chiselMode(): ChiselModel`{:.language-kube-21}: Gets the player's selected [`ChiselMode`]({% link kubejs_tfc/1.21.1/registry.md %}#chisel-mode)
    - `.cycleChiselMode(): void`{:.language-kube-21}: Cycle the player's selected `ChiselMode`
    - `.getIntoxication(): number`{:.language-kube-21}: Get the player's intoxication, {% in_unit %}
    - `.addIntoxication(ticks: int)`{:.language-kube-21}: Adds the given number of ticks to the player's intoxication timer
    - `.getThirst(): number`{:.language-kube-21}: Gets the player's thirst value
    - `.setThirst(value: number): void`{:.language-kube-21}: Set the player's thirst value
    - `.getThirstContributionFromTemperature(): number`{:.language-kube-21}: Gets the thirst loss resultant from ambient temperature
    - `.nutrition(): INutritionData`{:.language-kube-21}: Gets the player's nutrition data, see the event for [creating custom nutrient data]({% link kubejs_tfc/1.21.1/events.md %}#custom-nutition) for an explanation of the data there
    - `.getHealthModifier(): number`{:.language-kube-21}: Gets the modifier of the player's health based it their nutrition
    - `.eat(stack: ItemStack): void`{:.language-kube-21}: Makes the player eat the given item if it is a food item
    - `.eat(food: IFood): void`{:.language-kube-21}: Makes the player eat the given food capability
    - `.eat(food: FoodData): void`{:.language-kube-21}: Makes the player directly eat the food data
- `.getChunkData(level: Level, pos: BlockPos)`{: .language-kube-21 #get-chunk-data-0 }: Get the [`ChunkData`]({% link kubejs_tfc/1.21.1/type-explanations.md %}#chunk-data) at the given position
- `.getChunkData(chunk: ChunkAccess)`{: .language-kube-21 #get-chunk-data-1 }: Get the given chunk's [`ChunkData`]({% link kubejs_tfc/1.21.1/type-explanations.md %}#chunk-data)
- `.getHeat(stack: ItemStack)`{: .language-kube-21 #get-heat }: Gets the [heat capability](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/common/component/heat/IHeat.java) of the stack if present
- `.hasHeat(stack: ItemStack)`{: .language-kube-21 #has-heat }: If the stack has a heat capability
- `.getHeatLevel(temperature: number)`{: .language-kube-21 #get-heat-level }: Get the `Heat`{:.e} associated with the given temperature, or `null`{:.p} if less than zero
- `.getSize(stack: ItemStack)`{: .language-kube-21 #get-size }: Gets the `Size`{:.e} of the stack
- `.getWeight(stack: ItemStack)`{: .language-kube-21 #get-weight }: Gets the `Weight`{:.e} of the stack
- `.getFarmlandHydrationLevel(level: Level, pos: BlockPos, calendarTick?: int)`{: .language-kube-21 #get-farmland-hydration-level }: Gets the farmland hydration, {% in_range 0,100 %}, at the given position and, optionally, at a specific calendar timestamp
- `.getFluidHeat(fluid: Fluid)`{: .language-kube-21 #get-fluid-heat }: Gets the [fluid heat](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/util/data/FluidHeat.java) of a fluid if present
- `.getLampFuel(fluid: Fluid, state: BlockState)`{: .language-kube-21 #get-lamp-fuel }: Gets the [lamp fuel](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/util/data/LampFuel.java) for the fluid and state if present
- `.getDrinkable(fluid: Fluid)`{: .language-kube-21 #get-drinkable }: Gets the [drinkable data](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/util/data/Drinkable.java) of a fluid if present
- `.getFertilizer(stack: ItemStack)`{: .language-kube-21 #get-fertilizer }: Gets the [fertilizer data](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/util/data/Fertilizer.java) of an item if present
- `.getFuel(stack: ItemStack)`{: .language-kube-21 #get-fuel }: Gets the [fuel data](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/util/data/Fuel.java) of an item if present
- `.getDeposit(stack: ItemStack)`{: .language-kube-21 #get-deposit }: Gets the [deposit data](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/util/data/Deposit.java) of an item if present
