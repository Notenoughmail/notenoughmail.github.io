---
type: server
name: startFire
title: Start Fire
anchor: start-fire
cat:
    - kubejs_tfc
    - 1.21.1
    - event
example:
    - if (event.isStrong()) {
    - "    event.getPlayer().notify("
    - "        Text.warn('Arsonist!'),"
    - "        Text.of('So you like to play with fire, eh?')"
    - '    )'
    - '}'
---

This event is fired whenever a block is lit on fire and can be cancelled to handle lighting of an external device or source

{: #{{ page.anchor }}-methods }

## Methods

- `.getLevel(): Level`{: .language-kube-21 #{{ page.anchor }}-get-level }: Get the level the fire was started in
- `.getPos(): BlockPos`{: .language-kube-21 #{{ page.anchor }}-get-pos }: Get the position being ignited
- `.getTargetedFace(): Direction`{: .language-kube-21 #{{ page.anchor }}-get-targeted-face }: Gets the block face clicked to ignite the block
- `.getPlayer(): @Nullable Player`{: .language-kube-21 #{{ page.anchor }}-get-player }: Get the player that started the fire, if present
- `.getItem(): ItemStack`{: .language-kube-21 #{{ page.anchor }}-get-item }: Get the item used to ignite the fire
- `.isStrong(): boolean`{: .language-kube-21 #{{ page.anchor }}-is-strong }: If the fire is considered strong, and will place a fire block. If the event is strong and is cancelled a fire block will not be placed but TFC's `LIT` advancement trigger will still play
- `.cancel(): void`{: .language-kube-21 #{{ page.anchor }}-cancel }: Cancel the ignition, exact behavior depends on block
