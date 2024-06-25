# OPPO Fake Signer
This utility allows you to flash any mods involving the modification of boot.img (including Magisk) on an OPPO A57 / R9s. Flash it after doing such modifications and you should be able to boot.

Please note that you will have to downgrade your aboot before usage.

## Compilation guide
To build the flashable zip:
```
make all ANDROID_NDK_HOME=<path to ndk>
```

To build only the binary for your host computer:
```
make all BUILD_HOST_SIGFAKE_ONLY=true
```
