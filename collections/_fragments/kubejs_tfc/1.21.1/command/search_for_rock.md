---
title: Search for Rock
anchor: search-for-rock
cat:
    - kubejs_tfc
    - 1.21.1
    - command
desc: Searching for a specific rock type
form: search_for_rock <rock> <radius> <sample_spacing> [<elevation>]
args:
    - '`<rock>`[[1]]: A block. the raw rock block to find'
    - "`<radius>`[[2]]: A number {% in_range 16,5000 %}, the radius in blocks to search around the player's position"
    - '`<sample_spacing>`[[3]]: A number {% in_range 16,,) %}, the spacing in blocks between each concentric search region'
    - '`[<elevation>]`[[4]]: A number. If present, the elevation to search at'
exp: Searches for the specified rock block in the world at the surface or a specified elevation 
---
