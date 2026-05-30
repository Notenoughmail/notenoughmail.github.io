---
title: Bonus Chest
anchor: bonus-chest
type: bonus_chest
wiki_link: https://minecraft.wiki/w/Bonus_Chest?oldid=3555300
sort_pos: a
group: a
icon: chest
sprite: BlockSprite
cat:
    - worldjs
    - 1.21.1
    - feature
example: |-
    .withPlacement(p => p.modifiers(m => {
        m.minecraft
            .fixed([[0, 0, 0], [0, 100, 0]])
            .horizontalRandomOffset([-8, 8])
    }))
---

[[ base ]]
