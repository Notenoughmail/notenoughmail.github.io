---
title: Tree
anchor: tree
type: tree
wiki_link: https://minecraft.wiki/w/Tree_definition?oldid=3410916
cat:
    - worldjs
    - 1.21.1
    - feature
example:
    - // TODO
---

[[ base ]]

- `.trunkProvider(provider: BlockStateProvider)`{: .language-kube-21 #{{ page.anchor }}-trunk-provider }: The [[ block_state_provider ]] to use for the trunk of the tree
    - [[ required ]]
- `.trunkPlacer(placer: TrunkPlacer)`{: .language-kube-21 #{{ page.anchor }}-trunk-placer }: The [trunk placer](https://minecraft.wiki/w/Tree_definition?oldid=3410916#Trunk_placer) which defines how the trunk is placed
    - [[ required ]]
- `.foliageProvider(provider: BlockStateProvider)`{: .language-kube-21 #{{ page.anchor }}-foliage-provider }: The [[ block_state_provider ]] to use for the foliage of the tree
    - [[ required ]]
- `.foliagePlacer(placer: FoliagePlacer)`{: .language-kube-21 #{{ page.anchor }}-foliage-placer }: The [foliage placer](https://minecraft.wiki/w/Tree_definition?oldid=3410916#Foliage_placer) which defines how the foliage is placed
    - [[ required ]]
- `.rootPlacer(placer: RootPlacer)`{: .language-kube-21 #{{ page.anchor }}-root-placer }: The [root placer](https://minecraft.wiki/w/Tree_definition?oldid=3410916#Root_placer) of the tree
- `.dirtProvider(provider: BlockStateProvider)`{: .language-kube-21 #{{ page.anchor }}-dirt-provider }: The [[ block_state_provider ]] to place around the tree
- `.minimumSize(size: FeatureSize)`{: .language-kube-21 #{{ page.anchor }}-minimum-size }: The [minimum size](https://minecraft.wiki/w/Tree_definition?oldid=3410916#Minimum_size) required for the tree to place
    - [[ required ]]
- `.decorators(decorators: List<TreeDecorator>)`{: .language-kube-21 #{{ page.anchor }}-decorators }: The [tree decorators](https://minecraft.wiki/w/Tree_definition?oldid=3410916#Decorator), additional blocks to place on and around the tree
- `.ignoreVines()`{: .language-kube-21 #{{ page.anchor }}-ignore-vines }: Allow the tree to ignore vines blocking its spawn position
- `.forceDirt()`{: .language-kube-21 #{{ page.anchor }}-force-dirt }: Force the [dirt](#{{ page.anchor }}-dirt-proivder) to be placed, even if the ground was already dirt-like
