---
layout: none
s: month
title: '`Month`{:.e} Enum'
preserve-color: true
anchor: month-enum
cat:
    - kubejs_tfc
    - 1.21.1
    - type_exp
---

If you didn't know, there are 12 [months](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/util/calendar/Month.java). Each month has values for

- The Northern hemisphere temperature modifier, {% in_range -1,1 %}
- The season

- `january`{: .e #{{ page.anchor }}-january }; ordinal `0`{:.n}
    - Modifier: `-1`{:.n}
    - Season: `winter`{:.e}
- `february`{: .e #{{ page.anchor }}-february }; ordinal `1`{:.n}
    - Modifier: `-0.866`{:.n}
    - Season: `winter`{:.e}
- `march`{: .e #{{ page.anchor }}-march }; ordinal `2`{:.n}
    - Modifier" `-0.5`{:.n}
    - Season: `spring`{:.e}
- `april`{: .e #{{ page.anchor }}-april }; ordinal `3`{:.n}
    - Modifier: `0`{:.n}
    - Season: `spring`{:.e}
- `may`{: .e #{{ page.anchor }}-may }; ordinal `4`{:.n}
    - Modifier: `0.5`{:.n}
    - Season: `spring`{:.e}
- `june`{: .e #{{ page.anchor }}-june }; ordinal `5`{:.n}
    - Modifier: `0.866`{:.n}
    - Season: `summer`{:.e}
- `july`{: .e #{{ page.anchor }}-july }; ordinal `6`{:.n}
    - Modifier: `1`{:.n}
    - Season: `summer`{:.e}
- `august`{: .e #{{ page.anchor }}-august }; ordinal `7`{:.n}
    - Modifier: `0.866`{:.n}
    - Season: `summer`{:.e}
- `september`{: .e #{{ page.anchor }}-september }; ordinal `8`{:.n}
    - Modifier: `0.5`{:.n}
    - Season: `fall`{:.e}
- `october`{: .e #{{ page.anchor }}-october }; ordinal `9`{:.n}
    - Modifier: `0`{:.n}
    - Season: `fall`{:.e}
- `november`{: .e #{{ page.anchor }}-november }; ordinal `10`{:.n}
    - Modifier: `-0.5`{:.n}
    - Season: `fall`{:.e}
- `december`{: .e #{{ page.anchor }}-december }; ordinal `11`{:.n}
    - Modifier: `-0.866`{:.n}
    - Season: `fall`{:.e}
