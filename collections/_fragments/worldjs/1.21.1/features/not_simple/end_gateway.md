---
title: End Gateway
anchor: end-gateway
type: end_gateway
wiki_link: https://minecraft.wiki/w/End_Gateway?oldid=3561994
sort_pos: e
cat:
    - worldjs
    - 1.21.1
    - feature
example:
    - // TODO
---

[[ base ]]

- `.exact(exact: boolean)`{: .language-kube-21 #{{ page.anchor }}-exact }: If entities should teleport to the exact exit position
    - Ignored if the [`exit`](#{{ page.anchor }}-exit) is not defined
    - Defaults to `false`{:.p}
- `.exit(pos: BlockPos)`{: .language-kube-21 #{{ page.anchor }}-exit }: Set the exit position of the gateway
