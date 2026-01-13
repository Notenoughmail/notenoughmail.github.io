---
title: Stationary Berry Bush
anchor: stationary-berry-bush
group: bush
type: tfc:stationary_berry_bush
name: stationary_berry_bush
cat:
    - kubejs_tfc
    - 1.21.1
    - block
example:
    - .lifecycle('january', 'healthy')
    - .lifecycle('june', 'fruiting')
    - .withProduct('minecraft:golden_apple')
    - .models((lifecycle, stage, m) => {
    - '})'
---

Creates a new stationary berry bush block

Inherits the methods of the default block builder

{: #{{ page.anchor }}-methods }

## Extra Methods

- `.lifecycle(month: Month, lifecycle: Lifecycle)`{: .language-kube-21 #{{ page.anchor }}-lifecycle }: Set the `Lifecycle`{:.e} the bush is in for a [`Month`{:.e}]({% link kubejs_tfc/1.21.1/type-explanations.md %}#month-enum){:.preserve-color}. May be `dormant`{:.e}, `healthy`{:.e}, `flowering`{:.e}, or `fruiting`{:.e}
- `.productItem(productItem: Consumer<itemBuilder>)`{: .language-kube-21 #{{ page.anchor }}-product-item }: Modify the properties of the product item
- `.withProduct(product: Holder<Item>)`{: .language-kube-21 #{{ page.anchor }}-with-product }: Set the product item of the bush to a pre-existing item
- `.model(lifecycle: Lifecycle, stage: int, modelGenerator: Consumer<ModelGenreator>)`{: .language-kube-21 #{{ page.anchor }}-model }: Set the model for a given lifecycle and growth stage
- `.models(models: TriConsumer<Lifecycle, int, ModelGenerator>)`{: .language-kube-21 #{{ page.anchor }}-models }: Set the model generation for all lifecycles and growth stages via a callback with the params
    - `lifecycle: Lifecycle`{:.language-kube-21}: The lifecycle the model is for
    - `stage: int`{:.language-kube-21}: The growth stage of the bush, {% in_range 0,2 %}
    - `model: ModelGenerator`{:.language-kube-21}: The model generator for the lifecycle & stage
- `.extendedProperties(extendedProperties: Consumer<ExtendedProperties>)`{: .language-kube-21 #{{ page.anchor }}-extended-properties }: Set the [extended properties](#extended-properties) of the bush
