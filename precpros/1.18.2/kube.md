---
layout: page
title: KubeJS Integration
permalink: /precpros/1.18.2/kube/
parent: 1.18.2
grand_parent: Precision Prospecting
---

# KubeJS Integration

This page is the documentation for Precision Prospecting's optional integration with KubeJS.

**Note**: This is a 1.18 only feature, and will be available through KubeJS-TFC instead for 1.20+

## Tool Types
Precision Prospecting adds four new [item types](https://mods.latvian.dev/link/9#bkmrk-valid-item-types%3A) which can be used in your scripts, they are:
- `'prospector_hammer'`,
- `'prospector_drill'`, 
- `'mineral_prospector'`, and
- `'custom_prospector'`

The hammer, drill, and mineral types will all build a new tool with the same scanning area and tag as their respective default tools.

The custom prospector type will build a new tool which implements five new methods to adjust its scanning properties as you desire, they are:
- cool down: `coolDownBaseline(int)`,
- primary radius: `primaryRadiusBaseline(int)`,
- secondary radius: `secondaryRadiusBaseline(int)`,
- displacement: `displacementBaseline(int)`, and
- prospected tag: `prospectBlockTag(tag)`

Additionally, the radii and displacement can be defined together with one method: `dimensionsBaseline(int1, int2, int3)`, which is the same as adding `primaryRadiusBaseline(int1)`, `secondaryRadiusBaseline(int2)`, and `displacementBaseline(int3)` to your item.

## Defaults and Derived Values
All tools default to the iron tier, just like other tools in KubeJS. The accuracy of the tool is derived from the tier the tool is made of, wood being the worst, stone being better, iron better still, etc. The attack damage, speed, etc are also defined by the tier but can be overridden using kubejs's native methods like any other tool.

The custom prospector defaults to `15` cool down, `12` primary radius, `12` secondary radius, `0` displacement, and `tfc:prospectable` as the prospectable block tag; or the stats of a base TFC Prospector Pick with 1.5x the cool down time.

## Examples
``` javascript
// In kubejs\startup_scripts

onEvent('item.registry', event => {
	// Registers a new prospector hammer item with the wood tier
	event.create('my_prospector_hammer', 'prospector_hammer').tier('wood')
	// Registers a new prospector item with 100 ticks of cool down between uses and a primary radius of 3 blocks (7 wide total)
	event.create('my_custom_prospector', 'custom_prospector').coolDownBaseline(100).primaryRadiusBaseline(3)
	// These two are equivalent!
	// Registers a new prospector item with radii of 3 and displacement of 5
	event.create('my_custom_surface_sampler', 'custom_prospector').primaryRadiusBaseline(3).secondaryRadiusBaseline(3).displacementBaseline(5)
	event.create('my_custom_surface_sampler_simplified', 'custom_prospector').dimensionsBaseline(3, 3, 5)
	// Registers a new prospector item that scans for any block with the #tfc:clay tag (Silt/Loam/etc. Clay Dirt/Grass)
	event.create('my_clay_finder', 'custom_prospector').prospectBlockTag('tfc:clay')
	// This does not work, as #minecraft:water is a fluid tag, however add #minecraft:water as a block tag and it will work
	event.create('my_dowsing_rod', 'custom_prospector').prospectBlockTag('minecraft:water')
})
```

## Notes on Using the prospectBlockTag Method
TFC automatically makes lang keys for any block prospected, however it does not automatically not fill them, you will have to do this yourself. The structure is simple, simply the normal lang key with `.prospected` appended to the end, so when using `my_clay_finder` from the examples, you would need:
```json
{
  "block.tfc.clay.silt.prospected": "Clay",
  "block.tfc.clay.loam.prospected": "Clay",
  "etc": "etc"
}
```
in a `tfc\lang\en_us.json` (this can easily be done through KubeJS's inbuilt resource pack) in order for the tool to say "Found [quality] Sample of Clay" whenever it finds a clay block.

## Radii and Displacement Meanings
Prospecting tools work by scanning a box in the world, with the dimensions of the box being determined by the two `radii`.

### Displacement
The center of the box is wholly determined by the displacement, clicked block, and which face of the clicked block is actually clicked. For instance if the clicked block is at `(10, 10, 10)`, with a displacement of `3` and the clicked block face is `West`, the center of the box will be at `(13, 10, 10)` while if clicked block face is `East`, the box's center will be at `(7, 10, 10)`.

### Primary Radius
The primary radius defines the size of the *non-axial* directions, meaning the directions which are not in-line with the clicked block face/displacement vector. For instance, if the primary radius is `3`, and the player clicks the `bottom` or `top` face of a block, the scanned area will contain 3 blocks to the `North`, `South`, `East`, and `West`; but when clicking on the `West` or `East` face of a block it will contain 3 blocks to the `North`, `South`, `Up`, and `Down`.

### Secondary Radius
The secondary radius defines the size of the *axial* direction, meaning the one in-line with the clicked block face/displacement vector. Using the previous example, if the secondary radius is `4` and the player clicks the `top` or `bottom` face of a block, the box will contain the blocks 4 `Up` and `Down` from the center of the box, as defined by the displacement.