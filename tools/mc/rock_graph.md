---
layout: page
title: TFCGenViewer Rock Graph
permalink: /mc/tools/tfcgv_rock_graph/
parent: Minecraft Tools
has_children: false
has_toc: false
extra_header: rock_graph
nav_exclude: true
search_exclude: true
---

<body onload="parse()"></body>

# TFCGenViewer Rock Graph

<pre class="mermaid" id="mermaid_graph">
flowchart TD
A((It seems as if the query was malformed, uh oh))
</pre>

<a href="?ocean_type=[igneous_extrusive];land_type=[igneous_extrusive|sedimentary];uplift_type=[sedimentary|uplift];volcanic_type=[igneous_extrusive|igneous_extrusive_x2];bottom_type=[gneiss|schist|diorite|granite|gabbro];layers=[felsic|intermediate|mafic|igneous_extrusive|igneous_extrusive_x2|phyllite|slate|marble|quartzite|sedimentary|uplift];felsic=[granite~bottom];intermediate=[diorite~bottom];mafic=[gabbro~bottom];igneous_extrusive=[andesite~intermediate|basalt~mafic|dacite~intermediate|rhyolite~felsic];igneous_extrusive_x2=[andesite~igneous_extrusive|basalt~igneous_extrusive|dacite~igneous_extrusive|rhyolite~igneous_extrusive];phyllite=[gneiss~bottom|phyllite~bottom|schist~bottom];slate=[phyllite~phyllite|slate~bottom];marble=[marble~bottom];quartzite=[quartzite~bottom];sedimentary=[chalk~marble|chert~quartzite|claystone~slate|conglomerate~slate|dolomite~marble|shale~slate];uplift=[diorite~sedimentary|gabbro~sedimentary|granite~sedimentary|marble~bottom|quartzite~bottom|slate~phyllite]">View TFC's default generation for 1.21</a>

[Open the editor](/editor/)
