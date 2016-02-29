# Install git #

To install git on any reasonably recent Ubuntu distribution (document written using 12.04), run:

> `sudo apt-get install git gitg meld`

This will download and install the git client, a gnome-based branch visualizer and a quite nice diff/merge tool.

## Kuldge meld ##

Git and meld don’t get along perfectly out of the box, so you’ll need to do a bit of kludging to make them work together. Thanks to Nathan Hoad for [his blog post](http://nathanhoad.net/how-to-meld-for-git-diffs-in-ubuntu-hardy) on how precisely to do this. If you don’t want to read that post, here’s the whole thing in three steps.

### 1 Create the kludge script ###

Run:

> `sudo gedit /usr/bin/meld-kludge`

Then enter your password to open up gedit. We’re putting the script here because it’ll be handy for it to be in the PATH. In gedit, paste the following script:

```
#!/usr/bin/python
import sys
import os
os.system('meld "%s" "%s"' % (sys.argv[2], sys.argv[5]))
```

Save and close gedit. This script just takes the arguments that git wants to give and gives the relevant ones to meld in the order it wants. Don’t worry about it.

### 2 Make it executable ###

Run:

> `sudo chmod +x /usr/bin/meld-kludge`

Then enter your password. A script isn’t much good without execution permissions.

### 3 Configure git to use the kludge ###

Run:

> `git config --global diff.external meld-kludge`

This tells git to use your script (which will be more or less exactly like using meld proper).

## Configure git for pushing ##

As per the instructions at http://code.google.com/p/the-technocopia-project/source/checkout, you will need to add a password to your .netrc file (which should live in your home directory. This file will be used as your authentication when you push code back to the main repository. Go to https://code.google.com/hosting/settings and generate a password. Then copy the line from that page that looks like this:

> `machine code.google.com login you@gmail.com password P4SSW0RDH3R3`

into your .netrc file and save it.

# Clone the repository #

After installing git, run the following command from the parent directory of where you want the project to live (e.g. ~/projects):

> `git clone https://code.google.com/p/the-technocopia-project/`

This will download all of the technocopia project’s git repository. The repository also uses a git feature called submodules. For a pretty decent tutorial on how to use them, check out [this link](http://git-scm.com/book/en/Git-Tools-Submodules).

If you don’t feel like wading through that (remarkably concise) prose, just know that if you want to use the submodule, you’ll need to run the submodule init and update commands as follows:

> `git submodule init`

> `git submodule update`

# Compile FreeCAD #

The FreeCAD wiki contains a bunch of information about FreeCAD in general, and how to compile it in particular. It doesn’t make sense to reproduce that documentation here, but I will walk you through it complete with deeplinks. In case any of them change, feel free to look at the whole document [here](http://sourceforge.net/apps/mediawiki/free-cad/index.php?title=CompileOnUnix).

## Install dependencies ##

You’ll want to install a bunch of other libraries that FreeCAD relies on to do various pieces of work. The full list for Ubuntu/Debian is [here](http://sourceforge.net/apps/mediawiki/free-cad/index.php?title=CompileOnUnix). You could enter all that by hand, or you could just copy/paste/run:

> `sudo apt-get install build-essential cmake python python-matplotlib libtool libcoin60-dev libsoqt4-dev libxerces-c-dev libboost-dev libboost-filesystem-dev libboost-regex-dev libboost-program-options-dev  libboost-signals-dev libboost-thread-dev libqt4-dev libqt4-opengl-dev qt4-dev-tools python-dev libopencascade-dev gfortran libeigen3-dev libqtwebkit-dev libode-dev swig libzipios++-dev`

Enter your password and confirm that you really do want to install the wall of libraries that appear. The download is about 230MB at the time of this writing and installs to around half a GB. This can take a while (10ish minutes for me). Other than that, this should go relatively smoothly.

## Configure FreeCAD ##

Now that you have all the prerequisites, FreeCAD’s build/install tools want to verify that you have everything ready to go. We’re going to be using what they call an [“out-of-source” build](http://sourceforge.net/apps/mediawiki/free-cad/index.php?title=CompileOnUnix#Out-of-source_build) (which just means the generated stuff lives in a different directory). This means that first we need to change to the directory we want the output to go in. To do this change directory to:

> `cd the-technocopia-project/third-party/free-cad-build`

You’ll want to stay in this directory for the rest of this section. To actually do the configuration, run:

> `cmake ../free-cad`

This will do all the rest of the pre-build configuration that FreeCAD needs.

## Compile FreeCAD proper ##

Now that all that’s out of the way, run:

> `make`

Seems simple after all that, right? Well, it’ll take 10-30 minutes to finish depending on how fast your computer is.

### Test FreeCAD ###

FreeCAD has some automated tests you can run with:

> `./bin/FreeCAD -t 0`

### Start FreeCAD ###

Alternately, you can just start it with:

> `./bin/FreeCAD`