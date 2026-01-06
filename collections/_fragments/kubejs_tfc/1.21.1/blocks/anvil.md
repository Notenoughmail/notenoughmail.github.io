---
title: Anvil
anchor: anvil
type: tfc:anvil
cat:
    - kubejs_tfc
    - 1.21.1
    - block
example:
    - .tier(9)
    - .texture('tfc:block/metal/smooth/gold')
---

Creates a new anvil block

Inherits the methods of the default block builder

{: #anvil-methods }

## Extra Method

- `.tier(tier: int)`{: .language-kube-21 #anvil-tier }: Set the tier of recipes the anvil can perform. Defaults to `0`{:.n}
- `.extendedProperties(properties: Consumer<ExtendedProperties>)`{: .language-kube-21 #anvil-extended-properties }: Set the [extended properties](#extended-properties) of the anvil
