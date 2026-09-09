---
title: Chisel Mode
anchor: chisel-mode
cat:
    - kubejs_tfc
    - 1.21.1
    - reg
desc: Chisel modes are used when [chiseling]({% link kubejs_tfc/1.21.1/recipes.md %}#chisel)
reg: 'tfc:chisel_mode'
name: my_chisel_mode
example: |-
    .hotbarIcon('kubejs:block/my_chisel_mode/hotbar', 0, 0)
    .recipeIcon('kubejs:block/my_chisel_mode/recipe', 0, 0, 20, 20)
    .chiselBehavior((original, chiseled, player, hit) => {
        if (original.hasBlockEntity()) {
            return null
        } else {
            return chiseled
        }
    })
---

- `.priority(priority: int)`{: .language-kube-21 #{{ page.anchor }}-priority }: Sets the 'priority' of the chisel mode when sorting chisel modes for cycling
    - Defaults to `300`{:.n}
- `.hotbarIcon(textureLocation: ResourceLocation, x: int, y: int)`{: .language-kube-21 #{{ page.anchor }}-hotbar-icon }: Sets the texture to use when displayed in the hotbar. Draws the 20 x 20 pixel area at the x and y coordinate
- `.recipeIcon(textureLocation: ResourceLocation, x: int, y: int, width: int, height: int)`{: .language-kube-21 #{{ page.anchor }}-recipe-icon }: Sets the texture to use when displayed in recipe viewers
- `.chiselBehavior(behavior: ChiselBehavior)`{: .language-kube-21 #{{ page.anchor }}-chisel-behavior }: Sets the behavior when chiseling is performed. Accepts a callback with the params
    - `original: BlockState`{:.language-kube-21}: The original state being chiseled
    - `chiseled: BlockState`{:.language-kube-21}: The chiseled state specified by the recipe
    - `player: Player`{:.language-kube-21}: The player chiseling
    - `hit: BlockHitResult`{:.language-kube-21}: The hit result of the player
    - `return: @Nullable BlockState`{:.language-kube-21}: The chiseled state to place in-world
        - May be `null`{:.p} to indicate an invalid value and cancel the recipe
    Defaults to returning the `chiseled`{:.v} state
