---
title: Thin Spike
anchor: thin-spike
type: thin_spike
wiki_link: https://terrafirmacraft.github.io/Documentation/1.21.x/worldgen/features/#thin-spike
sort_pos: t
cat:
    - kubejs_tfc
    - 1.21.1
    - conf_feature
example: |-
    // TODO
---

[[ base ]]

- `.state(state: BlockState)`{: .language-kube-21 #{{ page.anchor }}-state }: The state to place, must be a [thin spike block]({% link kubejs_tfc/1.21.1/blocks.md %}#thin-spike)
    - Defaults to `'tfc:icicle'`{:.s}
- `.radius(r: int)`{: .language-kube-21 #{{ page.anchor }}-radius }: The radius around the target location to place spikes
    - Must be {% in_range 1,16 %}
    - [[ def_1 ]]
- `.tries(t: int)`{: .language-kube-21 #{{ page.anchor }}-tries }: The number of tries to attempt to place spikes
    - [[ pos ]]
    - [[ def_1 ]]
- `.height(min: int, max: int)`{: .language-kube-21 #{{ page.anchor }}-height }: The minimum and maximum heights of a spike
    - [[ pos ]]
    - `max`{:.v} must be greater than or equal to `min`{:.v}
    - Defaults to `1`{:.n} and `10`{:.n}
- `.allowedUnderwater(b: boolean)`{: .language-kube-21 #{{ page.anchor }}-allowed-underwater }: If the spike can place underwater
    - [[ def_f ]]
