---
title: Print Chunk Data
anchor: print-chunk-data
cat:
    - kubejs_tfc
    - 1.21.1
    - command
group: print
desc: Printing the TFC `ChunkData` in the player's current chunk
form: print_chunk_data
exp: Prints the server [`Chunkdata`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/world/chunkdata/ChunkData.java) of the current chunk in an ostensibly readable format. Only the infomration available will be printed. That is to say, if the status is `EMPTY`{:.e}, `CLIENT`{:.e} (somehow), or `INVALID`{:.e} no additional information will be printed; and the surface and aquifer heights will only be printed if the status is `FULL`{:.e}
---
