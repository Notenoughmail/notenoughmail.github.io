---
title: Pipe Vein
anchor: pipe-vein
type: pipe_vein
wiki_link: https://terrafirmacraft.github.io/Documentation/1.21.x/worldgen/features/veins/#pipe-vein
sort_pos: v_p
cat:
    - kubejs_tfc
    - 1.21.1
    - conf_feature
example: |-
    // TODO
---

[[ cluster ]]

- `.size(r: int)`{: .language-kube-21 #{{ page.anchor }}-size }: The radius of the pipe
    - [[ pos ]]
    - Defaults to `3`{:.n}
- `.height(h: int)`{: .language-kube-21 #{{ page.anchor }}-height }: The height of the pipe
    - Defaults to `10`{:.n}
- `.radius(r: int)`{: .language-kube-21 #{{ page.anchor }}-radius }: The radius of the pipe
    - [[ pos ]]
    - Defaults to `3`{:.n}
- `.skew(min: int, max: int)`{: .language-kube-21 #{{ page.anchor }}-skew }: The skew range
    - Defaults to `-1`{:.language-kube-21} and `0`{:.n}
- `.slant(min: int, max: int)`{: .language-kube-21 #{{ page.anchor }}-slant }: The slant range
    - Defaults to `-1`{:.language-kube-21} and `0`{:.n}
- `.sign(s: number)`{: .language-kube-21 #{{ page.anchor }}-sign }: The sign of the slant
    - [[ unit ]]
    - [[ def_0 ]]
