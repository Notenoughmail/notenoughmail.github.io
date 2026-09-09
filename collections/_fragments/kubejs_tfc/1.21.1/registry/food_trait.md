---
title: Food Trait
anchor: food-trait
cat:
    - kubejs_tfc
    - 1.21.1
    - reg
desc: Food traits can be applied to food items to modify how long it takes them to expire
reg: 'tfc:food_trait'
name: my_trait
example: |-
    .decayModifier(0.5)
    .tooltipText('Well preserved')
---

- `.decayModifier(modifier: number)`{: .language-kube-21 #{{ page.anchor }}-decay-modifier }: Sets the decay modifier of the trait
    - A larger value results in a quicker expiry
    - [[ def_1 ]]
- `.decayModifierSupplier(modifier: Supplier<number>)`{: .language-kube-21 #{{ page.anchor }}-decay-modifier-supplier }: Sets the modifier of the trait as a supplier
    - Defaults to `() => 1`{:.language-kube-21}
- `.tooltipKey(key: String)`{: .language-kube-21 #{{ page.anchor }}-tooltip-key }: Gives the food trait a tooltip with the specified translation key
- `.tooltipText(text: Component)`{: .language-kube-21 #{{ page.anchor }}-tooltip-text }: Gives the food trait a tooltip with the given text, autogenerating a lang key if not already specified
