#!/bin/bash

set -ouex pipefail

SCRIPTS=(
    "pre-reqs.sh"
    "packages.sh"
    "initramfs.sh"
    "cleanup.sh"
)

TOTAL=${#SCRIPTS[@]}

for i in "${!SCRIPTS[@]}"; do
    SCRIPT="${SCRIPTS[$i]}"
    NUM=$((i + 1))

    echo "  ·  [$NUM/$TOTAL]  $SCRIPT"

    if bash "$SCRIPT"; then
        echo "     ✓  done"
    else
        echo "     ✗  failed — stopping"
        exit 1
    fi
done

echo ""
echo "  ✓  all done"