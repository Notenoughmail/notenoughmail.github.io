---
title: Replace Blobs
anchor: replace-blobs
type: replace_blobs
wiki_link: https://minecraft.wiki/w/Blob?oldid=3586341
icon: blob
cat:
    - worldjs
    - 1.21.1
    - feature
example:
    - // TODO
---

[[ base ]]

- `.target(block: Block)`{: .language-kube-21 #{{ page.anchor }}-target }: The block to replace
    - Defaults to `minecraft:air`
- `.state(state: BlockState)`{: .language-kube-21 #{{ page.anchor }}-state }: The state to place
    - Defaults to `minecraft:air`
- `.radius(provider: IntProvider)`{: .language-kube-21 #{{ page.anchor }}-radius }: The blob radius
    - Must be {% in_range 0,12 %}
    - [[ required ]]
