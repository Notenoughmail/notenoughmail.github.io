---
type: server
name: animalProduct
title: Animal Product
anchor: animal-product
cat:
    - kubejs_tfc
    - 1.21.1
    - event
example:
    - if (event.getAnimalProperties().getGeneticSize() < 10) {
    - '    event.cancel()'
    - '} else if (event.isItemProduct()) {'
    - "    event.setItemProduct('minecraft:dirt')"
    - '}'
---

This event is fired whenever an animal product is produced: a sheep is sheared, a cow is milked, etc. Cancelling will prevent the default behavior, which is controlled by each entity's implementation. This event does not control if an entity can provide products, only for modifying/blocking them

The product of this event my be either an `ItemStack` of a `FluidStack`, not both. Attempting to change the product from an item to fluid or vice-versa will void all products

{: #animal-product-methods }

## Methods

- `.getPlayer(): Player`{: .language-kube-21 #animal-product-get-player }: Get the player retrieving the product
- `.getAnimal(): Entity`{: .language-kube-21 #animal-product-get-animal }: Get the animal the product is from
- `.getLevel(): Level`{: .language-kube-21 #animal-product-get-level }: Get the level of the animal
- `.getPos(): BlockPos`{: .language-kube-21 #animal-product-get-pos }: Get the position of the animal
- `.getAnimalProperties(): TFCAnimalProperties`{: .language-kube-21 #animal-product-get-animal-properties }: Get the [animal properties](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/common/entities/livestock/TFCAnimalProperties.java) of the animal
- `.getTool(): ItemStack`{: .language-kube-21 #animal-product-get-tool }: Get the item used by the player to get the product
- `.getItemProduct(): ItemStack`{: .language-kube-21 #animal-product-get-item-product }: Get the item product, may be empty if the original product was a fluid
- `.getFluidProduct(): FluidStack`{: .language-kube-21 #animal-product-get-fluid-product }: Get the fluid product, may be empty of the original product was an item
- `.isItemProduct(): boolean`{: .language-kube-21 #animal-product-is-item-product }: If the original product was an item
- `.setItemProduct(item: ItemStack): void`{: .language-kube-21 #animal-product-set-item-product }: Set the item product
- `.setFluidProduct(fluid: FluidStack): void`{: .language-kube-21 #animal-product-set-fluid-product }: Set the fluid product
- `.getUses(): int`{: .language-kube-21 #animal-product-get-uses }: Get the amount of 'wear' the animal will take from the event
- `.setUses(uses: int): void`{: .language-kube-21 #animal-product-set-uses }: Set the amount of 'wear' the animal will take from the event
- `.cancel(): void`{: .language-kube-21 #animal-product-cancel }: Prevent any product from being given to the player
