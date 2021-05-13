# disasm.sh
# created by Phonedolly
# 2021_03_09

#!/bin/bash

# architecture for vmlinux
# 1: x86
# 2: armv7
# 3: armv8
# ARCH=0

# TODO add handler for arguments
# Check objdump is installed
if [ ! $(command -v objdump) ]; then
    echo "objdump is not installed"
    exit 1
fi

# Check awk is installed
if [ ! $(command -v awk) ]; then
    echo "awk is not installed"
    exit 1
fi

# Check vmlinux and System.map exist
if [ ! -e vmlinux ] || [ ! -e System.map ]; then
    echo "vmlinux or System.map doesn't exist"
    exit 1
fi

# Select Proper Architecture for vmlinux
echo -e "which is a architecture for your vmlinux?"
echo "1. x86"
echo "2. armv7"
echo "3. armv8"
read ARCH_NUM

case $ARCH_NUM in
"1") ARCH="x86_64" ;;
"2") ARCH="x86" ;;
"2") ARCH="armv7" ;;
"3") ARCH="armv8" ;;
esac

if [ "$ARCH" = "$(echo $(uname -p))" ]; then
    echo "Your system's architecture and target architecture are same."
else
    echo "Your system's architecture and target architecture are not same."
fi

# # Check vmlinux's target arch is not same as host
# # TODO automatically switch to proper arch
# if objdump -x vmlinux | grep "architecture: UNKNOWN!" >/dev/null; then
#     echo "vmlinux's ABI and your system's one is not same"
#     exit 1
# fi

# TODO What is a 'symbol'?
# List available symbols
awk '{ print $3 }' System.map >available_symbols
echo "available functions are listed to 'available_symbols'"

# Select function you want
echo -e "enter function name your want : "
read FUNC_NAME
echo Function Name : $FUNC_NAME

# TODO identify function's address in System.map
LINE_NUMBER="$(
    awk -v FUNC_NAME="/$FUNC_NAME/" 'do_group_exit {print "FUNC NAME: " FUNC_NAME}' System.map
)"
# grep -on "[a-z0-9_]*\n" > log Sys_map
echo $LINE_NUMBER
# TODO select one options to disassemble vmlinux : wide-disasm or specific-disasm by address

# TODO disassemble vmlinux using objdump
