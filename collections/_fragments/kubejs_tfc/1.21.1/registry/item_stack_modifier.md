---
title: Item Stack Modifier
anchor: item-stack-modifier
cat:
    - kubejs_tfc
    - 1.21.1
    - reg
desc: Item stack modifiers are used by [`ItemStackProvider`s]({% link kubejs_tfc/1.21.1/type-explanations.md %}#item-stack-provider) to modify a stack, typically at the completion of a recipe
reg: 'tfc:item_stack_modifiers'
name: copy_cheese
example: |-
    .applicatorWithInput((stack, input, ctx) => {
        if (input.has('cheese_mod:cheese')) {
            stack.patch({
                'cheese_mod:cheese': input.get('cheese_mod:cheese')
            })
        }
        return stack
    })
---

- `.applicator(applicator: BiFunction<ItemStack, StackModifierContext, ItemStack>)`{: .language-kube-21 #{{ page.anchor }}-applicator }: The behavior of the modifier, a callback with the params
    - `stack: ItemStack`{:.language-kube-21}: The original output stack, may be freely modified
    - `context: StackModifierContext`{:.language-kube-21}: The context under which the modifier is being applied, may be either `default`{:.e} or `no_random_chance`{:.e}
    - `return: ItemStack`{:.language-kube-21}: The modified output item stack
- `.applicatorWithInput(applicator: TriFunction<ItemStack, ItemStack, StackModifierContext, ItemStack>)`{: .language-kube-21 #{{ page.anchor }}-applicator-with-input }: The behavior of the modifier, a callback with the params
    - `stack: ItemStack`{:.language-kube-21}: The original output stack, may be freely modified
    - `input: ItemStack`{:.language-kube-21}: The input stack, should not be modified in any way
    - `context: StackModifierContext`{:.language-kube-21}: The context under which the modifier is being applied, may be either `default`{:.e} or `no_random_chance`{:.e}
    - `return: ItemStack`{:.language-kube-21}: The modified output item stack
- `.applicatorWithInventory(applicator: QuadFunction<ItemStack, ItemStack, StackModifierContext, Iterable<ItemStack>, ItemStacl>)`{: .language-kube-21 #{{ page.anchor }}-applicator-with-inventory}: The behavior of the modifier, a callback with the params
    - `stack: ItemStack`{:.language-kube-21}: The original output stack, may be freely modified
    - `input: ItemStack`{:.language-kube-21}: The input stack, should not be modified in any way
    - `context: StackModifierContext`{:.language-kube-21}: The context under which the modifier is being applied, may be either `default`{:.e} or `no_random_chance`{:.e}
    - `inventory: Iterable<ItemStack>`{:.language-kube-21}: An [iterable](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Iterable.html) view of the inventory's items
    - `return: ItemStack`{:.language-kube-21}: The modified output item stack
