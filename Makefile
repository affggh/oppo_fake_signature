# Requires the $ANDROID_NDK_HOME environment variable to be set
# containing the base path to Android NDK r19 or higher.

PREFIX 		= $(ANDROID_NDK_HOME)/toolchains/llvm/prebuilt/linux-x86_64/bin/
ANDROID_API	?= 21
TARGET 		= aarch64-linux-android

CC			= $(PREFIX)$(TARGET)$(ANDROID_API)-clang

build:
	$(CC) sigfake.c -o sigfake

clean:
	rm -f sigfake

all:
	clean build
