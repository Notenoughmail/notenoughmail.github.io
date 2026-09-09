---
title: Rock Setting
anchor: rock-setting
cat:
    - kubejs_tfc
    - 1.21.1
    - reg
desc: Rock settings define a collection of blocks that can be used for a rock layer in TFC's world generation
reg: 'tfc:worldgen/rock_settings'
group: ServerEvents
name: vanilla
example: |-
    .raw('minecraft:stone')
    .hardened('minecraft:deepslate')
    .gravel('minecraft:gravel')
    .cobble('minecraft:cobblestone')
    .sand('minecraft:sand')
    .sandstone('minecraft:sandstone')
    .mafic()
---

- `.raw(b: Block)`{: .language-kube-21 #{{ page.anchor }}-raw }: The raw block of the setting
    - [[ required ]]
- `.hardened(b: Block)`{: .language-kube-21 #{{ page.anchor }}-hardened }: The hardened block of the setting
    - [[ required ]]
- `.gravel(b: Block)`{: .language-kube-21 #{{ page.anchor }}-gravel }: The gravel block of the setting
    - [[ required ]]
- `.cobble(b: Block)`{: .language-kube-21 #{{ page.anchor }}-cobble }: The cobble block of the setting
    - [[ required ]]
- `.sand(b: Block)`{: .language-kube-21 #{{ page.anchor }}-sand }: The sand block of the setting
    - [[ required ]]
- `.sandstone(b: Block)`{: .language-kube-21 #{{ page.anchor }}-sandstone }: The sandstone block of the setting
    - [[ required ]]
- `.spike(b: Block)`{: .language-kube-21 #{{ page.anchor }}-spike }: The spike block of the setting
    - Requires TFC's [spike part]({% link kubejs_tfc/1.21.1/blocks.md %}#rock-spike) block state property
- `.loose(b: Block)`{: .language-kube-21 #{{ page.anchor }}-loose }: The loose rock block of the setting
    - Requires TFC's [rock count]({% link kubejs_tfc/1.21.1/blocks.md %}#loose-rock) block state property
- `.mossyLoose(b: Block)`{: .language-kube-21 #{{ page.anchor }}-mossy-loose }: The mossy loose rock block of the setting
    - Requires TFC's [rock count]({% link kubejs_tfc/1.21.1/blocks.md %}#loose-rock) block state property
- `.karst()`{: .language-kube-21 #{{ page.anchor }}-karst }: Marks the setting as being karst
- `.mafic()`{: .language-kube-21 #{{ page.anchor }}-mafic }: Marks the setting as being mafic
