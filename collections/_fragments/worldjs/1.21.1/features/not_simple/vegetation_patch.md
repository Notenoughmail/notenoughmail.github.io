---
title: Vegetation Patch
anchor: vegetation-patch
type: vegetation_patch
wiki_link: https://minecraft.wiki/w/Vegetation_Patch?oldid=3575534
cat:
    - worldjs
    - 1.21.1
    - feature
example:
    - // TODO
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
- `.depth(depth: IntProvider)`{: .language-kube-21 #{{ page.anchor }}-depth }: An [[ int ]] describing the amount of blocks that should be replaced
    - Must be {% in_range 1,128 %}
    - [[ required ]]
- `.extraBottomBlockChance(chance: float)`{: .language-kube-21 #{{ page.anchor }}-extra-bottom-block-chance }: The chance to add an extra block to the height
    - Must be {% in_unit %}
    - Defaults to `0`{:.n}
- `.verticalRange(range: int)`{: .language-kube-21 #{{ page.anchor }}-vertical-range }: The y radius in which the column should search for available placement
    - Must be {% in_range 1,256 %}
    - Defaults to `1`{:.n}
- `.vegetationChance(chance: float)`{: .language-kube-21 #{{ page.anchor }}-vegetation-chance }: The chance of placing the [vegetation feature](#{{ page.anchor }}-vegetation-feature) on finding a valid position
    - Must be {% in_unit %}
    - Defaults to `0`{:.n}
- `.xzRadius(radius: IntProvider)`{: .language-kube-21 #{{ page.anchor }}-x-z-radius }: The horizontal radius to search for valid positions
    - [[ required ]]
- `.extraEdgeColumnChance(chance: float)`{: .language-kube-21 #{{ page.anchor }}-extra-edge-column-chance }: The chance to add an extra search position next to the initial rectangle
    - Must be {% in_unit %}
    - Defaults to `0`{:.n}
