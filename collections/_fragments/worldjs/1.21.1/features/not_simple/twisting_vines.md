---
title: Twisting Vines
anchor: twisting-vines
type: twisting_vines
wiki_link: https://minecraft.wiki/w/Twisting_Vines_(feature)?oldid=3566443
sprite: BlockSprite
icon: twisting-vines-plant
cat:
    - worldjs
    - 1.21.1
    - feature
example:
    - // TODO
---

[[ base ]]

- `.spreadWidth(width: int)`{: .language-kube-21 #{{ page.anchor }}-spread-width }: The max spread width
    - Must be {% in_range 1,,) %}
    - [[ def_1 ]]
- `.spreadHeight(height: int)`{: .language-kube-21 #{{ page.anchor }}-spread-height }: The max spread height
    - Must be {% in_range 1,,) %}
    - [[ def_1 ]]
- `.maxHeight(height: int)`{: .language-kube-21 #{{ page.anchor }}-max-height }: The maximum height
    - Must be {% in_range 1,,) %}
    - [[ def_1 ]]
