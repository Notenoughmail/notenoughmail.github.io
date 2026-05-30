---
title: Replace Single Block
anchor: replace-single-block
type: replace_single_block
wiki_link: https://minecraft.wiki/w/Replace_single_block?oldid=3249363
sprite: BlockSprite
icon: air
sort_pos: r
cat:
    - worldjs
    - 1.21.1
    - feature
example: |-
    // TODO
---

[[ base ]]

- `.targetStates(targets: List<OreTargetState>)`{: .language-kube-21 #{{ page.anchor }}-target-states }: The replacement targets
    - `OreTargetState`s can be made as an object with following fields
        - `target: RuleTest`{:.language-kube-21}: A [[ rule_test ]], the validation for if `state`{:.v} can place
        - `state: BlockState`{:.language-kube-21}: The block state to place if `target`{:.v} matches
