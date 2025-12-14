---
layout: page
title: Events
permalink: /kubejs_tfc/1.21.1/events/
parent: 1.21.1
grand_parent: KubeJS TFC
desc: Documentation of KubeJS TFC's events
---

# Events

KubeJS TFC adds several JS events for use in scripts

- [Animal Product](#animal-product)
- [Collapse](#collapse)
- [Douse Fire](#douse-fire)
- [Log](#log)
- [Prospect](#prospect)
- [Start Fire](#start-fire)
- [Select Climate Model](#select-climate-model)
- [Limit Container](#limit-container)
- [Create Chunk Data Provider](#create-chunk-data-provider)
- [Default World Settings](#default-world-settings)
- [Register Interactions](#register-interactions)
- [Fauna Spawns](#fauna-spawns)
- [Custom Nutrition](#custom-nutrition)
- [Placed Item Models](#placed-item-models)

## Animal Product

**Type**: `server_scripts`

This event is fired whenever an animal product is produced: a sheep is sheared, a cow is milked, etc. Cancelling will prevent the default behavior, which is controlled by each entity's implementation. This event does not control if an entity can provide products, only for modifying/blocking them

The product of this event my be either an `ItemStack` of a `FluidStack`, not both. Attempting to change the product from an item to fluid or vice-versa will void all products

{: #animal-product-methods }

### Methods

{: #animal-product-example }

### Example

## Collapse

## Douse Fire

## Log

## Prospect

## Start Fire

## Select Climate Model

## Limit Container

## Create Chunk Data Provider

## Default World Settings

## Register Interactions

## Propsect Representatives

## Fauna Spawns

## Custom Nutrition

## Placed item Models
