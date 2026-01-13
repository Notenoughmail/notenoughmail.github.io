---
title: Axle
anchor: axle
group: _
type: tfc:axle
cat:
    - kubejs_tfc
    - 1.21.1
    - block
example:
    - .axleTexture('tfc:block/metal/smooth/bronze')
    - .waterWheel(wheel => {
    - "    wheel.rawWheelTexture('tfc:block/metal/smooth/red_steel')"
    - "    wheel.extendedProperties(props => {"
    - "        props.noOcclusion().instabreak()"
    - "    })"
    - "})"
    - .clutch(clutch => {
    - "    clutch.models((type, m) => {"
    - "        if (type.powered()) m.parent('minecraft:block/redstone_block')"
    - "    })"
    - "})"
---

Creates a new axle block and, optionally, related blocks dependent upon it

Inherits the methods of the default block builder

{: #{{ page.anchor }}-methods }

## Extra Methods

- `.axleTexture(texture: ResourceLocation)`{: .language-kube-21 #{{ page.anchor }}-texture }: Set the texture of the axle
- `.windmill(windmill: Consumer<WindmillBlockBuilder>)`{: .language-kube-21 #{{ page.anchor }}-windmill }: Set the properties of the windmill associated with the axle. Accepts a consumer with the methods
    - `.extendedProperties(extendedProperties: Consumer<ExtendedProperties>)`{:.language-kube-21}: Set the [extended properties](#extended-properties) of the windmill
    - All those of the default block builder
- `.waterWheel(waterWheel: Consumer<WaterWheelBlockBuilder>)`{: .language-kube-21 #{{ page.anchor }}-water-wheel }: Create and set the properties of the water wheel associated with the axle. Accepts a consumer with the methods
    - `.wheelTexture(texture: ResourceLocation)`{:.language-kube-21}: Set the texture used by the water wheel in-world, the given path will be relative to `/textures/entity/water_wheel/`{:.language-fs}
    - `.rawWheelTexture(texture: ResourceLocation)`{:.language-kube-21}: Set the texture used by the water wheel in-world, the given path will be relative to `/textures/`{:.language-fs}
    - `.extendedProperties(extendedProperties: Consumer<ExtendedProperties>)`{:.language-kube-21}: Set the [extended properties](#extended-properties) of the water wheel
    - All those of the default block builder
- `.gearBox(gearBox: Consumer<GearBoxBlockBuilder>)`{: .language-kube-21 #{{ page.anchor }}-gear-box }: Create and set the properties of the gear box associated with the axle. Accepts a consumer with the methods
    - `.models(models: BiConsumer<GearBoxModelType, ModelGenerator>)`{:.language-kube-21}: Set the model generation of the gear box. Accepts a callback with two parameters, the second being a model generator and the first being an object, `port`{:.e} or `face`{:.e}, with a method `.port(): boolean`{:.language-kube-21} which returns if the model is `port`{:.e}
    - `.extendedProperties(extendedProperties: Consumer<ExtendedProperties>)`{:.language-kube-21}: Set the [extended properties](#extended-properties) of the gear box
    - All those of the default block builder
- `.clutch(clutch: Consumer<ClutchBlockBuilder>)`{: .language-kube-21 #{{ page.anchor }}-clutch }: Create and set the properties of the clutch associated with the axle. Accepts a consumer with the methods
    - `.models(models: BiConsumer<ClutchModelType, ModelGenerator>)`{:.language-kube-21}: Set the model generation of the clutch. Accepts a callback with two parameters the second being a model generator and the first being an object, `powered`{:.e} or `unpowered`{:.e}, with a method `.powered(): boolean`{:.language-kube-21} which returns if the model is `powered`{:.e}
    - `.extendedProperties(extendedProperties: Consumer<ExtenededProperties>)`{:.language-kube-21}: Set the [extended properties](#extended-properties) of the clutch
    - All those of the default block builder
- `.bladedAxle(bladed: Consumer<BladedAxleBlockBuilder>)`{: .language-kube-21 #{{ page.anchor }}-bladed-axle }: Create and set the properties of the bladed axle associated with the axle. Accepts a consumer with the methods
    - `.extendedProperties(extendedProperties: Consumer<ExtendedProperties>)`{:.language-kube-21}: Set the [extended properties](#extended-properties) of the bladed axle
    - All those of the default block builder
- `.extendedProperties(extendedProperties: Consumer<ExtendedProperties>)`{: .language-kube-21 #{{ page.anchor }}-extended-properties }: Set the [extended properties](#extended-properties) of the axle

{% comment %}

## extended properties

{% endcomment %}
