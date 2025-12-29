---
layout: none
type: server
title: Animal Product
anchor: animal-product
cat:
    - kubejs_tfc
    - 1.21.1
    - event
---

**Type**: `server_scripts`

This event is fired whenever an animal product is produced: a sheep is sheared, a cow is milked, etc. Cancelling will prevent the default behavior, which is controlled by each entity's implementation. This event does not control if an entity can provide products, only for modifying/blocking them

The product of this event my be either an `ItemStack` of a `FluidStack`, not both. Attempting to change the product from an item to fluid or vice-versa will void all products

{: #animal-product-methods }

### Methods

{: #animal-product-example }

### Example
