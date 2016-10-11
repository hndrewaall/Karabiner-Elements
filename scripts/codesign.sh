#!/bin/bash

CODESIGN_IDENTITY='69765265394d6559563773744b30705643306d6579773d3d'

# ------------------------------------------------------------
PATH=/bin:/sbin:/usr/bin:/usr/sbin; export PATH

if [ ! -e "$1" ]; then
    echo "[ERROR] Invalid argument: '$1'"
    exit 1
fi

# ------------------------------------------------------------
# sign
cd "$1"
find * -name '*.app' -or -path '*/bin/*' | sort -r | while read f; do
    echo -ne '\033[33;40m'
    echo "code sign $f"
    echo -ne '\033[0m'

    echo -ne '\033[31;40m'
    codesign \
        --force \
        --deep \
        --sign "$CODESIGN_IDENTITY" \
        "$f"
    echo -ne '\033[0m'
done

# verify
find * -name '*.app' -or -path '*/bin/*' | sort -r | while read f; do
    echo -ne '\033[31;40m'
    codesign --verify --deep "$f"
    echo -ne '\033[0m'
done
