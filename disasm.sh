# disasm.sh
# created by Phonedolly
# 2021_03_09

#!/bin/bash

# TODO add handler for arguments

# Check objdump is installed
if [ ! $(command -v objdump) ]; then
    echo "objdump is not on your system"
    exit 1
fi

# Check vmlinux and System.map exist
if [ ! -e vmlinux ] || [ ! -e System.map ]; then
    echo "vmlinux or System.map doesn't exist"
    exit 1
fi

# Check vmlinux's target arch is not same as host
# TODO automatically switch to proper arch
if objdump -x vmlinux | grep "architecture: UNKNOWN!" >/dev/null; then
    echo "vmlinux's ABI and your system's one is not same"
    exit 1
fi

# Select function you want
echo -e "enter function name your want : "
read FUNC_NAME

# TODO identify function's address in System.map

# TODO select one options to disassemble vmlinux : wide-disasm or specific-disasm by address

# TODO disassemble vmlinux using objdump
