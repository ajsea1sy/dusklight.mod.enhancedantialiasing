<img src="res/icon.png" width="200">

# Enhanced Anti-Aliasing for Dusklight
Adds configurable SMAA anti-aliasing with luma, depth, authored normal edge detection, and more. Adapted from an open-source template by Automata.
# Attribs
This mod is based on the SMAA implementation from Automata-RTX’s Dusklight mods:

https://github.com/automata-rtx/dusklight-mods

The SMAA rendering code and WGSL shaders were adapted from the `smaa` mod in the repository. The original implementation includes techniques based on publicly documented SMAA and CMAA2 research.

This version adds adaptive detail protection, which raises the luma edge threshold in high-frequency texture detail to reduce excessive texture blurring while preserving geometric edge detection.

SMAA was developed by Jorge Jimenez, Jose I. Echevarria, Tiago Sousa, Diego Gutierrez, and others:

https://github.com/iryoku/smaa

# Licensing
`SMAA` is distributed under the MIT License.

`dusklight-mods` and `Enhanced Anti-Aliasing` are distributed under the GPL-3.0 License.
