# AudioBox Ubuntu Container for Distrobox

## WHY?
This is for personal use. It allows me to install bitwig or other DAWs that expect an
Ubuntu system and comes with a preinstalled Yabridge compatibility layer for Windows
VSTs. Use `yabridgectl` for more details.


## Usage

Using distrobox, you can create a container with the following command:

```
distrobox create --image ghcr.io/eoin-oneill-yokai/audiobox:stable --pull always --home ~/.audiobox audiobox 
```

You can alternatively use the branch `latest` instead of `stable`. `latest` will more often than not be a similar experience to `stable`, but there are certain circumstsances where software might be using the latest version that might not lead to the most productive audio workspace environment. Please keep this in mind! 
