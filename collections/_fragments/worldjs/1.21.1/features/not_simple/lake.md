---
title: Lake
anchor: lake
type: lake
wiki_link: https://minecraft.wiki/w/Lava_Lake?oldid=3518200
icon: lake-lava
cat:
    - worldjs
    - 1.21.1
    - feature
example:
    - // TODO
---

[[ base ]]

- `.fluid(provider: BlockStateProvider)`{: .language-kube-21 #{{ page.anchor }}-fluid }: The [[ block_state_provider ]] to place as the lake's fluid
    - [[ required ]]
- `.barrier(provider: BlockStateProvider)`{: .language-kube-21 #{{ page.anchor }}-barrier }: The [[ block_state_provider ]] to place as the lake's barrier
    - Defaults to `minecraft:air`, which does not replace blocks
