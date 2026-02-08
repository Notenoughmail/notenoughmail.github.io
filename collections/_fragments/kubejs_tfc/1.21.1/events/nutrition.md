---
type: startup
name: customNutrition
title: Custom Nutrition
anchor: custom-nutrition
cat:
    - kubejs_tfc
    - 1.21.1
    - event
example:
    - event.setFactory((defNutrient, defDairy) => {
    - ''
    - '    let avgNutrition = defNutrient'
    - '    let nutrients = ['
    - '        defNutrient,'
    - '        defNutrient,'
    - '        defNutrient,'
    - '        defNutrient,'
    - '        defDairy'
    - '    ]'
    - ''
    - '    // Do as you wish...'
    - '    function applyHunger(hunger) { ... }'
    - '    function updateNutrition() { ... }'
    - '    function applyFood(foodData, currentHunger) { ... }'
    - ''
    - '    return JavaAdapter(event.classForJavaAdapter(), {'
    - '        getAverageNutrition: function () => avgNutrition,'
    - '        getNutrient: function (nutrient) => nutrients[nutrient.ordinal()],'
    - '        getNutrients: function () => nutrients,'
    - '        setHungerAndUpdate: function (hunger) => {'
    - '            applyHunger(hunger)'
    - '            updateNutrition()'
    - '        },'
    - '        setHunger: applyHunger,'
    - '        onClientUpdate: function (serverNutrients) => nutrients = serverNutrients,'
    - '        addNutrients: applyFood,'
    - '        writeToNbt: function () => { ... },'
    - '        readFromNbt: function(nbt) => { ... }'
    - '    })'
    - '})'
---

This event fires whenever a player joins the world on both the client and server side so that their nutrition calculator may be changed

{: #{{ page.anchor }}-methods }

## Methods

- `.getPlayer(): Player`{: .language-kube-21 #{{ page.anchor }}-get-player }: Get the player the nutrition is for
- `.classForJavaAdapter(): Object`{: .language-kube-21 #{{ page.anchor }}-class-for-java-adapter }: Get a `INutritionData` class wrapper that can be used with `JavaAdapter` to create new instances
- `getFactory(): BiFunction<number, number, T extends INutritionData>`{: .language-kube-21 #{{ page.anchor }}-get-factory }: Get the current nutrition factory for the player. Has a single method, `.create(defaultNutritionValue: number, defaultDairyNutritionValue: number): T extends INutritionData`{:.language-kube-21}
- `.setFactory(factory: BiFunction<number, number, INutritionData>)`{: .language-kube-21 #{{ page.anchor }}-set-factory }: Set the nutrition factory for the player. Accepts a callback with the params
    - `defaultNutritionValue: number`{:.language-kube-21}: The default value for the non-dairy nutrients
    - `defaultDairyNutritionValue: number`{:.language-kube-21}: The default value for the dairy nutrient
    - `return: INutritionData`{:.language-kube-21}: The nutrition data, can be made using `JavaAdapter`. Has the following methods that must be implemented
        - `.getAverageNutrition(): number`{:.language-kube-21}: Get the average nutrition, {% in_unit %}, of the player. used to calculate the player's health
        - `.getNutrient(nutrient: Nutrient): number`{:.language-kube-21}: Get the value, {% in_unit %} of the requested nutrient
        - `.getNutrients(): number[5]`{:.language-kube-21}: Get the values, {% in_unit %} of the player's nutrients. Should be in the order `grain`{:.e}, `fruit`{:.e}, `vegetables`{:.e}, `protein`{:.e}, `dairy`{:.e}
        - `.setHungerAndUpdate(hunger: int): void`{:.language-kube-21}: Set the player's current hunger value, {% in_range 0,20 %}, where `0`{:.n} is an empty food bar. This may update the player's nutrition
        - `.setHunger(hunger: int): void`{:.language-kube-21}: Set the player's current hunger value, {% in_range 0,20 %}, where `0`{:.n} is an empty food bar. This **must not** update the player's nutrition
        - `.onClientUpdate(nutrients: number[5]): void`{:.language-kube-21}: Set the nutrient data, on the client side, from a packet
        - `.addNutrients(data: FoodData, currentHunger: int): void`{:.language-kube-21}: Apply nutrients of a food to the player
        - `.writeToNbt(): Tag`{:.language-kube-21}: Serialize any relevant data for computing nutrition to an NBT tag
        - `.readFromNbt(nbt: @Nullable Tag): void`{:.language-kube-21}: Read any relevant data for computing nutrition from an NBT tag, the data serialized in `.writeToNbt()`{:.language-kube-21}
