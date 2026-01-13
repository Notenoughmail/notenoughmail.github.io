---
type: server
name: prospect
title: Prospect
anchor: prospect
cat:
    - kubejs_tfc
    - 1.21.1
    - event
example:
    - if (event.getBlock().hasTag('kubejs:super_special_ores')) {
    - "    event.getPlayer().notify('Congrats!', 'You found some special ore. Enjoy!')"
    - '}'
---

This event fires whenever a player uses a Prospector's Pick

{: #{{ page.anchor }}-methods }

## Methods

- `.getPlayer(): Player`{: .language-kube-21 #{{ page.anchor }}-get-player }: Get the player prospecting
- `.getProspectResult(): ProspectResult`{: .language-kube-21 #{{ page.anchor }}-get-prospect-result }: Get the prospecting result, will be one of `very_large`{:.e}, `large`{:.e}, `medium`{:.e}, `small`{:.e}, `traces`{:.e}, `found`{:.e}, or `nothing`{:.e}
- `.getBlock(): Block`{: .language-kube-21 #{{ page.anchor }}-get-block }: Get the block found by prospecting or, if the result is `nothing`{:.e}, the block prospected
