#!/bin/sh
set -e

if command -v gradle >/dev/null 2>&1; then
    exec gradle "$@"
fi

APP_HOME=$(cd "$(dirname "$0")" && pwd)
GRADLE_VERSION="8.7"
GRADLE_DIR="$HOME/.gradle/wrapper/dists/gradle-$GRADLE_VERSION-bin"

if [ ! -x "$GRADLE_DIR/gradle-$GRADLE_VERSION/bin/gradle" ]; then
    mkdir -p "$GRADLE_DIR"
    TMP_ZIP="/tmp/gradle-$GRADLE_VERSION-bin.zip"
    if command -v curl >/dev/null 2>&1; then
        curl -sSL "https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip" -o "$TMP_ZIP"
    elif command -v wget >/dev/null 2>&1; then
        wget -q "https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip" -O "$TMP_ZIP"
    fi
    if [ -f "$TMP_ZIP" ]; then
        unzip -q -o "$TMP_ZIP" -d "$GRADLE_DIR"
        rm -f "$TMP_ZIP"
    fi
fi

if [ -x "$GRADLE_DIR/gradle-$GRADLE_VERSION/bin/gradle" ]; then
    exec "$GRADLE_DIR/gradle-$GRADLE_VERSION/bin/gradle" "$@"
fi

exec gradle "$@"
