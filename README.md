Blockd Voxel Game Engine
=========

Blockd is a game engine to create cool "Bloxel" based games.

  1. Download the engine.
  2. Create your project.
  3. Publish your packaged game!

Well, being that this is a repo for the source code, I must show how to properly obtain and use the source for the engine.

### <a name="obtain_requirements"></a>Obtain Requirements

Here's what you need:
  1. [BlitzMax Full Version, 1.48/1.49] [BlitzMax]
  2. (Windows) [A BlitzMax-Tailored MinGW Installation](#mingw_install), Cygwin Regular Install + (Cygwin) GNU Make

  (Linux) [A lot of stuff](http://www.blitzmax.com/Community/posts.php?topic=88613), GNU Make
  
  (OSX) GCC/G++, GNU Binutils, GNU Make
  3. [Required BlitzMax Modules](#blitzmax_modules)
  4. [Blockd Source Code](#obtain_source)

### <a name="build_source"></a>Building the Source
Blockd uses GNU Make to build everything.
Go to the root Blockd directory in a shell (Cygwin Terminal under Windows), and run *make all*.
Generally in this project the supported Make commands are *all* and *clean*.

#### <a name="mingw_install"></a>MinGW Installation (Windows)
To compile the modules used in Blockd (on windows), you will need a compatible version of MinGW paired with some environment variables and a modified PATH.

#####Here's how to do it:
1. [Get MinGW] [MinGW]
2. Install the GCC, G++, and the GNU Binutils packages from MinGW-Get.
3. Set the **user** environment variable named *MinGW* to the path of your MinGW installation. (If I installed MinGW to *C:\MinGW*, I would put *C:\MinGW* as the environment variable value.)
4. Append a semicolon, then the path of your MinGW installation's bin folder to the **system** environment variable PATH. (If I installed MinGW to *C:\MinGW*, I would **add** *;C:\MinGW\bin* to the **end** of the enviroment variable *PATH*.)

#### <a name="blitzmax_modules"></a>Required BlitzMax Modules
Blockd uses a number of free BlitzMax modules to speed the development process and enhance the experience. To retrieve these modules, listed below, either go to their website or download the "Modules Package" (tar.gz format) in the source heirarchy or the websites given for each module (may have dead links).

Once your modules are in the *(BlitzMax Installation)/mod* folder, open up the BlitzMax IDE and click Ctrl+D, to compile the modules (or go to Program->Build Modules)

#### <a name="obtain_source"></a>Obtain Source
Clone the repo, or download a zip of the repository using Github's handy "Download Zip" button.


  [BlitzMax]: http://blitzmax.com/Products/_index_.php
  [MinGW]: http://sourceforge.net/projects/mingw/files/
