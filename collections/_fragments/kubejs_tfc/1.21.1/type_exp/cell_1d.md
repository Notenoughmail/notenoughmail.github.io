---
s: cellular_1d
title: '`Cellular1D`'
anchor: cellular-1d
cat:
    - kubejs_tfc
    - 1.21.1
    - type_exp
---

`Cellular1D` is a 1 dimensional implementation of noise which has sections of constant value. They have several methods available

- `.noise(x: number): number`{: .language-kube-21 #{{ page.anchor }}-noise }: Gets the value of the noise at the given position
- `.spread(scaleFactor: number): Cellular1D`{: .language-kube-21 #{{ page.anchor }}-spread }: Scales the input coordinate of the noise function by the given scale factor
- `.cell(x: number): Cell`{: .language-kube-21 #{{ page.anchor }}-cell }: Gets the `Cell` at the given position, where `Cell` is an object with the methods
    - `.x(): number`{:.language-kube-21}: The X 'coordinate' of the cell center
    - `.cx(): number`{:.language-kube-21}: The X 'coordinate' of the cell center before jitter or scaling
    - `.nx(): number`{:.language-kube-21}: The X 'coordinate' of the neighboring cell
    - `.f1(): number`{:.language-kube-21}: The distance to the `.x()`{:.language-kube-21} value
    - `.f2()`{:.language-kube-21}: The distance of the `.nx()`{:.language-kube-21} value
    - `.noise()`{:.language-kube-21}: The noise value of the cell, {% in_unit %}
