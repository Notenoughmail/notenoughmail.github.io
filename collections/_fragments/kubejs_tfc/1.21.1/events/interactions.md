---
type: startup
name: interactions
title: Interactions
anchor: interactions
cat:
    - kubejs_tfc
    - 1.21.1
    - event
example:
    - event.register('minecraft:diamond', 'blocks', (stack, ctx) => {
    - "    if (ctx.getLevel().getBlockState(ctx.getClickedPos()).hasTag('kubejs:can_accept_diamonds')) {"
    - "        ctx.getLevel().setBlockAndUpdate(ctx.getClickedPos(), 'kubejs:diamond_encrusted_block')"
    - "        return 'success'"
    - '    }'
    - "    return 'pass'"
    - '})'
---

TFC has a custom system for performing certain interactions with items, most notably knapping and ingot piling. This event exposes the ability to define custom interactions

{: #{{ page.anchor }}-methods }

## Methods

- `.registerBlockPlacement(item: Item, block: Block)`{: .language-kube-21 #{{ page.anchor }}-register-block-placement }: Register a block-item placement
- `.register(ingredient: Ingredient, target: InteractionManager$Target, action: OnItemUseAction): void`{: .language-kube-21 #{{ page.anchor }}-register }: Registers the given [action](#{{ page.anchor }}-action) for the specified [target](#{{ page.anchor }}-target) and ingredient
- `.registerKeyed(filter: Predicate<ItemStack>, items: Supplier<Collection<Item>>, target: InteractionManager$Target, action: OnItemUseAction): void`{: .language-kube-21 #{{ page.anchor }}-register-keyed }: Registers the given [action](#{{ page.anchor }}-action) for the specified [target](#{{ page.anchor }}-target) with a specific item filter than can be more flexible than ingredients
    - `filter: Predicate<ItemStack>`{:.language-kube-21}: Validation for if the action should run for a given stack, the item is guaranteed to be in the collection reified from `items`{:.v}
    - `items: Supplier<Collection<Item>>`{:.language-kube-21}: The items the action could *possibly* apply to
    - `target: InteractionManager$Target`{:.language-kube-21}: The player click target the action is valid for
    - `action: OnItemUseAction`{:.language-kube-21}: The action to perform upon item use
- `.registerAbility(ability: ItemAbility, target: InteractionManager$Target, action: OnItemUseAction)`{: .language-kube-21 #{{ page.anchor }}-register-ability }: Registers the given [action](#{{ page.anchor }}-action) for the specified [target](#{{ page.anchor }}-target) and item ability
    - `ability: ItemAbility`{:.language-kube-21}: A NeoForge [`ItemAbility`](https://docs.neoforged.net/docs/1.21.1/items/tools#itemabilitys), the ability the item must have to perform this action
    - `target: InteractionManager$Target`{:.language-kube-21}: The player click target the action is valid for
    - `action: OnItemUseAction`{:.language-kube-21}: The action to perform upon item use

{: #{{ page.anchor }}-target }

## `InteractionManager$Target`{:.e}

An enum with three values, `air`{:.e}, `blocks`{:.e}, and `both`{:.e}. Determines if a player may be looking at air/a block to perform the action

{: #{{ page.anchor }}-action }

## `OnItemUseAction`{:.f}

`OnItemUseAction`{:.f} is a function interface which can be created via a callback with the params

- `stack: ItemStack`{:.language-kube-21}: The stack the player used
- `context: UseOnContext`{:.language-kube-21}: The context of the use event
- `return: InteractionResult`{:.language-kube-21}: The result of using the item. `pass`{:.e} will let vanilla/default behavior run afterwards
