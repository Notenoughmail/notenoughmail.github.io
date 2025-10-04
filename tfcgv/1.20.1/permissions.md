---
title: Permissions
layout: page
permalink: /tfcgv/1.20.1/permissions/
parent: 1.20.1
grand_parent: TFCGenViewer
has_children: false
---

# Permissions

As of 1.3.0, the preview function can be used in-world. Naturally some may want to disable this or limit what information may be displayed, and that can be done via the server config and commands (level **3** required).

## Configs

### View Permission

The first option in the server config is the `viewPermission` option which has 6 options

- `SEED_COMMAND`: Allows a player to open the preview, and view all information, if they have access to /seed (level **2**), default
- `BY_CATEGORY`: Allows a player to open the preview, with the information available being filtered via the other config options
- `NEVER`: No player may ever open the preview
- `ALWAYS`: A player may always open the preview and view all information
- `ALLOW_LIST`: If a player is part of the `universal` [filter](#filters), they may open the preview and view all information
- `DENY_LIST`: If a player is part of the `universal` [filter](#filters), they may ***not*** open the preview

This setting can also be set via the `/tfcgenviewer set view_permission <permission_type>`{:.language-command} command and gotten via `/tfcgenviewer get view_permission`{:.language-command}

### Categories

These options are only relevant if `viewPermission` is set to `BY_CATEGORY`

All of these options have the same possible values and behavior

- `SEED_COMMAND`: If the player has /seed permission (level **2**) they can access that feature, default
- `ALLOW_LIST`: If the player is part of that filter, they may access that feature
- `DENY_LIST`: If the player is part of that filter, they may ***not*** access that feature
- `NEVER`: No player may ever access that feature
- `ALWAYS`: A player may always access that information

#### exportPermission

If the player has access to this, they may export the preview

This setting can be set via the `/tfcgenviewer set export <permission_type>`{:.language-command} command and gotten via `/tfcgenviewer get export`{:.language-command}

#### seedPermission

If the player has access to this, the world seed will be displayed in the preview screen

This setting can be set via the `/tfcgenviewer set seed <permission_type>`{:.language-command} command and gotten via `/tfcgenviewer get seed`{:.language-command}

#### coordsPermission

If the player has access to this, they can click on the preview to display the coordinates their mouse is hovering over

This setting can be set via the `/tfcgenviewer set coords <permission_type>`{:.language-command} command and gotten via `/tfcgenviewer get coords`{:.language-command}

#### climatePermission

If the player has access to this, they may view the *Rainfall*, *Temperature*, and *Climate Restricted Features* visualizers

This setting can be set via the `/tfcgenviewer set climate <permission_type>`{:.language-command} command and gotten via `/tfcgenviewer get climate`{:.language-command}

#### rocksPermission

If the player has access to this, they may view the *Rocks* and *Rock Types* visualizers

This setting can be set via the `/tfcgenviewer set rocks <permission_type>`{:.language-command} command and gotten via `/tfcgenviewer get rocks`{:.language-command}

#### biomesPermission

If the player has access to this, they may view the *Biomes* and *Inland Height* visualizers

This setting can be set via the `/tfcgenviewer set biomes <permission_type>`{:.language-command} command and gotten via `/tfcgenviewer get biomes`{:.language-command}

#### riversPermission

If the player has access to this, they may view the *Rivers and Mountains* and *Biome Altitude* visualizers

This setting can be set via the `/tfcgenviewer set rivers <permission_type>`{:.language-command} command and gotten via `/tfcgenviewer get rivers`{:.language-command}

## Filters

If a permission is set to `ALLOW_LIST` or `DENY_LIST`, access to that feature will depend on that player's presence in the corresponding *filter*

Players can be added to filters via the `/tfcgenviewer add <category> <player>`{:.language-command} command and removed via the `/tfcgenviewer remove <category> <player>`{:.language-command} command

There are 8 categories

- `universal`: Used when the [viewPermission](#view-permission) config is set to `ALLOW_LIST` or `DENY_LIST`
- `export`: Used when the [exportPermission](#exportpermission) config is set to `ALLOW_LIST` or `DENY_LIST`
- `seed`: Used when the [seedPermission](#seedpermission) config is set to `ALLOW_LIST` or `DENY_LIST`
- `coords`: Used when the [coordsPermission](#coordspermission) config is set to `ALLOW_LIST` or `DENY_LIST`
- `climate`: Used when the [climatePermission](#climatepermission) config is set to `ALLOW_LIST` or `DENY_LIST`
- `rocks`: Used when the [rocksPermission](#rockspermission) config is set to `ALLOW_LIST` or `DENY_LIST`
- `biomes`: Used when the [biomesPermission](#biomespermission) config is set to `ALLOW_LIST` or `DENY_LIST`
- `rivers`: Used when the [riversPermission](#riverspermission) config is set to `ALLOW_LIST` or `DENY_LIST`
