---
title: Nether Forest Vegetation
anchor: nether-forest-vegetation
type: nether_forest_vegetation
wiki_link: https://minecraft.wiki/w/Nether_Forest_Vegetation?oldid=3547414
sprite: BlockSprite
icon: all-nether-roots
sort_pos: n
cat:
    - worldjs
    - 1.21.1
    - feature
example: |-
    // TODO
---

[[ base ]]

- `.stateProvider(provider: BlockStateProvider)`{: .language-kube-21 #{{ page.anchor }}-state-provider }: The [[ block_state_provider ]] to place
- `.spreadWidth(width: int)`{: .language-kube-21 #{{ page.anchor }}-spread-width }: The horizontal distance to spread over
    - Must be {% in_range 1,,) %}
    - [[ def_1 ]]
- `.spreadHeight(height: int)`{: .language-kube-21 #{{ page.anchor }}-spread-height }: The vertical distance to spread over
    - Must be {% in_range 1,,) %}
    - [[ def_1 ]]
