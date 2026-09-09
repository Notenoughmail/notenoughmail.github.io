---
title: List IDs
anchor: list-ids
cat:
    - kubejs_tfc
    - 1.21.1
    - command
group: data
desc: Listing the contents of a data type
form: list_ids <data_type> [<page>]
args:
    - '`<data_type>`[[1]]: The data type to list entries of'
    - '`[<page>]`[[2]]: A non-negative integer, the page to list. Will be clamped to available pages of results. Optional'
exp: Prints a list of data entries handled by a data type. Each entry can be clicked to [describe](#describe) it. The entries are printed in alphabetical order in a paginated view. The gold arrows below the list of entries can be used to see the previous and next pages
---

An example: `/kubejs_tfc list_ids tfc:fuel 2`{: .language-command }
