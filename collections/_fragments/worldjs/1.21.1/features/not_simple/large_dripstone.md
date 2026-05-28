---
title: Large Dripstone
anchor: large-dripstone
type: large_dripstone
wiki_link: https://minecraft.wiki/w/Dripstone_(feature)?oldid=3522490
sprite: BlockSprite
icon: pointed-dripstone
sort_pos: d
cat:
    - worldjs
    - 1.21.1
    - feature
example:
    - // TODO
---

[[ base ]]

- `.floorToCeilingSearchRange(range: int)`{: .language-kube-21 #{{ page.anchor }}-floor-to-ceiling-search-range }: The search range from start point to cave floor or ceiling
    - Must be {% in_range 1,512 %}
    - Defaults to `30`{:.n}
- `.columnRadius(provider: IntProvider)`{: .language-kube-21 #{{ page.anchor }}-column-radius }: The minimum and maximum radius of the column as an [[ int ]]
    - Must be {% in_range 1,60 %}
    - [[ required ]]
- `.heightScale(provider: FloatProvider)`{: .language-kube-21 #{{ page.anchor }}-height-scale }: The height scale as a [[ float ]]
    - A higher scale means a higher height
    - Must be {% in_range 0,20 %}
    - [[ required ]]
- `.maxColumnRadiusToCaveHeightRatio(ratio: float)`{: .language-kube-21 #{{ page.anchor }}-max-column-radius-to-cave-height-ratio }: The maximum radius between the column radius and the cave height
    - Must be {% in_range 0.1,1 %}
    - Defaults to `0.1`{:.n}
- `.stalactiteBluntness(provider: FloatProvider)`{: .language-kube-21 #{{ page.anchor }}-stalactite-bluntness }: The bluntness/truncation of stalactites as a [[ float ]]
    - Higher values lead to shorter height
    - Must be {% in_range 0.1,10 %}
    - [[ required ]]
- `.stalagmiteBluntness(provider: FloatProvider)`{: .language-kube-21 #{{ page.anchor }}-stalagmite-bluntness }: The bluntness/truncation of stalagmites as a [[ float ]]
    - Higher values lead to shorter height
    - Must be {% in_range 0.1,10 %}
    - [[ required ]]
- `.windSpeed(provider: FloatProvider)`{: .language-kube-21 #{{ page.anchor }}-wind-speed }: The inclination of the feature as a [[ float ]]
    - Must be {% in_range 0,2 %}
    - [[ required ]]
- `.minRadiusForWind(radius: int)`{: .language-kube-21 #{{ page.anchor }}-min-radius-for-wind }: The minimum column radius for wind to cause an inclination
    - Must be {% in_range 0,100 %}
    - [[ required ]]
- `.minBluntnessForWind(bluntness: float)`{: .language-kube-21 #{{ page.anchor }}-min-bluntness-for-wind }: The minimum bluntness value wind to cause an inclination
    - Must be {% in_range 0,5 %}
    - [[ def_0 ]]
