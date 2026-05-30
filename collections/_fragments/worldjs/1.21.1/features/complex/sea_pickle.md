---
title: Sea Pickle
anchor: sea-pickle
type: sea_pickle
wiki_link: https://minecraft.wiki/w/Sea_Pickle_(feature)?oldid=3566424
sprite: BlockSprite
sort_pos: s
cat:
    - worldjs
    - 1.21.1
    - feature
example: |-
    // TODO
---

[[ base ]]

- `.count(count: IntProvider)`{: .language-kube-21 #{{ page.anchor }}-count }: The number of times to place as a [[ int ]]
    - Must be {% in_range 0,256 %}
    - [[ required ]]
