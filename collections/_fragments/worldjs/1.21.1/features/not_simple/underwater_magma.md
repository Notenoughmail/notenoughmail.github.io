---
title: Underwater Magma
anchor: underwater-magma
type: underwater_magma
wiki_link: https://minecraft.wiki/w/Underwater_Magma?oldid=3427727
sprite: BlockSprite
icon: magma-block
cat:
    - worldjs
    - 1.21.1
    - feature
example:
    - // TODO
---

[[ base ]]

- `.floorSearchRange(range: int)`{: .language-kube-21 #{{ page.anchor }}-floor-search-range }: The maximum distance to search for a placement position
    - Must be {% in_range 0,512 %}
    - [[ def_0 ]]
- `.placementRadiusAroundFloor(radius: int)`{: .language-kube-21 #{{ page.anchor }}-placement-radius-around-floor }: The radius around the selected position to potentially place magma
    - Must be {% in_range 0,64 %}
    - [[ def_0 ]]
- `.placementProbabilityPerValidPosition(probability: float)`{: .language-kube-21 #{{ page.anchor }}-The probability of a magma block being placed at any given selected position
    - [[ unit ]]
    - [[ def_0 ]]
