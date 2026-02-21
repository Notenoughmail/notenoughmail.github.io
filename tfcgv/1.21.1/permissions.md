---
layout: page
title: Permissions
permalink: /tfcgv/1.21.1/permissions/
parent: 1.21.1
grand_parent: TFCGenViewer
has_children: false
desc: Information on the commands available to server admins for determining the information players may visualize
---

# Permissions

TFCGenViewer is completely server-optional, but will only function in-world if the server also has TFCGenViewer present. Additionally, the server has full control over the visualizer types and client may view and ancillary information they may interact with.

Visualizer types have a three layer permission system consisting of

- A global deny list: Any visualizer types in this category may not, under any circumstance, be viewed by any player
- A per-player visualizer type filter: Allows specific visualizer types to be filtered on a per-player basis. Overrides the global visualizer filter if present for a player and visualizer type combination
- A global visualizer types filter: A global visualizer type filter. Checked last, defaults to not allowing visualization if unset

A similar permission system also exists for the ancillary visualizer features for

- Drawing the spawn region
- Being able to export any generated preview images
- Being able to see coordinates in the preview screen

These also have a three layer permission system

- A global deny list: Any ancillary features in this category will not, under any circumstance, be available to use/view
- A per-player filter: Allows for feature overrides to be implemented on a per-player basis. Takes complete precedence over the global filter if present for a player
- A global filter: A global filter for ancillary features. Checked last, defaults to disallow for all ancillary features

By default, all permissions are set to deny access (even in single player worlds)

## Configuration

The contents of each permission layer can be edited via commands by anyone with command permission level of **3** or higher

### Ancillary Features

`/tfcgenviewer deny_ancillary <ancillary_type>`{:.language-command}

- `<ancillary_type>`{:.v}: The ancillary type, `spawn`{:.v}; `export`{:.v}; or `coords`{:.v}, to unconditionally deny for all players

`/tfcgenviewer allow_ancillary <ancillary_type>`{:.language-command}

- `<ancillary_type>`{:.v}: The ancillary type, `spawn`{:.v}; `export`{:.v}; or `coords`{:.v}, to conditionally permit players to use based on lower permission layers

`/tfcgenviewer set_individual_ancillary <player> <can_draw_spawn> <can_export_images> <can_see_coordinates>`{:.language-command}

- `<player>`{:.v}: The player(s) to set the ancillary feature permissions for
- `<can_draw_spawn>`{:.m}: A boolean, if the player(s) may draw the spawn region while visualizing the world
- `<can_export_images>`{:.s}: A boolean, if the player(s) may export generated previews
- `<can_see_coordinates>`{:.r}: A boolean, if the player(s) can see the coords a preview is centered on and at the location of the preview their mouse is hovering over

`/tfcgenviewer remove_individual_ancillary <player>`{:.language-command}

- `<player>`{:.v}: The player(s) to remove the ancillary permission overrides from

`/tfcgenviewer set_ancillary <ancillary_type> <allowed>`{:.language-command}

- `<ancillary_type>`{:.v}: the ancillary type, `spawn`{:.v}; `export`{:.v}; or `coords`{:.v}, to set the permission for globally
- `<allowed>`{:.m}: A boolean, if the ancillary type may be used by players

### Visualizer Types

`/tfcgenviewer deny_visualizer_type <visualzier_type>`{:.language-command}

- `<visualzier_type>`{:.v}: The registry id of the visualizer type to unconditionally deny use of for all players

`/tfcgenviewer allow_visualizer_type <visualizer_type>`{:.language-command}

- `<visualizer_type>`{:.v}: The registry id of the visualizer type to conditionally permit players to use based on lower permission layers

`/tfcgenviewer set_individual_visualizer_type <player> <visualizer_type> <allowed>`{:.language-command}

- `<player>`{:.v}: The player(s) to set the visualizer permission override for
- `<visualizer_type>`{:.m}: The registry id of the visualizer type to set permission for
- `<allowed>`{:.s}: A boolean, if the player(s) can use the visualizer type

`/tfcgenviewer remove_individual_visualizer_type <player> <visualizer_type>`{:.language-command}

- `<player>`{:.v}: The player(s) to remove the visualizer permission override from
- `<visualizer_type>`{:.m}: The registry id of the visualizer type permission override to remove

`/tfcgenviewer set_visualizer_type <vizualizer_type> <allowed>`{:.language-command}

- `<visualzier_type>`{:.v}: The registry id of a visualizer type to set the global permission for
- `<allowed>`{:.m}: A boolean, if players may use the visualizer type

## Inspection

Some permission information can also be retrieved via commands

`/tfcgenviewer describe_visualizer_type <visualzier_type>`{:.language-command}

- `<visualizer_type>`{:.v}: The registry id of the visualizer type to get a brief description of

`/tfcgenviewer query_permissions <player>`{:.language-command}

- `<player>`{:.v}: The player(s) to get permission report for
