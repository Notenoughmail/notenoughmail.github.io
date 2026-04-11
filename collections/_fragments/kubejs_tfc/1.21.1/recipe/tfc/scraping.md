---
title: Scraping
anchor: scraping
mod: tfc
group: s
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For scraping items on the open face of a log with a knife
example:
    - "'minecraft:pink_glazed_terracotta',"
    - "'minecraft:paper',"
    - "'minecraft:block/pink_glazed_terracotta',"
    - "'minecraft:block/white_glazed_terracotta'"
example_add:
    - ".extraDrop('minecraft:torch')"
sig:
    - "result: ItemStackProvider,"
    - "ingredient: Ingredient,"
    - "outputTexture: ResourceLocation,"
    - "inputTexture: ResourceLocation,"
    - "resultItem?: ItemStackProvider"
sig_add:
    - ".resultItem(resultItem: ItemStackProvider)"
    - ".extraDrop(resultItem: ItemStackProvider)"
---

- 1st argument: An [[ isp ]], the primary result of the recipe
- 2nd argument: An item ingredient, the item that will be scraped
- 3rd argument: A texture id, the texture to show in spots that have been scraped
- 4th argument: A texture id, the texture to shoe in spots that have not been scraped
- *Optional 5th argument*: An [[ isp ]], an additional item to drop upon completion of the recipe

<span></span>

- `.resultItem(resultItem: ItemStackProvider)`{: .language-kube-21 #{{ page.anchor }}-result-item }: Accepts an [[ isp ]], the additional item to drop upon completion of the recipe
- `.extraDrop(resultItem: ItemStackProvider)`{: .language-kube-21 #{{ page.anchor }}-extra-drop }: A simple alias to [`.resultItem(...)`{:.language-kube-21}](#scraping-result-item){:.preserve-color} meant to disambiguate `resultItem`{:.v} from `result`{:.v}
