#!/bin/bash

set -Eex

baseDir=$1
targetDir=$2
classesOutputDir=$3
shift 3

# JNI
#gcc -shared -fPIC -O2 -g \
#    -I"$JAVA_HOME/include" -I"$JAVA_HOME/include/linux" \
#    -I"$baseDir/src/main/c" \
#    -o "$targetDir/libjniportaudio.so" \
#    $baseDir/src/main/c/*.c

#javah -classpath $classesOutputDir -d "$targetDir/generated-sources/c" com.portaudio.PortAudio com.portaudio.BlockingStream

# JNA, compile for linux
install -d "$classesOutputDir/linux-x86-64" # <-- automatic sys arch loading by JNA
x86_64-linux-gnu-gcc -shared -fPIC -O2 -g \
    -I"$JAVA_HOME/include" -I"$JAVA_HOME/include/linux" \
    -I"$targetDir/generated-sources/c" \
    -o "$classesOutputDir/linux-x86-64/libjniportaudio.so" \
    $targetDir/generated-sources/c/*.c \
    -lportaudio

# JNA, compile for windows
#if x86_64-w64-mingw32-gcc --version; then
#    install -d "$classesOutputDir/win32-x86-64"
#    x86_64-w64-mingw32-gcc -shared -O2 -g \
#        -I"$JAVA_HOME/include" -I"$JAVA_HOME/include/linux" \
#        -I"$baseDir/src/main/c" \
#        -o "$classesOutputDir/win32-x86-64/jniportaudio.dll" \
#        $baseDir/src/main/c/*.c
#fi

# JNI with native lib loader...
# see https://github.com/scijava/native-lib-loader
#javah -classpath "$classesOutputDir" \
#    -d "$targetDir/generated-sources/c" \
#    com.github.jjYBdx4IL.maven.examples.jnajni.JNIAccessWithLibLoader
#install -d "$classesOutputDir/META-INF/lib/linux_64"
#gcc -shared -fPIC -O2 -g \
#    -I"$JAVA_HOME/include" -I"$JAVA_HOME/include/linux" \
#    -I"$targetDir/generated-sources/c" \
#    -o "$classesOutputDir/META-INF/lib/linux_64/libjniaccesswithlibloader.so" \
#    "$baseDir/src/main/c/jniaccesswithlibloader.c"
