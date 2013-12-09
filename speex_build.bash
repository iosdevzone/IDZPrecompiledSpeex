pushd $IDZ_BUILD_ROOT
echo IDZ_BUILD_ROOT is $IDZ_BUILD_ROOT

mkdir -p libspeex/1.2rc1
pushd libspeex/1.2rc1

curl -O http://downloads.xiph.org/releases/speex/speex-1.2rc1.tar.gz
tar xvfz speex-1.2rc1.tar.gz

IDZ_LIBDIR=speex-1.2rc1
# Phone builds
export IDZ_EXTRA_CONFIGURE_FLAGS=--with-ogg=$IDZ_BUILD_ROOT/libogg/1.3.1/install-iPhoneOS-armv7
idz_configure armv7 7.0 $IDZ_LIBDIR/configure
export IDZ_EXTRA_CONFIGURE_FLAGS=-with-ogg=$IDZ_BUILD_ROOT/libogg/1.3.1/install-iPhoneOS-armv7s
idz_configure armv7s 7.0 $IDZ_LIBDIR/configure
export IDZ_EXTRA_CONFIGURE_FLAGS=--with-ogg=$IDZ_BUILD_ROOT/libogg/1.3.1/install-iPhoneOS-arm64
idz_configure arm64 7.0 $IDZ_LIBDIR/configure

# Simulator build
export IDZ_EXTRA_CONFIGURE_FLAGS=--with-ogg=$IDZ_BUILD_ROOT/libogg/1.3.1/install-iPhoneSimulator-i386
idz_configure i386 7.0 $IDZ_LIBDIR/configure

export IDZ_EXTRA_CONFIGURE_FLAGS=--with-ogg=$IDZ_BUILD_ROOT/libogg/1.3.1/install-iPhoneSimulator-x86_64
idz_configure x86_64 7.0 $IDZ_LIBDIR/configure


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
