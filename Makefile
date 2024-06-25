# Requires the $ANDROID_NDK_HOME environment variable to be set
# containing the base path to Android NDK r19 or higher.

PREFIX 		= $(ANDROID_NDK_HOME)/toolchains/llvm/prebuilt/linux-x86_64/bin/
ANDROID_API	?= 21
TARGET 		= aarch64-linux-android

CC			= $(PREFIX)$(TARGET)$(ANDROID_API)-clang

TOP_LEVEL_DIR		= $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

META_FILES_DIR		= $(TOP_LEVEL_DIR)/packaging

OUT_DIR			= $(TOP_LEVEL_DIR)/out
OUT_SIGFAKE_PKG_DIR	= ${OUT_DIR}/pkg
OUT_FLASHABLE		= ${OUT_DIR}/sigfake.zip
OUT_SIGFAKE		= ${OUT_DIR}/sigfake
OUT_SIGFAKE_HOST	= ${OUT_DIR}/sigfake_host

build:
	mkdir $(OUT_DIR)
ifeq ($(ANDROID_NDK_HOME),)
	$(error ANDROID_NDK_HOME is undefined)
endif
	$(CC) sigfake.c -o ${OUT_SIGFAKE}
	clang sigfake.c -o ${OUT_SIGFAKE_HOST}

package:
	cp -r ${META_FILES_DIR} ${OUT_SIGFAKE_PKG_DIR}
	cp -r ${OUT_SIGFAKE} ${OUT_SIGFAKE_PKG_DIR}
	cd ${OUT_SIGFAKE_PKG_DIR} && zip -r ${OUT_FLASHABLE} .

clean:
	rm -rf $(OUT_DIR)

all: clean build package
