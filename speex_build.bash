IDZ_SPEEX_VERSION=1.2.0
IDZ_OGG_VERSION=1.3.1
IDZ_IOS_SDK_VERSION=`xcrun --sdk iphoneos --show-sdk-version`

pushd $IDZ_BUILD_ROOT 
echo IDZ_BUILD_ROOT is $IDZ_BUILD_ROOT

mkdir -p libspeex/$IDZ_SPEEX_VERSION
pushd libspeex/$IDZ_SPEEX_VERSION 

curl -O https://ftp.osuosl.org/pub/xiph/releases/speex/speex-$IDZ_SPEEX_VERSION.tar.gz
tar xvfz speex-$IDZ_SPEEX_VERSION.tar.gz

IDZ_LIBDIR=speex-$IDZ_SPEEX_VERSION
# Phone builds
export IDZ_EXTRA_CONFIGURE_FLAGS=--with-ogg=$IDZ_BUILD_ROOT/libogg/$IDZ_OGG_VERSION/install-iPhoneOS-armv7
idz_configure armv7 $IDZ_IOS_SDK_VERSION $IDZ_LIBDIR/configure
export IDZ_EXTRA_CONFIGURE_FLAGS=-with-ogg=$IDZ_BUILD_ROOT/libogg/$IDZ_OGG_VERSION/install-iPhoneOS-armv7s
idz_configure armv7s $IDZ_IOS_SDK_VERSION $IDZ_LIBDIR/configure
export IDZ_EXTRA_CONFIGURE_FLAGS=--with-ogg=$IDZ_BUILD_ROOT/libogg/$IDZ_OGG_VERSION/install-iPhoneOS-arm64
idz_configure arm64 $IDZ_IOS_SDK_VERSION $IDZ_LIBDIR/configure

# Simulator build
export IDZ_EXTRA_CONFIGURE_FLAGS=--with-ogg=$IDZ_BUILD_ROOT/libogg/$IDZ_OGG_VERSION/install-iPhoneSimulator-i386
idz_configure i386 $IDZ_IOS_SDK_VERSION $IDZ_LIBDIR/configure

export IDZ_EXTRA_CONFIGURE_FLAGS=--with-ogg=$IDZ_BUILD_ROOT/libogg/$IDZ_OGG_VERSION/install-iPhoneSimulator-x86_64
idz_configure x86_64 $IDZ_IOS_SDK_VERSION $IDZ_LIBDIR/configure


pushd install-iPhoneSimulator-x86_64/lib
idz_combine libspeexall.a *.a
popd

pushd install-iPhoneSimulator-i386/lib
idz_combine libspeexall.a *.a
popd

pushd install-iPhoneOS-armv7/lib
idz_combine libspeexall.a *.a
popd

pushd install-iPhoneOS-armv7s/lib
idz_combine libspeexall.a *.a
popd

pushd install-iPhoneOS-arm64/lib
idz_combine libspeexall.a *.a
popd

idz_fw Speex libspeexall.a install-iPhoneSimulator-i386/include/speex

popd
echo "Build complete in directory `pwd`"

