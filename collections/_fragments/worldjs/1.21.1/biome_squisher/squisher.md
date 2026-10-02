---
title: Squisher
anchor: squisher
cat:
    - worldjs
    - 1.21.1
    - biome_squisher
example: |-
    .injection(
        {
            temperature: {
                position: 0.4
            },
            erosion: {
                min: -0.3,
                max: 0.8
            }
        },
        0.2
    )
    .biome('kubejs:juice')
    .noSnap()
---

A squisher defines how and where a biome is injected

{% list ranges %}
{% continentalness %}
{% erosion %}
{% depth %}
{% weirdness %}
{%endlist %}

{% list squishes %}
{% temperature %}
{% humidity %}
{% endlist %}

- `.injection(biomeSpace: BiomeSpace, radius: number)`{: .language-kube-21 #{{ page.anchor }}-injection }: The injection behavior of the squisher
    - `biomeSpace: BiomeSpace`{:.language-kube-21}: The region in biome space to inject at, can be made as a map of parameters to values
        {% for squish in squishes %}- `{{ squish }}?: Squish`{:.language-kube-21}: The position on the {{ squish }} axis to inject the biome at, can be made as a map of parameters to values
            - `position?: number`{:.language-kube-21}: The positon on the {{ squish }} axis to inject at
                - [[ def_0 ]]
            - `degree?: number`{:.language-kube-21}: The 'shape factor' of the {{ squish }} injection, allows for non-square injections
                - [[ def_1 ]]
            - *Optional, defaults to the above mentioned defaults*
        {% endfor %}
        {% for range in ranges %}
        - `{{ range }}?: Range`{:.language-kube-21}: The range of {{ range }} values the biome will be injected at, can be made as a map of parameters to values
            - `min?: number`{:.language-kube-21}: The minimum value along the {{ range }} axis
                - [[ def_l ]]
            - `max?: number`{:.language-kube-21}: The maximum value along the {{ range }} axis
                - [[ def_h ]]
            - *Optional, defaults to the above mentioned defaults*{% endfor %}
    - `radius: number`{:.language-kube-21}: How large the injection should be, where `1`{:.n} is the entire biome space
        - [[ unit ]]
- `.biome(biome: Holder$Reference<Biome>)`{: .language-kube-21 #{{ page.anchor }}-biome }: The biome to inject
- `.relative(temperature: @Nullable Position, humidity: @Nullable Position)`{: .language-kube-21 #{{ page.anchor }}-relative }: The relative positioning of the squsiher
    - Used to determine which squsiher to use when multiple injectat the same point
    - At least one of the values must be non-`null`{:.p} and non-`center`{:.e}
- `.noSnap()`{: .language-kube-21 #{{ page.anchor }}-no-snap }: If the injection should snap to a biome edge/corner within its bounds, if one is present
