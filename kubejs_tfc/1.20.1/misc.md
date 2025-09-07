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
- [Recipe Input/Output Replacement](#recipe-replacement)
- [Recipe Filters](#recipe-filters)

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

In KubeJS's `dev.properties` file there is an option for `debugInfo`, if set to `true`{:.p}, KubeJS TFC will print various debug info to the log

Also in the `dev.properties` file

- `tfc/insertSelfTestsIntoConsole`: If `true`{:.p}, TFC's self test warnings will be inserted into the KubeJS console. Allows for warnings about items/fluids missing tags for proper recipe functionality to appear on world load. Defaults to `true`{:.p}.
- `tfc/deduplicateConsoleErrors`: If `true`{:.p}, any TFC self test warnings that are inserted into Kube's console will *not* be written to the normal log/console. Only has an effect when `tfc/insertSelfTestsIntoConsole` is `true`{:.p}. Defaults to `true`{:.p}.

## Recipe Replacement

## Recipe Filters
