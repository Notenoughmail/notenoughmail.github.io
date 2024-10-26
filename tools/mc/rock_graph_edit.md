---
layout: page
title: TFCGenViewer Rock Graph Editor
permalink: /mc/tools/tfcgv_rock_graph/edit/
parent: Minecraft Tools
has_children: false
has_toc: false
extra_header: rock_graph_editor
---

<body onload="populateFromQuery()"></body>

# TFCGenViewer Rock Graph Editor

<form id="all">
<label for="ocean">Ocean Floor Layers:</label><br>

<textarea id="ocean" name="ocean" rows="5" columns="20" class="visualize"></textarea><br>

<label for="land">Land Layers:</label><br>

<textarea id="land" name="land" rows="5" columns="20" class="visualize"></textarea><br>

<label for="uplift">Uplift Layers:</label><br>

<textarea id="uplift" name="uplift" rows="5" columns="20" class="visualize"></textarea><br>

<label for="volcanic">Volcanic Layers:</label><br>

<textarea id="volcanic" name="volcanic" rows="5" columns="20" class="visualize"></textarea><br>

<label for="bottom">Bottom Rocks:</label><br>

<textarea id="bottom" name="bottom" rows="5" columns="20" class="visualize"></textarea><br>

<label for="layers">Layers:</label><br>

<ul id="layers" name="layers" class="visualize"></ul>

<label for="add_layer">Create layer:</label><br>

<input id="add_layer" name="add_layer" type="text"><br>

<button type="button" onClick="addLayer()">Add Layer</button>

<br><br>

<button type="button" onClick="createGraph()">Visualize</button>

</form>
