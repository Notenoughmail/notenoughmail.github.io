---
title: Sculk Patch
anchor: sculk-patch
type: sculk_patch
wiki_link: https://minecraft.wiki/w/Sculk_Patch?oldid=3258303
sprite: BlockSprite
icon: sculk-vein
cat:
    - worldjs
    - 1.21.1
    - feature
example:
    - // TODO
---

[[ base ]]

- `.chargeCount(count: int)`{: .language-kube-21 #{{ page.anchor }}-charge-count }: The number of charges
    - Must be {% in_range 1,32 %}
    - [[ def_1 ]]
- `.amountPerCharge(amount: int)`{: .language-kube-21 #{{ page.anchor }}-amount-per-charge }: The initial value of each charge
    - Must be {% in_range 1,500 %}
    - [[ def_1 ]]
- `.spreadAttempts(attempts: int)`{: .language-kube-21 #{{ page.anchor }}-spread-attempts }: The number of attempts to spread
    - Must be {% in_range 0,64 %}
    - [[ def_1 ]]
- `.growthRounds(rounds: int)`{: .language-kube-21 #{{ page.anchor }}-growth-rounds }: The number of times to generate
    - Must be {% in_range 0,8 %}
    - [[ def_1 ]]
- `.spreadRounds(rounds: int)`{: .language-kube-21 #{{ page.anchor }}-spread-rounds }: The number of times to spread
    - Must be {% in_range 0,8 %}
    - [[ def_0 ]]
- `.extraRareGrowths(provider: IntProvider)`{: .language-kube-21 #{{ page.anchor }}-extra-rare-growths }: The number of extra shriekers to generate as an [[ int ]]
    - [[ required ]]
- `.catalystChance(chance: float)`{: .language-kube-21 #{{ page.anchor }}-catalyst-chance }: The chance of generating a catalyst
    - [[ unit ]]
    - [[ def_0 ]]
