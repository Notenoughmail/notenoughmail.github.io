---
title: Glass Operation
anchor: glass-operation
cat:
    - kubejs_tfc
    - 1.21.1
    - reg
desc: Glass operations are used in [glassworking recipes]({% link kubejs_tfc/1.21.1/recipes.md %}#glassworking) and are performed by specific [items]({% link kubejs_tfc/1.21.1/items.md %}#glassworking) and [tools]({% link kubejs_tfc/1.21.1/items.md %}#glassworking-tool)
reg: 'tfc:glass_operation'
name: my_operation
example: |-
    .powder('minecraft:block/cobblestone')
    .items('kubejs:stone_dust', 'kubejs:pulverized_mineral_sample')
---

- `.powder(texture: ResourceLocation)`{: .language-kube-21 #{{ page.anchor }}-powder }: Marks the operation as being associated with a powder item and sets the texture used in the powder bowl
- `.workingTemperature(temperature: number)`{: .language-kube-21 #{{ page.anchor }}-working-temperature }: Sets the minimum temperature, in °C, required to apply the operation
    - Defaults to `480`{:.n}
- `.applicationSound(sound: Holder<SoundEvent>)`{: .language-kube-21 #{{ page.anchor }}-use-sound }: Sets the sound[[ fn_sound ]] to use when the operation is applied
- `.items(items...: Holder<Item>[])`{: .language-kube-21 }: Sets the items associated with the operation, used for recipe viewers and, if a powder, powder bowls
