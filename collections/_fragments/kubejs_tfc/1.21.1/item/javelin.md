---
title: Javelin
anchor: javelin
type: tfc:javelin
cat:
    - kubejs_tfc
    - 1.21.1
    - item
example:
    - .thrownTexture('tfc:block/metal/smooth/blue_steel')
    - .thrownDamage(12)
    - .guiModel('kubejs:item/blue_stick')
---

Creates a new javelin item

Inherits the methods of the [chisel item builder](#chisel)

{: #{{ page.anchor }}-methods }

## Extra Methods

- `.customHeldModel()`{: .language-kube-21 #{{ page.anchor }}-custom-held-model }: Prevent an extension, which renders the thrown javelin entity in the hand in first and third person, from being registered
- `.thrownTexture(texture: ResourceLocation)`{: .language-kube-21 #{{ page.anchor }}-thrown-texture }: Set the texture used for the thrown entity of the javelin
- `.throwingModel(model: ResourceLocation)`{: .language-kube-21 #{{ page.anchor }}-throwing-model }: Set the model to use while throwing/charging the javelin
- `.thrownDamage(damage: number)`{: .language-kube-21 #{{ page.anchor }}-thrown-damage }: Set the base damage the javelin inflicts when in entity form. Defaults to 1.5 times the javelin's tier attack damage bonus
- `.skeletonWeapon()`{: .language-kube-21 #{{ page.anchor }}-skeleton-weapon }: Allow skeletons to spawn with the javelin by adding it to the `tfc:skeleton_weapons` tag
- `.modelAtPerspective(perspective: ItemDisplayContext, model: ResourceLocation)`{: .language-kube-21 #{{ page.anchor }}-model-at-perspective }: Set the model to display at a specific display context
- `.fullModelAtPerspective(perspective: ItemDisplayContext, model: Consumer<ModelGenerator>)`{: .language-kube-21 #{{ page.anchor }}-full-model-at-perspective }: Set the model generation at a specific display context
- `.guiModel(model: ResourceLocation)`{: .language-kube-21 #{{ page.anchor }}-gui-model }: Set the model to display in the `none`{:.e}, `fixed`{:.e}, `ground`{:.e}, and `gui`{:.e} display contexts
- `.guiFullModel(model: Consumer<ModelGenerator>)`{: .language-kube-21 #{{ page.anchor }}-gui-full-model }: Set the model generation for the `none`{:.e}, `fixed`{:.e}, `ground`{:.e}, and `gui`{:.e} display contexts
