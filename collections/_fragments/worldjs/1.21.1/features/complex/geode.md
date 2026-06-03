---
title: Geode
anchor: geode
type: geode
wiki_link: https://minecraft.wiki/w/Amethyst_Geode?oldid=3554330
icon: amethyst-geode
name: 'kubejs:void_amethyst_geode'
sort_pos: g
cat:
    - worldjs
    - 1.21.1
    - feature
example: |-
    .blocks({
        innerLayer: [
            { weight: 8, value: 'minecraft:amethyst_block' },
            { weight: 2, value: 'minecraft:obsidian' },
            'minecraft;crying_obsidian'
        ],
        alternativeInnerLayer: 'minecraft:budding_amethyst',
        middleLayer: [
            { weight: 3, value: 'minecraft:calcite' },
            'minecraft:smooth_basalt'
        ],
        outerLayer: [
            { weight: 5, value: 'minecraft:smooth_basalt' },
            { weight: 4, value: 'minecraft:obsidian' },
            'minecraft:crying_obsidian'
        ]
    })
    .layers({
        filling: 1,
        innerLayer: 1.6,
        middleLayer: 2.4,
        outerLayer: 3.2
    })
    .crack({
        generateChance: 0.55,
        baseSize: 1.6,
        pointOffset: 3.2
    })
    .usePotentialPlacementsChance(0.32)
    .useAlternativeLayer0Chance(0.12)
    .outerWallDistance([3, 5])
    .distributionPoints([2, 4])
    .minGenOffset(-8)
    .maxGenOffset(8)
    .withPlacement(placement => {
        placement.tag('kubejs:worldgen/void_amethyst_geode')
            .modifiers(modifiers => {
                let { minecraft } = modifiers
                minecraft
                    .rarityFilter(28)
                    .inSquare()
                    .uniformHeightRange(-48, 48)
                    .biome()
            })
    })
    // Kindly provided by Liopyu
---

[[ base ]]

- `.blocks(blocks: GeodeBlocks)`{: .language-kube-21 #{{ page.anchor }}-blocks }: The `GeodeBlocks` which define the blocks the geode will place. `GeodeBlocks` can be made as an object with the fields
    - `filling?: BlockStateProvider`{:.language-kube-21}: The [[ block_state_provider ]] of the filling layer
        - Defaults to `minecraft:air`
    - `innerLayer?: BlockStateProvider`{:.language-kube-21}: The [[ block_state_provider ]] of the inner layer
        - Defaults to `minecraft:amethyst_block`
    - `alternativeInnerLayer?: BlockStateProvider`{:.language-kube-21}: The alternative [[ block_state_provider ]] of the inner layer
        - Defaults to `minecraft:budding_amethyst`
    - `middleLayer?: BlockStateProvider`{:.language-kube-21}: The [[ block_state_provider ]] of the middle layer
        - Defaults to `minecraft:calcite`
    - `outerLayer?: BlockStateProvider`{:.language-kube-21}: The [[ block_state_provider ]] of the outer layer
        - Defaults to `minecraft:smooth_basalt`
    - `innerPlacements?: List<BlockState>`{:.language-kube-21}: The blocks to place adjacent to the alternative inner layer blocks
        - Defaults to `['minecraft:small_amethyst_bud', 'minecraft:medium_amethyst_bud', 'minecraft:large_amethyst_bud', 'minecraft:amethyst_cluster']`{:.language-kube-21}
        - **Must** *not* be empty
    - `cannotReplace?: TagKey<Block>`{:.language-kube-21}: The tag id of blocks which the geode cannot replace
        - Defaults to `minecraft:feature_cannot_replace`
    - `invalidBlocks?: TagKey<Block>`{:.language-kube-21}: The tag id of blocks which the geode considers invalid for spawning
        - Defaults to `minecraft:geode_invalid_blocks`
    - Defaults to all of the above defaults
- `.layers(layers: GeodeLayers)`{: .language-kube-21 #{{ page.anchor }}-layers }: The `GeodeLayers` which defines the thickness of the geode's layers. `GeodeLayers` can be made as an object with the fields
    - `filling?: float`{:.language-kube-21}: The width of the filling layer
        - Defaults to `1.7`{:.n}
    - `innerLayer?: float`{:.language-kube-21}: The width of the inner layer
        - Defaults to `2.2`{:.n}
    - `middleLayer?: float`{:.language-kube-21}: The width of the middle layer
        - Defaults to `3.2`{:.n}
    - `outerLayer?: float`{:.language-kube-21}: the width of the outer layer
        - Defaults to `4.2`{:.n}
    - Defaults to all of the above defaults
- `.crack(crack: GeodeCrack)`{: .language-kube-21 #{{ page.anchor }}-crack }: The `GeodeCrack` which defines the geode's crack. A `GeodeCrack` can be made as an object with the fields
    - `generateChance?: float`{:.language-kube-21}: The probability the geode generates with a crack
        - [[ unit ]]
        - [[ def_1 ]]
    - `baseSize?: float`{:.language-kube-21}: The base size of the crack
        - Must be {% in_range 0,5 %}
        - Defaults to `2`{:.n}
    - `pointOffset?: int`{:.language-kube-21}: The offset applied to the crack
        - Must be {% in_range 0,10 %}
        - Defaults to `2`{:.n}
    - Defaults to all of the above defaults
- `.usePotentialPlacementsChance(chance: float)`{: .language-kube-21 #{{ page.anchor }}-use-potential-placements-chance }: The probability of placing an inner placement block next to an inner layer block
    - [[ unit ]]
    - Defaults to `0.35`{:.n}
- `.useAlternativeLayer0Chance(chance: float)`{: .language-kube-21 #{{ page.anchor }}-use-alternative-layer-0-chance }: The chance to place an alternative inner place block instead of a regular inner layer block
    - [[ unit ]]
    - [[ def_0 ]]
- `.outerWallDistance(provider: IntProvider)`{: .language-kube-21 #{{ page.anchor }}-outer-wall-distance }: The [[ int ]] offset on each coordinate of the center from the feature start
    - Must be {% in_range 1,20 %}
    - Defaults to `[4, 5]`{:.language-kube-21}
- `.distributionPoints(provider: IntProvider)`{: .language-kube-21 #{{ page.anchor }}-distribution-points }: The number of distribution points as an [[ int ]]
    - Must be {% in_range 1,20 %}
    - Defaults to `[3, 4]`{:.language-kube-21}
- `.pointOffset(provider: IntProvider)`{: .language-kube-21 #{{ page.anchor }}-point-offset }: The point offset as an [[ int ]]
    - Must be {% in_range 0,10 %}
    - Defaults to `[1, 2]`{:.language-kube-21}
- `.minGenOffset(int: offset)`{: .language-kube-21 #{{ page.anchor }}-min-gen-offset }: The minimum Chebyshev distance between a geode block and the center
    - Defaults to `-16`{:.n}
- `.maxGenOffset(int: offset)`{: .language-kube-21 #{{ page.anchor }}-max-gen-offset }: The maximum Chebyshev distance between a geode block and the center
    - Defaults to `16`{:.n}
- `.noiseMultiplier(multiplier: float)`{: .language-kube-21 #{{ page.anchor }}-noise-multiplier }: The noise multiplier
    - [[ unit ]]
    - Defaults to `0.05`{:.n}
- `.invalidBlocksThreshold(blocks: int)`{: .language-kube-21 #{{ page.anchor }}-invalid-blocks-threshold }: The threshold for invalid blocks
    - Found by checking [distribution points](#{{ page.anchor }}-distribution-points) amount of times near the center of the geode
        - Will not generate if the found count is greater than the given value
    - defaults to `0`{:.n}
