---
title: Sapling
anchor: sapling
type: tfc:sapling
name: coral_sapling
cat:
    - kubejs_tfc
    - 1.21.1
    - block
example:
    - .placeableOnSand()
    - .tree('tfc:coral_mushroom')
---

Creates a new sapling block

Inherits the methods of the default block builder

{: #sapling-methods }

## Extra Methods

- `.placeableOnSand()`{: .language-kube-21 #sapling-placeable-on-sand }: Allows the sapling to be placed on sand
- `.growthDays(days: int)`{: .language-kube-21 #sapling-growth-days }: Set the number of days the sapling needs to grow
- `.growthDaysSupplier(days: Supplier<int>)`{: .language-kube-21 #sapling-growth-days-supplier }: Set the number of days the sapling needs to grow via a supplier
- `.trees(secondaryChance: number, tree: @Nullable ResourceLocation, secondaryTree: @Nullable ResourceLocation, megaTree: @Nullable ResourceLocation, secondaryMegaTree: @Nullable ResourceLocation, flowers: @Nullable ResourceLocation, secondaryFlowers: @Nullable ResourceLocation)`{: .language-kube-21 #sapling-tree }: Set the tree features of the sapling
    - `secondaryChance: number`{:.language-kube-21}: The chance, {% in_unit %}, that the secondary tree/mega tree/flowers is grown
    - `tree: @Nullable ResourceLocation`{:.language-kube-21}: The id of a configured feature, the basic tree of the sapling
    - `secondaryTree: @Nullable ResourceLocation`{:.language-kube-21}: The id of a configured feature, the secondary tree of the sapling
    - `megaTree: @Nullable ResourceLocation`{:.language-kube-21}: The id of a configured feature, the mega tree of the sapling. For 2 x 2 arrangements of saplings
    - `secondaryMegaTree: @Nullable ResourceLocation`{:.language-kube-21}: The id of a configured feature, the secondary mega tree of the sapling. For 2 x 2 arrangements of saplings
    - `flowers: @Nullable ResourceLocation`{:.language-kube-21}: The id of a configured feature, the tree to place when there are flowers nearby at growth time
    - `secondaryFlowers: @Nullable ResourceLocation`{:.language-kube-21}: The id of a configured feature, the secondary tree to place when there are flowers nearby at growth time
- `.tree(tree: ResourceLocation)`{: .language-kube-21 #sapling-tree }: Set the tree of the sapling, accepts the id of a configured feature
- `.extendedProperties(extendedProperties: Consumer<ExtendedProperties>)`{: .language-kube-21 #sapling-tree }: Set the [extended properties](#extended-properties) of the sapling
