---
title: Windmill Blade
anchor: windmill-blade
type: tfc:windmill_blade
name: windmill
cat:
    - kubejs_tfc
    - 1.21.1
    - item
example:
    - .bladeColor(0x45F977)
---

Creates a new windmill blade item

Inherits the methods of the default item builder

{: #{{ page.anchor }}-methods }

## Extra Methods

- `.bladeColor(color: @Nullable KubeColor)`{: .language-kube-21 #{{ page.anchor }}-blade-color }: Set the blade color, defaults to `0xFFFFFF`{:.n}. Translucency is not supported
- `.bladeTexture(texture: ResourceLocation)`{: .language-kube-21 #{{ page.anchor }}-blade-texture }: Set the texture of the blade. Defaults to `tfc:entity/misc/windmill_blade`
