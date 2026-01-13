---
type: server
name: douseFire
title: Douse Fire
anchor: douse-fire
cat:
    - kubejs_tfc
    - 1.21.1
    - event
example:
    - if (event.getState().hasTag('kubejs:remove_on_douse')) {
    - '    event.getLevel().removeBlock(event.getPos(), false)'
    - '    event.cancel()'
    - '}'
---

This event fires whenever a block is extinguished via the `shovel_douse` item ability or a thrown bottle or water lands. A single dousing action may affect multiple blocks, in such case this event will fire once per block within the dousing [bounds](#{{ page.anchor }}-get-bounds)

{: #{{ page.anchor }}-methods }

## Methods

- `.getLevel(): Level`{: .language-kube-21 #{{ page.anchor }}-get-level }: Get the level where the dousing is happening
- `.getPos(): BlockPos`{: .language-kube-21 #{{ page.anchor }}-get-pos }: Get the position being doused
- `.getState(): BlockState`{: .language-kube-21 #{{ page.anchor }}-get-state }: Get the state at the doused position
- `.getBounds(): AABB`{: .language-kube-21 #{{ page.anchor }}-get-bounds }: The full bounds of the dousing action
- `.getPlayer(): @Nullable Player`{: .language-kube-21 #{{ page.anchor }}-get-player }: Get the player performing the dousing action, if available
- `.cancel(): void`{: .language-kube-21 #{{ page.anchor }}-cancel }: Cancel the dousing action at the position
