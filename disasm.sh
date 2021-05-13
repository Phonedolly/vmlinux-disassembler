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
echo "1. x86_64"
echo "2. x86"
echo "3. armv7l"
echo "3. armv8"
read ARCH_NUM

case $ARCH_NUM in
"1") ARCH="x86_64" ;;
"2") ARCH="x86" ;;
"3") ARCH="armv7l" ;;
"4") ARCH="armv8" ;;
esac

if [ "$ARCH" = "$(echo $(uname -m))" ]; then
    echo "Your system's architecture and target architecture are same."
    CROSS_PLATFORM=false
else
    echo "Your system's architecture and target architecture are not same."
    CROSS_PLATFORM=true
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
LINE_NUMBER="$(grep -n "$FUNC_NAME" System.map | cut -d ":" -f 1)"
echo $LINE_NUMBER
# LINE_NUMBER="$(
#     awk -v FUNC_NAME="$FUNC_NAME" '/FUNC_NAME/ {print $1, $2, $3}' System.map
# )"
# grep -on "[a-z0-9_]*\n" > log Sys_map

# awk '/^808771b0 t __schedule$/ {print NR}' System.map
# awk '/__schedule/ {print $1, $2, $3 }' System.map
# awk -v FUNC_NAME="/__schedule/" 'FUNC_NAME {print $1, $2, $3}' System.map

# TODO select one options to disassemble vmlinux : wide-disasm or specific-disasm by address

# TODO disassemble vmlinux using objdump
