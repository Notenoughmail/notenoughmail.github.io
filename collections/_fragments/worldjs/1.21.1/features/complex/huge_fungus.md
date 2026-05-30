---
title: Huge Fungus
anchor: huge-fungus
type: huge_fungus
wiki_link: https://minecraft.wiki/w/Huge_Fungus?oldid=3303420
sort_pos: h
cat:
    - worldjs
    - 1.21.1
    - feature
example: |-
    // TODO
---

[[ base ]]

- `.validBaseBlock(state: BlockState)`{: .language-kube-21 #{{ page.anchor }}-valid-base-block }: The block to place the feature on
    - [[ required ]]
- `.stemState(state: BlockState)`{: .language-kube-21 #{{ page.anchor }}-stem-state }: The stem block to place
    - [[ required ]]
- `.hatState(state: BlockState)`{: .language-kube-21 #{{ page.anchor }}-hat-state }: The hat block to place
    - [[ required ]]
- `.decorState(state: BlockState)`{: .language-kube-21 #{{ page.anchor }}-decor-state }: The block to place for decoration
    - [[ required ]]
- `.replaceableBlocks(replaceable: BlockPredicate)`{: .language-kube-21 #{{ page.anchor }}-replaceable-blocks }: The [[ block_predicate ]] that determines which blocks can be replaced by the feature
    - Defaults to `true`{:.p}
- `.planted()`{: .language-kube-21 #{{ page.anchor }}-planted }: Allows the feature to exceed the world ceiling and makes blocks replaced by the feature drop their items
