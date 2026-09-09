---
layout: page
title: Commands
permalink: /kubejs_tfc/1.21.1/commands/
parent: 1.21.1
grand_parent: KubeJS TFC
desc: Commands added by KubeJS TFC, primarily for modpack/script debugging
---

{% map replacements %}
{% 1 \{:.v\} %}
{% 2 \{:.m\} %}
{% 3 \{:.s\} %}
{% 4 \{:.r\} %}
{% 5 \{:.nb\} %}
{% 6 \{:.o\} %}
{% 7 \{:.enum\} %}
{% 8 \{:.c1\} %}
{% fn_tfc_like [^tfc-like] %}
{% fn_order [^order] %}
{% fn_range [^range] %}
{% endmap %}

[^tfc-like]: Implements TFC's [`ChunkGeneratorExtension`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/world/ChunkGeneratorExtension.java)
[^order]: Order 1: share a face, order 2: share an edge, order 3: share a vertex
[^range]: A pair of numbers

{% assign commands = site | fragments_replace: replacements, 'kubejs_tfc', '1.21.1', 'command' | multi_sort: 'group', 'anchor' %}

# Commands

KubeJS TFC adds several commands for debugging TFC-related parts of scripts and information. They all require a permission level of **3** or higher to use

There are commands for:

{% for c in commands %}

- [{{ c.desc }}](#{{ c.anchor }})

{% endfor %}

{% for c in commands %}

{: #{{ c.anchor }} }

## {{ c.title }}

{{ c.exp | replace_inline: replacements | render_full }}

The command has the following form:

`/kubejs_tfc {{ c.form }}`{:.language-command}

{% if c.args %}
{% for arg in c.args %}

- {{ arg | replace_inline: replacements | render_full }}

{% endfor %}
{% endif %}

{{ c.clean }}

{% endfor %}
