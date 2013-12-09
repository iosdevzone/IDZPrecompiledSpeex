IDZPrecompiledSpeex
===================

Speex 1.2rc1 compiled for iOS armv7, armv7, arm64, i386, x86_64

The original source code can be downloaded from http://xiph.org/downloads 

The library has been packaged as a pseudo-framework. To use it simply drag Vorbis.framework into your Xcode project. You will also need to drag the Ogg.framework file from my http://github.com/iosdevzone/IDZPrecompiledOgg repository.

Recreating the Build
--------------------

While the library is ready to use, if you want to recreate the build the script used to download and compile the library can be found in the file `libvorbis_build.bash`. It relies on a number of utility scripts which can be found in my http://github.com/iosdevzone/IDZBuild repository. You will also need libogg.

The following steps will recreate the build from scratch.

```
git clone https://github.com/iosdevzone/IDZBuild
export PATH=`pwd`/IDZBuild:$PATH
git clone https://github.com/iosdevzone/IDZPrecompiledOgg
git clone https://github.com/iosdevzone/IDZPrecompiledSpeex
mkdir -p IDZBuildRoot
export IDZ_BUILD_ROOT=`pwd`/IDZBuildRoot
. IDZPrecompiledOgg/libogg_build.bash
. IDZPrecompiledSpeex/speex_build.bash
```

Licenses
--------

See the `LICENSE` file.
