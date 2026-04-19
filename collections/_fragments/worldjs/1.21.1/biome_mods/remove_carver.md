---
title: Remove Carvers
anchor: removing-legacy-carvers
type: remove_carvers
name: remove_carvers
cat:
    - worldjs
    - 1.21.1
    - biome_mod
example:
    - ".biomes('#kubejs:needs_less_sharp_carvers')"
    - ".carvers('#kubejs:sharp_carvers')"
    - ".steps(["
    - "    'air'"
    - "])"
---

- [[ biomes ]]
- `.carvers(carvers: HolderSet<ConfiguredWorldCarver<?>>)`{: .language-kube-21 #{{ page.anchor }}-carvers }: Sets the carver(s) to be removed from the biome(s)
- `.steps(steps: Set<GenerationStep$Carving>)`{: .language-kube-21 #{{ page.anchor }}-steps }: Sets the carving step(s) to remove the carver(s) from
    {% include enum_list.html summary='Reveal/hide list of valid carving steps' values='air,liquid' %}
