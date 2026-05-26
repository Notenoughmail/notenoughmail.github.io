---
title: Disk
anchor: disk
type: disk
wiki_link: https://minecraft.wiki/w/Disk?oldid=3548744
cat:
    - worldjs
    - 1.21.1
    - feature
example:
    - // TODO
---

[[ base ]]

- `.stateProvider(fallback: BlockStateProvider, rules: List<RuleProvider>)`{: .language-kube-21 #{{ page.anchor }}-state-provider }: The block(s) to place
    - `fallback: BlockStateProvider`{:.language-kube-21}: The fallback [[ block_state_provider ]] to place if no `rules`{:.v} pass
    - `rules: List<RuleProvider>`{:.language-kube-21}: A list of `RuleProvider`s, which can be made as an object with the following fields
        - `ifTrue: BlockPredicate`{:.language-kube-21}: The [[ block_predicate ]] check for if `then`{:.v} should place
        - `then: BlockStateProvider`{:.language-kube-21}: The [[ block_state_provider ]] if this rule's `ifTrue`{:.v} passes
    - [[ required ]]
- `.target(target: BlockPredicate)`{: .language-kube-21 #{{ page.anchor }}-target }: The [[ block_predicate ]] for checking if the feature may place
    - [[ required ]]
- `.radius(radius: IntProvider)`{: .language-kube-21 #{{ page.anchor }}-radius }: The radius of the disk, as an [[ int ]]
    - Must be {% in_range 0,8 %}
    - [[ required ]]
- `.halfHeight(height: int)`{: .language-kube-21 #{{ page.anchor }}-half-height }: Half the height of the disk
    - Must be {% in_range 0,4 %}
    - [[ def_0 ]]
