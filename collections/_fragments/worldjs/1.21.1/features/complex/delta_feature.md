---
title: Delta Feature
anchor: delta-feature
type: delta_feature
wiki_link: https://minecraft.wiki/w/Delta?oldid=3493371
icon: delta
sort_pos: d
cat:
    - worldjs
    - 1.21.1
    - feature
example: |-
    .size([11, 15])
    .rimSize([ 1, 3])
    .rim('minecraft:calcite')
    .contents('minecraft:lava')
    .withPlacement('minecraft:delta', p => {
        p.modifiers(modifiers => {
            let { minecraft } = modifiers
            minecraft
                .countOnEveryLayer(40)
                .biome()
        })
    })
---

[[ base ]]

- `.contents(state: BlockState)`{: .language-kube-21 #{{ page.anchor }}-contents }: The block to place as the interior of the delta
    - Defaults to `minecraft:air`
- `.rim(state: BlockState)`{: .language-kube-21 #{{ page.anchor }}-rim }: The block to place as the rim of the delta
    - Defaults to `minecraft:air`
- `.size(provider: IntProvider)`{: .language-kube-21 #{{ page.anchor }}-size }: The size of the delta interior
    - Must be {% in_range 0,16 %}
    - [[ required ]]
- `.rimSize(provider: IntProvider)`{: .language-kube-21 #{{ page.anchor }}-rim-size }: The size of the rim
    - Must be {% in_range 0,16 %}
    - [[ required ]]
