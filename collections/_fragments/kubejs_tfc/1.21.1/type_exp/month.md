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

- `january`{: .e #month-january }; ordinal `0`{:.n}
    - Modifier: `-1`{:.n}
    - Season: `winter`{:.e}
- `february`{: .e #month-february }; ordinal `1`{:.n}
    - Modifier: `-0.866`{:.n}
    - Season: `winter`{:.e}
- `march`{: .e #month-march }; ordinal `2`{:.n}
    - Modifier" `-0.5`{:.n}
    - Season: `spring`{:.e}
- `april`{: .e #month-april }; ordinal `3`{:.n}
    - Modifier: `0`{:.n}
    - Season: `spring`{:.e}
- `may`{: .e #month-may }; ordinal `4`{:.n}
    - Modifier: `0.5`{:.n}
    - Season: `spring`{:.e}
- `june`{: .e #month-june }; ordinal `5`{:.n}
    - Modifier: `0.866`{:.n}
    - Season: `summer`{:.e}
- `july`{: .e #month-july }; ordinal `6`{:.n}
    - Modifier: `1`{:.n}
    - Season: `summer`{:.e}
- `august`{: .e #month-august }; ordinal `7`{:.n}
    - Modifier: `0.866`{:.n}
    - Season: `summer`{:.e}
- `september`{: .e #month-september }; ordinal `8`{:.n}
    - Modifier: `0.5`{:.n}
    - Season: `fall`{:.e}
- `october`{: .e #month-october }; ordinal `9`{:.n}
    - Modifier: `0`{:.n}
    - Season: `fall`{:.e}
- `november`{: .e #month-november }; ordinal `10`{:.n}
    - Modifier: `-0.5`{:.n}
    - Season: `fall`{:.e}
- `december`{: .e #month-december }; ordinal `11`{:.n}
    - Modifier: `-0.866`{:.n}
    - Season: `fall`{:.e}
