# Use, modification, and distribution are
# subject to the Boost Software License, Version 1.0. (See accompanying
# file LICENSE.txt)
#
# Copyright Rene Rivera 2020.

# For Drone CI we use the Starlark scripting language to reduce duplication.
# As the yaml syntax for Drone CI is rather limited.
#
#
globalenv={}
linuxglobalimage="cppalliance/droneubuntu1804:1"
windowsglobalimage="cppalliance/dronevs2019"

def main(ctx):
  return [
  linux_cxx("GCC-10", "g++", packages="g++-10", buildtype="boost", buildscript="drone", image=linuxglobalimage, environment={'B2_ARGS': 'cxxstd=14,17,2a toolset=gcc-10 cxxflags="--coverage -fsanitize=address,leak,undefined -fno-sanitize-recover=undefined -DBOOST_TRAVISCI_BUILD" linkflags="--coverage  -lasan -lubsan"', 'DRONE_JOB_UUID': 'b6589fc6ab'}, globalenv=globalenv, privileged=True),
  linux_cxx("GCC-8", "g++", packages="g++-8", buildtype="boost", buildscript="drone", image=linuxglobalimage, environment={'B2_ARGS': 'cxxstd=14,17,2a toolset=gcc-8 cxxflags="--coverage -fsanitize=address,leak,undefined -fno-sanitize-recover=undefined -DBOOST_TRAVISCI_BUILD" linkflags="--coverage  -lasan -lubsan"', 'DRONE_JOB_UUID': '356a192b79'}, globalenv=globalenv, privileged=True),
  linux_cxx("GCC-5", "g++", packages="g++-5", buildtype="boost", buildscript="drone", image=linuxglobalimage, environment={'B2_ARGS': 'cxxstd=1y toolset=gcc-5 cxxflags="--coverage -fsanitize=address,leak,undefined -fno-sanitize-recover=undefined -DBOOST_TRAVISCI_BUILD" linkflags="--coverage  -lasan -lubsan"', 'DRONE_JOB_UUID': 'da4b9237ba'}, globalenv=globalenv, privileged=True),
  linux_cxx("Clang-6", "g++", packages="clang-6.0", llvm_os="bionic", llvm_ver="6", buildtype="boost", buildscript="drone", image=linuxglobalimage, environment={'B2_ARGS': 'cxxstd=14 toolset=clang-6 cxxflags="--coverage -fsanitize=address,leak,undefined -fno-sanitize-recover=undefined -DBOOST_TRAVISCI_BUILD" linkflags="--coverage -fsanitize=address,leak,undefined"', 'DRONE_JOB_UUID': '77de68daec'}, globalenv=globalenv, privileged=True),
  linux_cxx("Clang-10, libc++", "g++", packages="clang-10 libc++-10-dev libc++abi-10-dev", llvm_os="bionic", llvm_ver="10", buildtype="boost", buildscript="drone", image=linuxglobalimage, environment={'B2_ARGS': 'cxxstd=14,17,20 toolset=clang-10 cxxflags="-stdlib=libc++ --coverage -fsanitize=address,leak,undefined -fno-sanitize-recover=undefined -DBOOST_TRAVISCI_BUILD" linkflags="-stdlib=libc++ --coverage -fsanitize=address,leak,undefined"', 'DRONE_JOB_UUID': '1b64538924'}, globalenv=globalenv, privileged=True),
  linux_cxx("Clang-3.8, libc++", "g++", packages="libc++-dev", buildtype="boost", buildscript="drone", image=linuxglobalimage, environment={'B2_ARGS': 'cxxstd=14 toolset=clang-libc++ cxxflags="--coverage -DBOOST_TRAVISCI_BUILD" linkflags="--coverage"', 'DRONE_JOB_UUID': 'ac3478d69a'}, globalenv=globalenv, privileged=True),
    ]

# from https://github.com/boostorg/boost-ci
load("@boost_ci//ci/drone/:functions.star", "linux_cxx","windows_cxx","osx_cxx","freebsd_cxx")
