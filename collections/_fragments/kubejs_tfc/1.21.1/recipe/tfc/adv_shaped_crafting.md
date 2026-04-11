---
title: Advanced Shaped Crafting
anchor: shaped
func: shaped
mod: tfc
group: zzz_crafting
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For crafting recipes which have an [[ isp ]] result
example:
    - "'minecraft:obsidian',"
    - "["
    - "    'SA'"
    - "],"
    - "{"
    - "    S: 'minecraft:lava_bucket',"
    - "    A: 'minecraft:water_bucket'"
    - "}"
example_add:
    - ".remainder(TFC.isp.empty()"
sig:
    - "result: ItemStackProvider,"
    - "pattern: List<String>"
    - "key: Map<char, Ingredient>"
sig_add:
    - ".remainder(remainder: ItemStackProvider)"
    - ".showNotification(showNotification: boolean)"
    - ".inputRow(inputRow: int)"
    - ".inputColumn(inputColumn: int)"
    - ".inputPosition(inputRow: int, inputColumn: int)"
    - ".noNotification()"
---

- 1st argument: An [[ isp ]], the recipe result
- 2nd argument: A list of string, the recipe pattern
- 3rd argument: A `char`{:.p} to ingredient map, specifying the ingredients in the pattern

<span></span>

- `.remainder(remainder: ItemStackProvider)`{: .language-kube-21 #{{ page.anchor }}-remainder }: Accepts an [[ isp ]], the provider to apply to all inputs with the same item as the primary input
- `.showNotification(showNotification: boolean)`{: .language-kube-21 #{{ page.anchor }}-show-notification }: If the player should receive a toast when they unlock the recipe. Defaults to `true`{:.p}
- `.inputRow(inputRow: int)`{: .language-kube-21 #{{ page.anchor }}-input-row }: Accepts a non-negative integer number, the row index the primary ingredient is located. Defaults to `0`{:.n}
- `.inputColumn(inputColumn: int)`{: .language-kube-21 #{{ page.anchor }}-input-column }: Accepts a non-negative integer number, the column index the primary ingredient is located. Defaults to `0`{:.n}
- `.inputPosition(inputRow: int, inputColumn: int)`{: .language-kube-21 #{{ page.anchor }}-input-position }: Accepts two non-negative integer numbers, the row and column index of the primary ingredient
- `.noNotification()`{: .language-kube-21 #{{ page.anchor }}-no-notification }: Disables the player receiving a toast about unlocking the recipe

{: .related #{{ page.anchor }}-alias-notice }
> The recipe method present here is an alias for the 'official' recipe type, `.tfc.advanced_shaped_crafting(...)`{:.language-kube-21}. Both may be used in placed of each other as they have the same methods and semantics
