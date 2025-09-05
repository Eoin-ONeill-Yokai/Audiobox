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

We're using a virtual home folder `~/.audiobox`; This home folder should house all of your wine prefixes and installations. Likewise, 


### Installing and Exporting `bitwig-studio`

Bitwig Studio is a digital audio workstation program compatible, prebuilt and packaged for linux directly. However, on immutable systems, the only advertised option for installation is flatpak. While flatpak is often the ideal packaging format for immutable distributions, it comes with the drawback that it doesn't integrate well with external applications or dynamic linking of third party applications (think your average clap or vst plugin!) For this reason, this container is the ideal way to install bitwig studio.

Go to the website and download whatever product is available to your account. Note that demo and 8-track versions of bitwig should be compatible as well! When asked which binary to download, select `Ubuntu` -- this will download a `.deb` file to your downloads folder. After downloading the `.deb` file from the Bitwig Studio website, run the following within the audiobox container (remember to `distrobox enter audiobox`!):

```
sudo apt install ~/../Downloads/bitwig-studio-$version.deb # Home in this case is /home/username/.audiobox. We want to get to the real home's downloads!
sudo distrobox-export --app bitwig-studio # This will export an application shortcut for your start menu and/or app launcher for quickly launching bitwig in the container. 
```

