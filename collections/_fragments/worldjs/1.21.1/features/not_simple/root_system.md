---
title: Root System
anchor: root-system
type: root_system
wiki_link: https://minecraft.wiki/w/Root_System?oldid=3575054
sprite: BlockSprite
icon: rooted-dirt
sort_pos: r
cat:
    - worldjs
    - 1.21.1
    - feature
example:
    - // TODO
---

[[ base ]]

- `.feature(feature: Holder$Reference<PlacedFeature>)`{: .language-kube-21 #{{ page.anchor }}-feature }: The feature to place on top of the root system
    - [[ required ]]
- `.requiredVerticalSpaceForTree(space: int)`{: .language-kube-21 #{{ page.anchor }}-required-vertical-space-for-tree }: The required vertical space for the tree feature to generate
    - Must be {% in_range 1,64 %}
    - [[ def_1 ]]
- `.rootRadius(radius: int)`{: .language-kube-21 #{{ page.anchor }}-root-radius }: The radius to place roots in
    - Must be {% in_range 1,64 %}
    - [[ def_1 ]]
- `.rootReplaceable(replaceable: TagKey<Block>)`{: .language-kube-21 #{{ page.anchor }}-root-replaceable }: The blocks that cane be replaced by roots
    - [[ required ]]
- `.rootStateProvider(provider: BlockStateProvider)`{: .language-kube-21 #{{ page.anchor }}-root-state-provider }: The [[ block_state_provider ]] to use for the root blob
    - [[ required ]]
- `.rootPlacementAttempts(attempts: int)`{: .language-kube-21 #{{ page.anchor }}-root-placement-attempts }: The number times to attempt to place root blocks
    - Must be {% in_range 1,256 %}
    - [[ def_1 ]]
- `.rootColumnMaxHeight(height: int)`{: .language-kube-21 #{{ page.anchor }}-root-column-max-height }: The maximum height of the root column/blob
    - Must be {% in_range 1,4096 %}
    - [[ def_1 ]]
- `.hangingRootRadius(radius: int)`{: .language-kube-21 #{{ page.anchor }}-hanging-root-radius }: The radius at which to place hanging roots
    - Must be {% in_range 1,64 %}
    - [[ def_1 ]]
- `.hangingRootsVerticalSpan(span: int)`{: .language-kube-21 #{{ page.anchor }}-hanging-roots-vertical-span }: The vertical range over which to place hanging roots
    - Must be {% in_range 0,16 %}
    - [[ def_1 ]]
- `.hangingRootStateProvider(provider: BlockStateProvider)`{: .language-kube-21 #{{ page.anchor }}-hanging-root-state-provider }: The [[ block_state_provider ]] to use for blocks which hang below the main root blob
    - [[ required ]]
- `.hangingRootsPlacementAttempts(attempts: int)`{: .language-kube-21 #{{ page.anchor }}-hanging-roots-placement-attempts }: The number of times to try to place hanging root blocks
    - Must be {% in_range 1,256 %}
    - [[ def_1 ]]
- `.allowedVerticalWaterForTree(allowed: int)`{: .language-kube-21 #{{ page.anchor }}-allowed-vertical-water-for-tree }: The maximum allowable submerged height the tree may be in
    - Must be {% in_range 1,64 %}
    - [[ def_1 ]]
- `.allowedTreePosition(allowed: BlockPredicate)`{: .language-kube-21 #{{ page.anchor }}-allowed-tree-position }: The [[ block_predicate ]] check for the tree's position
    - Defaults to `true`{:.p}
