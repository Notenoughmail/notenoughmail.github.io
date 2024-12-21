---
layout: page
title: Miscellaneous Features
permalink: /kubejs_tfc/1.20.1/misc/
parent: 1.20.1
grand_parent: KubeJS TFC
---

# Miscellaneous Features

This page is for features which don't deserve their own page and/or don't fit into another page

- [Recipe Components](#recipe-components)
- [Configuration](#configuration)

## Recipe Components

KubeJS handles recipes through *recipe schemas*, which are made up of *recipe components*, essentially a mirror to a recipe type's json (de)serialization process. For the most part recipe schemas are made through addons, but KubeJS does have a startup event for registering custom recipe schemas in your scripts.

{: .notice }
This is *not* meant to be a tutorial on how to use that event, merely an acknowledgement of the recipe components KubeJS TFC adds to the event

### Provided Components

KubeJS TFC adds 6 recipe component types

- `tfc:outputItemStackProvider`: An output [ItemProviderComponent](https://github.com/Notenoughmail/KubeJS-TFC/blob/1.20.1/src/main/java/com/notenoughmail/kubejs_tfc/recipe/component/ItemProviderComponent.java), used by recipes which support [ISP]({% link kubejs_tfc/1.20.1/bindings/isp.md %}) outputs
- `tfc:otherItemStackProvider`: An [ItemProviderComponent](https://github.com/Notenoughmail/KubeJS-TFC/blob/1.20.1/src/main/java/com/notenoughmail/kubejs_tfc/recipe/component/ItemProviderComponent.java), used by recipes which support [ISP]({% link kubejs_tfc/1.20.1/bindings/isp.md %}) intermediates
- `tfc:fluidIngredient`: A [FluidIngredientComponent](https://github.com/Notenoughmail/KubeJS-TFC/blob/1.20.1/src/main/java/com/notenoughmail/kubejs_tfc/recipe/component/FluidIngredientComponent.java), used by recipes which support [fluid ingredients]({% link kubejs_tfc/1.20.1/bindings.md %}#fluid-ingredient)
- `tfc:fluidStackIngredient`: A [FluidStackIngredientComponent](https://github.com/Notenoughmail/KubeJS-TFC/blob/1.20.1/src/main/java/com/notenoughmail/kubejs_tfc/recipe/component/FluidIngredientComponent.java), used by recipes which support [fluid stack ingredients]({% link kubejs_tfc/1.20.1/bindings.md %}#fluid-stack-ingredient)
- `tfc:alloyPart`: An [AlloyPartComponent](https://github.com/Notenoughmail/KubeJS-TFC/blob/1.20.1/src/main/java/com/notenoughmail/kubejs_tfc/recipe/component/AlloyPartComponent.java), used by alloy recipes for their [alloy parts]({% link kubejs_tfc/1.20.1/bindings.md %}#alloy-part)
- `tfc:blockIngredient`: A [BlockIngredientComponent](https://github.com/Notenoughmail/KubeJS-TFC/blob/1.20.1/src/main/java/com/notenoughmail/kubejs_tfc/recipe/component/BlockIngredientComponent.java), used by recipes which support [block ingredients]({% link kubejs_tfc/1.20.1/bindings.md %}#block-ingredient)

## Configuration

In KubeJS's `dev.properties` file there is an option for `debugInfo`, if set to `true`, KubeJS TFC will print various debug info to the log

Additionally in the `dev.properties` file there is a new property, `tfc/insertSelfTestsIntoConsole`, which will insert TFC's self test warnings into the KubeJS console if enabled, allowing for warnings about certain recipe ingredients not being tagged properly to be visible
