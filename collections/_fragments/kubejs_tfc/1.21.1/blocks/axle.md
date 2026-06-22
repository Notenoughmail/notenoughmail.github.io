---
title: Axle
anchor: axle
group: _
type: tfc:axle
cat:
    - kubejs_tfc
    - 1.21.1
    - block
example: |-
    .axleTexture('tfc:block/metal/smooth/bronze')
    .waterWheel(wheel => {
        wheel.rawWheelTexture('tfc:block/metal/smooth/red_steel')
        wheel.extendedProperties(props => {
            props.noOcclusion().instabreak()
        })
    })
    .clutch(clutch => 
        clutch.models((type, m) => {
            if (type.powered()) m.parent('minecraft:block/redstone_block')
        })
    })
---

Creates a new axle block and, optionally, related blocks dependent upon it

[[ base ]]

{: #{{ page.anchor }}-methods }

## Extra Methods

- `.axleTexture(texture: ResourceLocation)`{: .language-kube-21 #{{ page.anchor }}-texture }: Set the texture of the axle
- `.windmill(id?: ResourceLocation, windmill: Consumer<WindmillBlockBuilder>)`{: .language-kube-21 #{{ page.anchor }}-windmill }: Set the properties of the windmill associated with the axle. Accepts a consumer with the methods
    - [[ raw_props ]]
    - [[ def ]]
- `.waterWheel(id?: ResourceLocation, waterWheel: Consumer<WaterWheelBlockBuilder>)`{: .language-kube-21 #{{ page.anchor }}-water-wheel }: Create and set the properties of the water wheel associated with the axle. Accepts a consumer with the methods
    - `.wheelTexture(texture: ResourceLocation)`{:.language-kube-21}: Set the texture used by the water wheel in-world, the given path will be relative to `/textures/entity/water_wheel/`{:.language-fs}
    - `.rawWheelTexture(texture: ResourceLocation)`{:.language-kube-21}: Set the texture used by the water wheel in-world, the given path will be relative to `/textures/`{:.language-fs}
    - [[ raw_props ]]
    - [[ def ]]
- `.gearBox(id?: ResourceLocation, gearBox: Consumer<GearBoxBlockBuilder>)`{: .language-kube-21 #{{ page.anchor }}-gear-box }: Create and set the properties of the gear box associated with the axle. Accepts a consumer with the methods
    - `.models(models: BiConsumer<GearBoxModelType, ModelGenerator>)`{:.language-kube-21}: Set the model generation of the gear box. Accepts a callback with two parameters, the second being a model generator and the first being an object, `port`{:.e} or `face`{:.e}, with a method `.port(): boolean`{:.language-kube-21} which returns if the model is `port`{:.e}
    - [[ raw_props ]]
    - [[ def ]]
- `.clutch(id?: ResourceLocation, clutch: Consumer<ClutchBlockBuilder>)`{: .language-kube-21 #{{ page.anchor }}-clutch }: Create and set the properties of the clutch associated with the axle. Accepts a consumer with the methods
    - `.models(models: BiConsumer<ClutchModelType, ModelGenerator>)`{:.language-kube-21}: Set the model generation of the clutch. Accepts a callback with two parameters the second being a model generator and the first being an object, `powered`{:.e} or `unpowered`{:.e}, with a method `.powered(): boolean`{:.language-kube-21} which returns if the model is `powered`{:.e}
    - [[ raw_props ]]
    - [[ def ]]
- `.bladedAxle(id?: ResourceLocation, bladed: Consumer<BladedAxleBlockBuilder>)`{: .language-kube-21 #{{ page.anchor }}-bladed-axle }: Create and set the properties of the bladed axle associated with the axle. Accepts a consumer with the methods
    - [[ raw_props ]]
    - [[ def ]]
- [[ props ]]
