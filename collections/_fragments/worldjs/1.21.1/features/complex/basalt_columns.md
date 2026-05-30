---
title: Basalt Columns
anchor: basalt-column
type: basalt_columns
wiki_link: https://minecraft.wiki/w/Basalt_Columns?oldid=3460729
sort_pos: b
cat:
    - worldjs
    - 1.21.1
    - feature
example: |-
    // TODO
---

[[ base ]]

- `.reach(provider: IntProvider)`{: .language-kube-21 #{{ page.anchor }}-reach }: The max radius of the column
    - Must be {% in_range 0,3 %}
    - [[ required ]]
- `.height(provider: IntProvider)`{: .language-kube-21 #{{ page.anchor }}-height }: The maximum height of the column
    - Must be {% in_range 1,10 %}
    - [[ required ]]
