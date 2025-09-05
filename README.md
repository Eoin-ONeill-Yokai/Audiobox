# AudioBox Ubuntu Container for Distrobox

## WHY?
This is for personal use. It allows me to install bitwig or other DAWs that expect an
Ubuntu system and comes with a preinstalled Yabridge compatibility layer for Windows
VSTs. Use `yabridgectl` for more details.


## Usage

Using distrobox, you can create a container with the following command:

```
distrobox create --image ghcr.io/eoin-oneill-yokai/audiobox:master --pull always --home ~/.audiobox audiobox 
```

