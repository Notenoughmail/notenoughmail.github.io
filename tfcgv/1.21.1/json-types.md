---
layout: page
title: Json Types
permalink: /tfcgv/1.21.1/json-types/
parent: 1.21.1
grand_parent: TFCGenViewer
has_children: false
desc: Descriptions of the different json object types TFCGenViewer uses for color customization
---

# Json Types

The colors used by visualizers are fully resource-packable and are defined using three types of data

- [Color Definition](#color-definition)
- [Color Gradient Definition](#color-gradient-definition)
- [Registry Linked Color Definition](#registry-linked-color-definition)

## Color Definition

A color definition defines a static color and the name/tooltip associated with it. They are objects with the following fields

- `color`: A [color](#color) object, the color of the definition
- `name`: A [text component](https://minecraft.wiki/w/Text_component_format/Before_Java_Edition_1.21.5), the descriptor of the color in the color key
- `sort`: An integer, the sort number of the color in the color key for visualizer types that support automatic color key reordering. Optional, defaults to 100
- `tooltip`: A text component, the descriptor of the color when hovering over the preview pane in tooltip mode. Optional, defaults to `name`

{: .comment }
> Example: `tfc/tfcgenviewer/color/rock/rock/raw/limestone.json`{:.language-fs}
>
> ```json
> {
>   "color": {
>     "r": 136,
>     "g": 127,
>     "b": 107
>   },
>   "name": {
>     "translate": "color.tfc.rock.limestone"
>   },
>   "sort": 5
> }
> ```

### Color

A color is an object with three fields

- `r`: The red value, {% in_range 0,255 %}
- `g`: The green value, {% in_range 0,255 %}
- `b`: The blue value, {% in_range 0,255 %}

## Color Gradient Definition

A color gradient definition defines a color gradient, its name, and its tooltips. They are objects with the following fields

- `gradient`: A [gradient](#gradient)
- `name`: A [text component](https://minecraft.wiki/w/Text_component_format/Before_Java_Edition_1.21.5), the descriptor of the gradient in the color key
- `tooltips`: A list of text components, the descriptors of the gradient, from low to high, of the gradient when hovering over the preview pane in tooltip mode. Optional, defaults to `name`

{: .comment }
> Example: `tfcgenviewer/tfcgenviewer/gradients/rainfall.json`{:.language-fs}
>
> ```json
> {
>   "gradient": {
>     "type": "preset",
>     "preset": "tfcgenviewer:rainfall"
>   },
>   "name": {
>     "translate": "tfcgenviewer.gradient.rainfall"
>   },
>   "tooltips": [
>     {
>       "translate": "tfcgenviewer.gradient.rainfall.0"
>     },
>     {
>       "translate": "tfcgenviewer.gradient.rainfall.1"
>     },
>     {
>       "translate": "tfcgenviewer.gradient.rainfall.2"
>     },
>     {
>       "translate": "tfcgenviewer.gradient.rainfall.3"
>     },
>     {
>       "translate": "tfcgenviewer.gradient.rainfall.4"
>     }
>   ]
> }
> ```

### Gradient

A gradient converts a value {% in_unit %} into a color, usually by interpolating between specified colors in the linear sRGB color space. It is an object with the following definition

- `type`: One of `"preset"`{:.s}, `"static"`{:.s}, `"from_to"`{:.s}, or `"list"`{:.s}. There are different required fields depending on the type
    - `preset`: Has one additional field, `preset`, a string, the id of a registered gradient. By default, the available preset gradients are
        - `tfcgenviewer:blue`
        - `tfcgenviewer:green`
        - `tfcgenviewer:volcanic`
        - `tfcgenviewer:uplift`
        - `tfcgenviewer:rainfall`
        - `tfcgenviewer:temperature`
        - `tfcgenviewer:grayscale`
    - `static`: Has one additional field, `color`, a [color](#color). Creates a static gradient of just the single color
    - `from_to`: Has two additional fields, `from` and `to`, both are [colors](#color), the low and high ends of the gradient
    - `list`: Has one additional field, `colors`, a list of at least three [colors](#color). Creates a gradient interpolating between all the colors provided from low to high

## Registry Linked Color Definition

A registry linked color definition associates one or more registry objects with a [color definition](#color-definition). They are used in situations when it would be desirable to have multiple things described by the same color

They are objects with two fields

- `color`: A [color definition](#color-definition)
- `keys`: A list of strings, the ids of the registry elements to link to the color

{: .comment }
> Example: `tfcgenviewer/tfcgenviewer/visualizable_feature_color/coral.json`{:.language-fs}
>
> ```json
> {
>   "color": {
>     "color": {
>       "r": 255,
>       "g": 153,
>       "b": 22
>     },
>     "name": {
>       "translate": "tfcgenviewer.visualized_feature.coral"
>     }
>   },
>   "keys": [
>      "tfc:coral_claw",
>      "tfc:coral_tree",
>      "tfc:coral_mushroom"
>    ]
> }
> ```
