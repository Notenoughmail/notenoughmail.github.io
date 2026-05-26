---
title: Block Column
anchor: block-column
type: block_column
wiki_link: https://minecraft.wiki/w/Cave_Vines_(feature)?oldid=3567831
sprite: BlockSprite
icon: lit-cave-vines
cat:
    - worldjs
    - 1.21.1
    - feature
example:
    - // TODO
---

[[ base ]]

- `.layer(height: IntProvider, state: BlockStateProvider)`{: .language-kube-21 #{{ page.anchor }}-layer }: Adds a column layer
    - `height: IntProvider`{:.language-kube-21}: The [[ int ]] describing the height of the layer
        - Must be non-negative
    - `state: BlockstateProvider`{:.language-kube-21}: The [[ block_state_provider ]] to place for the layer
- `.direction(dir: Direction)`{: .language-kube-21 #{{ page.anchor }}-direction }: The direction the column places in
    [[ directions ]]
    - Defaults to `up`{:.e}
- `.allowedPlacement(allowed: BlockPredicate)`{: .language-kube-21 #{{ page.anchor }}-allowed-placement }: The [[ block_predicate ]] check for each layer of the column
- `.prioritizeTip()`{: .language-kube-21 #{{ page.anchor }}-prioritize-tip }: Makes the column remove layers from the start of the column when space is restricted
