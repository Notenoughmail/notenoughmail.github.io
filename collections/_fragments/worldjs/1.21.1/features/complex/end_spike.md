---
title: End Spike
anchor: end-spike
type: end_spike
wiki_link: https://minecraft.wiki/w/End_Spike?oldid=3566448
sort_pos: e
cat:
    - worldjs
    - 1.21.1
    - feature
example: |-
    // TODO
---

[[ base ]]

- `.invulnerableCrystals()`{: .language-kube-21 #{{ page.anchor }}-invulnerable-crystals }: Makes the placed crystals invulnerable
- `.crystalBeamTarget(pos: BlockPos)`{: .language-kube-21 #{{ page.anchor }}-crystal-beam-target }: The position the crystal beams target
- `.spike(centerX: int, centerZ: int, radius: int, height: int, guarded: boolean)`{: .language-kube-21 #{{ page.anchor }}-spike }: Add a spike to the list of generated spikes
    - `centerX: int`{:.language-kube-21}: The x coordinate of the spike
    - `centerZ: int`{:.language-kube-21}: The z coordinate of the spike
    - `radius: int`{:.language-kube-21}: The radius of the spike
    - `height: int`{:.language-kube-21}: The height of the spike
    - `guarded: boolean`{:.language-kube-21}: If the crystal should be surrounded by an iron bar cage
