---
layout: page
title: Custom Registry Objects
permalink: /kubejs_tfc/1.21.1/registry/
parent: 1.21.1
grand_parent: KubeJS TFC
desc: Non-item/block registry types
---

# Custom Registry Objects

{% map replacements %}
{% def_1 %}Defaults to `1`{:.n}{% end_def_1 %}
{% fn_sound [^1] %}
{% required **Must** be set %}
{% endmap %}

[^1]: A full list of sounds can be obtained by running the command `/kubejs dump_registry minecraft:sound_event`{:.language-command} in-game

{% assign regs = site | fragments_replace: replacements, 'kubejs_tfc', '1.21.1', 'reg' | sort: 'anchor' %}

KubeJS TFC adds the ability to register some TFC-specific non-item/block types

{% grid n=2 %}

{% for r in regs %}

- [{{ r.title }}](#{{ r.anchor }})

{% endfor %}

- [Spring Water](#spring-water)

</div>

{% for r in regs %}

{: #{{ r.anchor }} }

## {{ r.title }}

{{ r.desc | render_full }}

Part of the `{{ r.reg }}` registry and can be created via the default builder in KubeJS's `{{ r | get_or_else: 'group', 'StartupEvents' }}.registry('{{ r.reg }}', event => {})`{:.language-kube-21} event

{: #{{ r.anchor }}-methods }

### Methods

{{ r.clean | render_missed_footnotes }}

{: #{{ r.anchor }}-example }

### Example

```js-21
{{ r | get_or_else: 'group', 'StartupEvents' }}.registry('{{ r.reg }}', event => {
    event.create('{{ r.name }}')
        {{ r.example | with_indent }}
})
```

{% endfor %}

## Spring Water

A fluid registry type

**Type**: `tfc:spring`

Creates a fluid which emits steam and bubble particles and heals the player when inside it

Inherits all the methods of the base fluid builder

{: #spring-water-methods }

### Extra Methods

- `.bubbleParticle(particle: @Nullable Holder<ParticleType<?>>)`{: .language-kube-21 #spring-water-bubble-particle }: Set the bubble particle options of the fluid via the id of a particle type or `null`{:.p} to indicate the fluid has no bubble particles
- `.fullBubbleParticle(bubble: Supplier<ParticleOptions>)`{: .language-kube-21 #spring-water-full-bubble-particle }: Set the bubble particle options of the fluid
- `.steamParticle(particle: @Nullable Holder<ParticleType<?>>)`{: .language-kube-21 #spring-water-steam-particle }: Set the steam particle options of the fluid via the id of a particle type of `null`{:.p} to indicate the fluid has no steam particles
- `.fullSteamParticle(steam: Supplier<ParticleOptions>)`{: .language-kube-21 #spring-water-full-steam-particle }: Set the steam particle options of the fluid
- `.healingAmount(healing: number)`{: .language-kube-21 #spring-water-healing-amount }: Set the health the fluid restores while a living entity is in it, defaults to `0.08`{:.n}

{: #spring-water-example }

### Example

```js-21
StartupEvents.registry('fluid', event => {
    event.create('spring', 'tfc:spring')
        .bubbleParticle(null)
        .healingAmount(5)
})
```
