---
title: 'minecraft:checkerboard'
anchor: biome-source-checkerboard
cat:
    - worldjs
    - 1.21.1
    - biome_source
---

Places biomes in a [checkerboard pattern](https://minecraft.wiki/w/Dimension_definition#checkerboard)

- `.size(size: int)`{: .language-kube-21 #{{ page.anchor }}-size }: The size of the checkerboard grid
    - Must be {% in_range 0,62 %}
    - Defaults to `2`{:.n}
- `.biomes(biomes: HolderSet<Biome>)`{: .language-kube-21 #{{ page.anchor }}-biomes }: The biomes to place in the world
    - [[ required ]]
