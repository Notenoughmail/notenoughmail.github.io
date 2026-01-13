---
title: Leaves
anchor: leaves
group: _
type: tfc:leaves
cat:
    - kubejs_tfc
    - 1.21.1
    - block
example:
    - .twig('minecraft:cobblestone')
    - .autumnIndex(29)
    - .texture('minecraft:block/oak_leaves')
    - .fallenLeaves(fallen => {
    - "    fallen.texture('minecraft:block/spruce_leaves')"
    - "    fallen.noDynamicTinting()"
    - '})'
---

Creates a new TFC leaf block

Inherits the methods of the default block builder

{: #{{ page.anchor }}-methods }

## Extra Methods

- `.fallenLeaves(fallenLeaves: @Nullable Consumer<FallenleavesBlockBuidler>)`{: .language-kube-21 #{{ page.anchor }}-fallen-leaves }: Set the properties of the fallen leaves associated with the leaves. `null`{:.p} is accepted to have to fallen leaves. Accepts a consumer with the following methods
    - `.models(models: BiConsumer<FallenLeavesModelType, ModelGenerator>)`{:.language-kube-21}: Set the model generation of the fallen leaves block. Accepts a callback with two parameters, the second being a model generator and the first having the following fields
        - `.layers: int`{:.language-kube-21}: How many layers the model is for, {% in_range 1,8 %}
        - `.parentModel: ResourceLocation`{:.language-kube-21}: The default parent model for the model
    - `.autumnIndex(index: int)`{:.language-kube-21}: Set the vertical coordinate, {% in_range 0,255 %}, on TFC's `foilage_fall` colormap the fallen leaves use for dynamic tinting
    - `.seasonalColors()`{:.language-kube-21}: Make the dynamic tinting of the fallen leaves change with the seasons
    - `.noDynamicTinting()`{:.language-kube-21}: Remove all dynamic tinting that is applied to the fallen leaves by default
    - `.extendedProperties(extendedProperties: Consumer<ExtendedProperties>)`{:.language-kube-21}: Set the [extended properties](#extended-properties) of the fallen leaves
    - All those of the default block builder
- `.twig(twig: Holder<Block>)`{: .language-kube-21 #{{ page.anchor }}-twig }: Set the twig block to place when the leaves are broken
- `.autumnIndex(index: int)`{: .language-kube-21 #{{ page.anchor }}-autumn-index }: Set the vertical coordinate, {% in_range 0,255 %} on TFC's `foliage_fall` colormap the leaves use for dynamic tinting
- `.seasonalColors()`{: .language-kube-21 #{{ page.anchor }}-seasonal-colors }: Make the dynamic tinting of the leaves change with the seasons
- `.noDynamicTinting()`{: .language-kube-21 #{{ page.anchor }}-no-dynamic-tinting }: remove all dynamic tinting that is applied to the leaves by default
- `.extendedProperties(extendedProperties: Consumer<ExtendedProperties>)`{: .language-kube-21 #{{ page.anchor }}-extended-properties }: Set the [extended properties](#extended-properties) of the leaves block
