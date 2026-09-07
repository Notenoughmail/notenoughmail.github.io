---
title: Lost Page
anchor: lost-page
cat:
    - kubejs_tfc
    - 1.21.1
    - data
desc: Add a lost page definition, used in rituals
mod: beneath
group: BeneathEvents
method: lostPage
sig: |-
    page: {
        cost: Ingredient,
        costs: List<int>,
        reward: Item,
        rewards: List<int>,
        punishments?: List<Punishment>,
        translation?: Component
    },
    id?: ResourceLocation
example: |-
    {
        cost: '#minecraft:flowers',
        costs: [
            1, 2, 3, 4, 5
        ],
        reward: 'minecraft:egg',
        rewards: [
            2, 4, 6, 8, 10
        ],
        punishments: [
            'none',
            'blaze_inferno',
            'corruption'
        ]
    }
---

- 1st argument: The lost page data, a map of parameters to values
    - `cost: Ingredient`{:.language-kube-21}: The ingredient of the ritual
    - `costs: List<int>`{:.language-kube-21}: The potential quantity of a `cost`{:.v} for the ritual
    - `reward: Item`{:.language-kube-21}: The reward for completing the ritual
    - `rewards: List<int>`{:.language-kube-21}: The potential quantity of a `reward`{:.v} for the ritual
    - `punishments?: List<Punishment>`{:.language-kube-21}: The potential punishments for invoking the ritual
        {% include enum_list.html summary='Reveal/hide list of punishments' values='none,levitation,drunkenness,blaze_inferno,infestation,withering,slime,corruption,wrath,champion,blessing,greed,unknown' %}
    - `translation?: Component`{:.language-kube-21}: The display for the `cost`{:.v}
- *Optional 2nd argument*: A `ResourceLocation`, the id of the lost page
