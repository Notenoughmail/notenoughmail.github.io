---
type: server
name: selectClimateModel
title: Select Climate Model
anchor: select-climate-model
cat:
    - kubejs_tfc
    - 1.21.1
    - event
example:
    - if (event.dimensionId() == 'minecraft:the_nether') {
    - "    let model = event.kubeModel('kubejs:hell', 10000, false)"
    - "    event.setModel(model)"
    - '}'
---

This event fires during world loading and is used to choose which implementation of [climate model]({% link kubejs_tfc/1.21.1/type-explanations.md %}#climate-model) a level should use

{: #{{page.anchor }}-methods }

## Methods

- `.getLevel(): ServerLevel`{: .language-kube-21 #{{ page.anchor }}-get-level }: Get the level the model is being chosen for
- `.dimensionId(): ResourceLocation`{: .language-kube-21 #{{ page.anchor }}-dimension-id }: Get dimension id of the level
- `.getWorldSettings(): @Nullable Settings`{: .language-kube-21 #{{ page.anchor }}-get-world-settings }: Get the TFC [`Settings`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/world/settings/Settings.java) of the world if it has a TFc-like generator, else `null`{:.p}
- `.getModel(): ClimateModel`{: .language-kube-21 #{{ page.anchor }}-get-model }: Get the model that will currently be applied to the level
- `.kubeModel(id: ResourceLocation, hemisphereScale: number, supportsRain: boolean): @Nullable ClimateModel`{: .language-kube-21 #{{ page.anchor }}-kube-model-0 }: Create a climate model based on a climate model type [registered through scripts]({% link kubejs_tfc/1.21.1/registry.md %}#cliamte-model-type)
    - `id: ResourceLocation`{:.language-kube-21}: The id of the registered climate model type
    - `hemisphereScale: number`{:.language-kube-21}: The hemisphere scale of the model to create
    - `supportsRain: boolean`{:.language-kube-21}: If the model should support rain
- `.kubeModel(id: ResourceLocation): @Nullable ClimateModel`{: .language-kube-21 #{{ page.anchor }}-kube-model-1 }: Create a climate model based on a climate model type [registered through scripts]({% link kubejs_tfc/1.21.1/registry.md %}#climate-model-type) with a hemisphere scale of `20000`{:.n} that supports rain
- `.setModel(model: ClimateModel): void`{: .language-kube-21 #{{ page.anchor }}-set-model }: Set the model to apply to the level
