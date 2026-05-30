---
title: Fill Layer
anchor: fill-layer
type: fill_layer
wiki_link: https://minecraft.wiki/w/Fill_layer?oldid=3078700
sprite: BlockSprite
icon: air
sort_pos: f
cat:
    - worldjs
    - 1.21.1
    - feature
example: |-
    // TODO
---

[[ base ]]

- `.height(height: int)`{: .language-kube-21 #{{ page.anchor }}-height }: The [[ int ]] height of the layer
    - Must be {% in_range 0,4064 %}
    - [[ required ]]
- `.state(state: BlockState)`{: .language-kube-21 #{{ page.anchor }}-state }: The block to fill the layer with
    - Defaults to `minecraft:air`
