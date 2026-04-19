---
title: Add Cavers
anchor: add-legacy-carvers
type: add_carvers
name: add_cave_carvers
cat:
    - worldjs
    - 1.21.1
    - biome_mod
example:
    - ".biomes('#kubejs:needs_more_caves')"
    - ".step('air')"
    - ".carvers('#kubejs:special_cave_carvers')"
---

- [[ biomes ]]
- `.step(step: GenerationStep$Carving)`{: .language-kube-21 #{{ page.anchor }}-step }: The carving step to add the carver(s) to
    {% include enum_list.html summary='Reveal/hide list of valid carving steps' values='air,liquid' %}
- `.carvers(carvers: HolderSet<ConfiguredWorldCarver<?>>)`{: .language-kube-21 #{{ page.anchor }}-carvers }: Set the carver(s) to add to the biome(s)
