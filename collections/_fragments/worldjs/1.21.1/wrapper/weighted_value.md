---
title: Weighted Value
anchor: weighted-value
cat:
    - worldjs
    - 1.21.1
    - wrapper
---

Weighted values are ways of describing a collection of objects which can be weighted. Weighted values are *always* made as part of a list which will never accept null or undefined values. Weights less than `1`{:.n} are also considered invalid and will emit an exception if encountered

Weighted values for a type can be created as

- A `WeightedValue` object: Will attempt to convert the value object of the given weighted value to expected type and emit a weighted value with the same weight. Will emit an error if the value could not be converted to the expected type
- A map with `'weight'`{:.s} and `'value'`{:.s} fields:
    - `'weight'`{:.s}: The weight given to the `value`, an `int`{:.p} that must be greater than `0`{:.n}
    - `'value'`{:.s}: The value the is being weighted, an object of the expected type or any of its wrapped forms
- A list:
    - The first item will be interpreted as an `int`{:.p}, the weight
    - The second item will be wrapped to an object of the expected type or any of its wrapped forms
- An object of the expected type or any of its wrapped forms. Will have a weight of `1`{:.n}
