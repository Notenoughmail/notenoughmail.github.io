---
title: Series
anchor: series
cat:
    - worldjs
    - 1.21.1
    - biome_squisher
example: |-
    .squishers([ 'kubejs:squisher' ])
    .withSquisher('kubejs:evil', builder => {
        builder.biome('kubejs:evil')
        builder.injection({}, 0.15)
    })
    .levels([ 'minecraft:overworld ])
---

A series defines which [squishers]([[ squisher ]]) to apply to levels

- `.squishers(squishers: List<ResourceKey<Squisher>>)`{: .language-kube-21 #{{ page.anchor }}-squishers }: The squishers to apply to the levels
- `.withSquisher(id: ResourceKey<Squisher>, builder: Consumer<SquisherBuilder>)`{: .language-kube-21 #{{ page.anchor }}-with-squisher }: Creates and adds a squisher to the series
    - `id: ResourceKey<Squisher`{:.language-kube-21}: The id of the squisher to create
    - `builder: Consumer<SquisherBuilder>`{:.language-kube-21}: A callback for editing the properties of the squisher, properties can be found on the [dedicated section](#[[ squish ]])
- `.levels(levels: List<ResourceKey<LevelStem>>)`{: .language-kube-21 #{{ page.anchor }}-levels }: The levels to apply the squishers to

{: .notice #{{ page.anchor }}-order-note }
> Series applied to a level are applied in alphabetical order
