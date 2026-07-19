---
title: Ore
anchor: ore
type: ore
wiki_link: https://minecraft.wiki/w/Ore_(feature)?oldid=3572987
sort_pos: o
cat:
    - worldjs
    - 1.21.1
    - feature
example: |-
    // TODO
---

[[ base ]]

- `.target(target: OreTarget)`{: .language-kube-21 #{{ page.anchor }}-target }: Adds an `OreTarget` to the feature's list of targets. `OreTarget`s can be made as an object with the fields
    - `target: RuleTest`{:.language-kube-21}: The [[ rule_test ]] that checks the block to replace
    - `state: BlockState`{:.language-kube-21}: the state to place if `target`{:.v} passes
- `.size(size: int)`{: .language-kube-21 #{{ page.anchor }}-size }: The size of the ore vein
    - Must be {% in_range 0,64 %}
    - [[ def_0 ]]
- `.discardChanceOnAirExposure(chance: number)`{: .language-kube-21 #{{ page.anchor }}-discard-chance-on-air-exposure }: The chance the whole ore blob is discarded if any of its blocks neighbor air
    - [[ unit ]]
    - [[ def_0 ]]
