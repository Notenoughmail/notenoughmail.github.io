---
title: Fossil
anchor: fossil
type: fossil
wiki_link: https://minecraft.wiki/w/Fossil?oldid=3568065
sort_pos: f
cat:
    - worldjs
    - 1.21.1
    - feature
example:
    - // TODO
---

[[ base ]]

- `.fossilStructures(structures: List<ResourceLocation>)`{: .language-kube-21 #{{ page.anchor }}-fossil-structures }: The ids of fossil structure templates to choose from
    - The list must be of the same length as [overlay structures](#{{ page.anchor }}-overlay-structures)
- `.overlayStructures(structures: List<ResourceLocation>)`{: .language-kube-21 #{{ page.anchor }}-overlay-structures }: The ids of overlay structure templates to choose from
    - The list must be of the same length as [fossil structures](#{{ page.anchor }}-fossil-structures)
- `.fossilProcessors(processors: Holder$Reference<StructureProcessorList>)`{: .language-kube-21 #{{ page.anchor }}-fossil-processors }: The fossil [[ struct_proc ]] to use
    - [[ required ]]
- `.overlayProcessors(processors: Holder$Reference<StructureProcessorList>)`{: .language-kube-21 #{{ page.anchor }}-overlay-processors }: The overlay [[ struct_proc ]] to use
    - [[ required ]]
- `.maxEmptyCorners(corners: int)`{: .language-kube-21 #{{ page.anchor }}-max-empty-corners }: How many corners may be empty while still allowing the structure to generate
    - Must be {% in_range 0,7 %}
    - [[ def_0 ]]
