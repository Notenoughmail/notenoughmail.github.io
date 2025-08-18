---
layout: page
title: Rock Editor
permalink: /tfcgv/1.20.1/rock-editor/
parent: 1.20.1
grand_parent: TFCGenViewer
has_children: false
---

# Rock Editor

Allows for the editing and graphing (via this website) of the [rock layer settings](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/world-preset/#rock-layer-settings) of the world through a GUI. This screen is divided into three tabs that focus on [rock settings](#rock-settings), the [layer types](#layer-types), and [layer definitions](#layer-definitions). Each tab is generally split into two sections: the display on the left, and the editor on the right. The layer types tab is unique in that, due to the underlying data structure, objects in its editor are technically still in the display and edits apply immediately to the rock layer settings.

Additionally, across the bottom of the screen there are four buttons

- *Apply*: Validate the current settings and display a message if an issue occurs or apply the settings to the generator and return to the preview screen
- *Validate*: Validate the current settings
- *Graph*: Generate a link to view the current settings on the [rock graphing page](/mc/tools/tfcgv_rock_graph/)
- *Cancel*: Discard all edits to the settings and return to the preview screen

## Rock Settings

This tab is for editing, removing, and adding [rock settings](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/world-preset/#rock).

<img src="/assets/images/tfcgv/rock_editor/rock_settings.png" alt="The rock settings tab. The shale, quartzite, and chert rock settings are visible in the display on the left. On the right, the editor is blank." class="center-image">

Each entry in the display consists of

- A remove button: Removes the rock setting outright
- An edit button: Moves the rock setting to the editor
- The name of the rock setting
- The blocks which define the rock settings

{: #rock-settings-editor }

### Editor

The editor is where the blocks of a rock setting can be changed and its name can be edited. The editor has:

- A save button: Validates the setting object and moves it left to the display and to the rock layer settings if valid.
- An edit box: The name of the setting, must not be blank
- 9 block selectors: The selectors for the blocks of the setting. Define, in order, the `raw`, `hardened`, `gravel`, `cobble`, `sand`, `sandstone`, `spike`, `loose`, and `mossy_loose` blocks. Usage:
    - When not focused, each selector will display the icon and name of the selected block.
    - When focused, the display will be replaced with a search bar and a 'scrollable' list of up to five blocks. This displays the blocks matching the search.
    - The list can be scrolled with the up and down arrows. Holding `alt` will make the list scroll five at a time and holding `shift` will force the focused element to change when using the arrow keys.
    - The block with a golden name is the one currently selected, this can be confirmed and added to the setting object with the `enter` key.
- A clear button: Resets the editor to the default state.

TODO: Image(s) showing block selector usage

## Layer Types

This tab is for editing which rock layers are in the ocean floor, volcanic, land, and uplift rock layer types and the rocks in the the bottom pseudo-layer.

<img src="/assets/images/tfcgv/rock_editor/layer_types.png" alt="The layer types tab with an empty editor" class="center-image">

The display has five entries for the bottom rocks and the ocean floor, volcanic, land, and uplift rock layer types. Each entry has

- An edit button that moves the entry to the editor
- The title of the entry
- A list of up to three of the entry's values. Entries with more than three values will display an ellipsis where the third value would typically be shown.

<img src="/assets/images/tfcgv/rock_editor/layer_types_edit.png" alt="The layer types tan. The editor is occupied by volcanic rock layers which has the 'igneous_extrusive' and 'igneous_extrusive_x2' layers" class="center-image">

The editor contains a list of the values present in the layer type with a delete button which removes the value next to each. Towards the bottom of the screen there is a 

TODO: Image showing suggestion list of edit box

## Layer Definitions

{% comment %}

# rock-settings-editor

{% endcomment %}
