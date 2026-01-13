---
type: server
name: log
title: Log
anchor: log
cat:
    - kubejs_tfc
    - 1.21.1
    - event
example:
    - if (event.getPos().getY() > 80) {
    - '    event.cancel()'
    - '}'
---

This event fires whenever a natural log block is broken, prompting the tree to be felled

{: #{{ page.anchor }}-methods }

## Methods

- `.getLevel(): Level`{: .language-kube-21 #{{ page.anchor }}-get-level }: Get the level the logging occurred in
- `.getAxe(): ItemStack`{: .language-kube-21 #{{ page.anchor }}-get-axe }: Get the axe item use
- `.getPos(): BlockPos`{: .language-kube-21 #{{ page.anchor }}-get-pos }: Get the position where a log block was broken
- `.getState(): BlockState`{: .language-kube-21 #{{ page.anchor }}-get-state }: Get the block that was broken
- `.cancel(): void`{: .language-kube-21 #{{ page.anchor }}-cancel }: Prevent the entire tree from being felled, only the initial block will be broken
