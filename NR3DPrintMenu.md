# **Grab FreeCAD src** #
Download the FreeCAD source tar.gz from here:

`http://downloads.sourceforge.net/project/free-cad/FreeCAD%20Source/freecad-0.13.1830.tar.gz`

unpack the tar.gz file.

# **Install FreeCAD Dependencies** #

Run:

`sudo apt-get install build-essential cmake python python-matplotlib libtool libcoin60-dev libsoqt4-dev libxerces-c-dev libboost-dev libboost-filesystem-dev libboost-regex-dev libboost-program-options-dev libboost-signals-dev libboost-thread-dev libqt4-dev libqt4-opengl-dev qt4-dev-tools python-dev libopencascade-dev gfortran libeigen3-dev libqtwebkit-dev libode-dev swig libzipios++-dev freetype*`

# **Install Slic3r Dependencies** #

Run:

`sudo apt-get install git build-essential libgtk2.0-dev libwxgtk2.8-dev libwx-perl libmodule-build-perl libnet-dbus-perl`

then:

`sudo apt-get install cpanminus`

then:

`sudo apt-get install curl
curl -L http://cpanmin.us | perl - --sudo App::cpanminus`

then:

`sudo apt-get install libwx-perl`

then:

`sudo cpanm Boost::Geometry::Utils Math::Clipper \
> Math::ConvexHull Math::ConvexHull::MonotoneChain Math::Geometry::Voronoi Math::PlanePath Moo Wx XML::SAX`

# **Pronterface Dependencies** #

Run:

`sudo apt-get install python python-serial python-wxgtk2.8 python-tk git-core`

# **Placing NR 3D Print Files into FreeCAD** #

Grab new "CommandDoc.cpp" file from:

`https://the-technocopia-project.googlecode.com/git/HandE/3DPrint/CommandDoc.cpp`

and replace this file:

`freecad-0.13.1830/src/Gui/CommandDoc.cpp`

Grab new "Workbench.cpp" file from:

`https://the-technocopia-project.googlecode.com/git/HandE/3DPrint/Workbench.cpp`

and replace this file:

`freecad-0.13.1830/src/Gui/Workbench.cpp`

Grab "Replicator.svg" file from:

`https://the-technocopia-project.googlecode.com/git/HandE/3DPrint/Replicator.svg`

and copy into:

`freecad-0.13.1830/src/Gui/Icons/Replicator.svg`

Grab new "resource.qrc" file from:

`https://the-technocopia-project.googlecode.com/git/HandE/3DPrint/resource.qrc`

and replace:

freecad-0.13.1830/src/Gui/Icons/resource.qrc

Grab new "freecadsplash.png" from:

`https://the-technocopia-project.googlecode.com/git/HandE/3DPrint/freecadsplash.png`

and replace this file:

`freecad-0.13.1830/src/Gui/Icons/freecadsplash.png`

# **Compile FreeCAD** #

Open up the terminal and change into the directory containing the unpacked & modified freecad-0.13.1830.

First create a directory:

`mkdir free-cad-build`

Change into the new directory:

`cd free-cad-build`

`cmake ../freecad-0.13.1830`

`make`

Now grab:

`https://the-technocopia-project.googlecode.com/git/HandE/3DPrint/NeuronRobotics.tar.gz`

Unpack the archive and you should get a folder labeled NeuronRobotics.
Copy that folder into free-cad-build/src/

FreeCAD should now be ready to run with the new module.