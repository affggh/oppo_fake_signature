# Requires the $ANDROID_NDK_HOME environment variable to be set
# containing the base path to Android NDK r19 or higher.

PREFIX 		= $(ANDROID_NDK_HOME)/toolchains/llvm/prebuilt/linux-x86_64/bin/
ANDROID_API	?= 21
TARGET 		= aarch64-linux-android

CC			= $(PREFIX)$(TARGET)$(ANDROID_API)-clang

META_FILES	= packaging/META-INF

OUT_DIR		= out
OUT_SIGFAKE	= ${OUT_DIR}/sigfake
OUT_FLASHABLE	= ${OUT_DIR}/sigfake.zip

build:
	mkdir $(OUT_DIR)
	$(CC) sigfake.c -o ${OUT_SIGFAKE}

package:
	cp -r ${META_FILES} ${OUT_DIR}
	zip -rj ${OUT_FLASHABLE} ${OUT_DIR}

clean:
	rm -rf $(OUT_DIR)

all: clean build package
