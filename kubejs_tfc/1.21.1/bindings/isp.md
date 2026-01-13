---
layout: page
title: ItemStackProvider Bindings
permalink: /kubejs_tfc/1.21.1/bindings/isp/
parent: Bindings
grand_parent: 1.21.1
desc: Bindings for creating [`ItemStackProvider`s]({% link kubejs_tfc/1.21.1/type-explanations.md %}#item-stack-provider) and certain related utilities
field: isp
---

# {{ page.title }}

{{ page.desc | render_liquid }}

```js-21
declare class ItemStackProviderBindings {

    // These are avaialble via TFC.isp.*

    of(stack: ItemStack, modifiers?: List<ItemStackModifier>): ItemStackProvider
    empty(): ItemStackProvider
    copyInputStack(): ItemStackProvider
    getCraftingPlayer(): @Nullable Player
    setCraftingInput(inventory: IItemHandler): void
    setCraftingInput(inventory: IItemHandler, startSlot: int, endSlot: int): void
    clearCraftingInput(): void
}
```

{% capture isp %}[`ItemStackProvider`]({% link kubejs_tfc/1.21.1/type-explanations.md %}#item-stack-provider){% endcapture %}

- `.of(stack: ItemStack, modifiers?: List<ItemStackModifier>)`{: .language-kube-21 #of }: Creates a new mutable {{ isp }} with the given stack and, if present, list of modifiers
- `.empty()`{: .language-kube-21 #empty }: Creates a new empty mutable {{ isp }}
- `.copyInputStack()`{: .language-kube-21 #copy-input-stack }: Creates a new empty mutable {{ isp }} with a `tfc:copy_input` modifier
- `.getCraftingPlayer()`{: .language-kube-21 #get-crafting-player }: Gets the current crafting player, or null if not present
- `.setCraftingInput(inventory: IItemHandler)`{: .language-kube-21 #set-crafting-input-0 }: Sets the current crafting input, a view of the inventory used by certain modifiers. Must call [`.clearCraftingInput()`{:.language-kube-21}](#clear-crafting-input){:.preserve-color} after modifiers have been applied
- `.setCraftingInput(inventory: IItemHandler, startSlot: int, endSlot: int)`{: .language-kube-21 #set-crafting-input-1 }: Sets the crafting input, a view of the inventory used by certain modifiers, as a subset of the inventory's slots. Must call [`.clearCraftingInput()`{:.language-kube-21}](#clear-crafting-input){:.preserve-color} after modifiers have been applied
- `.clearCraftingInput()`{: .language-kube-21 #clear-crafting-input }: Clears the crafting input

{% comment %}

## clear crafting input

{% endcomment %}
