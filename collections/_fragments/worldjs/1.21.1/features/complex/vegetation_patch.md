---
title: Vegetation Patch
anchor: vegetation-patch
type: vegetation_patch
wiki_link: https://minecraft.wiki/w/Vegetation_Patch?oldid=3575534
sprite: BlockSprite
icon: moss-block
sort_pos: v
name: 'kubejs:moonlit_sanctuary'
cat:
    - worldjs
    - 1.21.1
    - feature
example: |-
    .replaceableBlocks('minecraft:dirt')
    .groundState([
        { weight: 14, value: 'minecraft:moss_blocks' },
        { weight: 4, value: 'minecraft:rooted_dirt' },
        { weight: 3, value: 'minecraft:podzol' },
        { weight: 2, value: 'minecraft:coarse_dirt' }
    ])
    .vegetationFeature('kubejs:moonlit_mushrooms')
    .depth([1, 2])
    .verticalRange(4)
    .vegetationChance(0.45)
    .xzRadius([5, 6])
    .extraEdgeColumnChance(0.45)
    .withPlacement(placement => {
        placement.tag('kubejs:worldgen/moonlit_sanctuaries') // See the add features biome modifier example
            .modifiers(modifiers => {
                let { minecraft } = modifiers
                minecraft
                    .rarityFilter(10)
                    .inSquare()
                    .heightMap('motion_blocking_no_leaves')
                    .biome()
            })
    })
    // Kindly provided by Liopyu
---

[[ base ]]

- `.replaceableBlocks(blocks: TagKey<Block>)`{: .language-kube-21 #{{ page.anchor }}-replaceable-blocks }: The blocks that can be replaced with vegetation
    - [[ required ]]
- `.groundState(state: BlockStateProvider)`{: .language-kube-21 #{{ page.anchor }}-ground-state }: the [[ block_state_provider ]] use to generate the column
    - [[ required ]]
- `.vegetationFeature(feature: Holder$Reference<PlacedFfeature>)`{: .language-kube-21 #{{ page.anchor }}-vegetation-feature }: The feature to place on finding a valid position
    - [[ required ]]
- `.surface(surface: CaveSurface)`{: .language-kube-21 #{{ page.anchor }}-surface }: The `CaveSurface`{:.e} to place on
    {% include enum_list.html summary='Reveal/hide list of valid cave surfaces' values='ceiling,floor' %}
    - Defaults to `floor`{:.e}
- `.depth(depth: IntProvider)`{: .language-kube-21 #{{ page.anchor }}-depth }: An [[ int ]] describing the amount of blocks that should be replaced
    - Must be {% in_range 1,128 %}
    - [[ required ]]
- `.extraBottomBlockChance(chance: number)`{: .language-kube-21 #{{ page.anchor }}-extra-bottom-block-chance }: The chance to add an extra block to the height
    - [[ unit ]]
    - [[ def_0 ]]
- `.verticalRange(range: int)`{: .language-kube-21 #{{ page.anchor }}-vertical-range }: The y radius in which the column should search for available placement
    - Must be {% in_range 1,256 %}
    - [[ def_1 ]]
- `.vegetationChance(chance: number)`{: .language-kube-21 #{{ page.anchor }}-vegetation-chance }: The chance of placing the [vegetation feature](#{{ page.anchor }}-vegetation-feature) on finding a valid position
    - [[ unit ]]
    - [[ def_0 ]]
- `.xzRadius(radius: IntProvider)`{: .language-kube-21 #{{ page.anchor }}-x-z-radius }: The horizontal radius to search for valid positions
    - [[ required ]]
- `.extraEdgeColumnChance(chance: number)`{: .language-kube-21 #{{ page.anchor }}-extra-edge-column-chance }: The chance to add an extra search position next to the initial rectangle
    - [[ unit ]]
    - [[ def_0 ]]
