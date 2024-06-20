---
title: KubeJS TFC 1.2.0
layout: post
date: 2024-06-x XX:XX:XX
ref: kubejs-tfc-1-2-0
---

# KubJS TFC 1.2.0

- Fix custom lamps not retaining their fluid when broken
- Register custom blocks with block entities to TFC's own BE types instead of a duplicate
- Fix misspelling of extended properties method
- Custom grass, farmland, and path blocks now use their parent dirt block's texture as their base by default
- Add an event for modifying default worldgen values, including the world's rock layers
- Add axle block builder, which has methods for creating corresponding windmills, water wheels, gear boxes, clutches, and bladed axles
- Add EntityJS compat
    - Relatively limited for now
- Add event for registering a fauna definition for any entity type
- Add `getCraftingInputs()` method to the custom modifiers event to match new TFC functionality
- Add methods for getting the fuel, drinkable, fertilizer, lamp fuel, pannable, and sluicable definitions to the misc sub-binding
