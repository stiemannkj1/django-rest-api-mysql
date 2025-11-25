#!/bin/sh

set -e

SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; printf "$PWD" )"

OS_TYPE=$(uname)

case "$OS_TYPE" in
    Darwin)
        OS_TYPE="macos"
        echo "OS: $OS_TYPE"
        ;;
    Linux)
        OS_TYPE="linux"
        echo "OS: $OS_TYPE"
        ;;
    *)
        echo "OS: UNKNOWN ($OS_TYPE)"
        ;;
esac

if [ -z "$ARCH" ]; then
	ARCH="$(uname -m)"
fi

case "$ARCH" in
    i386 | i686 | x86_64 | amd64)
        ARCH="amd64"
        ;;
    armv6* | armv7* | aarch64 | arm64)
        ARCH="arm64"
        ;;
    *)
		printf "Unsupported architecture detected: $ARCH.\n"
		exit 1
        ;;
    "")
		printf "Failed to detect architecture. Export ARCH with your current architecture and rerun the install.\n"
		exit 1
        ;;
esac

echo "ARCH: $ARCH"

if  [ ! -f "$SCRIPT_PATH/.java/Contents/Home/bin/java" ] && [ ! -f "$SCRIPT_PATH/.java/bin/java" ]; then
    echo "java not found. Extracting JDK..."
    tar -xzf "$SCRIPT_PATH/jre_${OS_TYPE}_${ARCH}_hotspot_11.0.29_7.tar.gz" -C "$SCRIPT_PATH/.java" --strip-components=1
else
    echo "java is already installed."
fi

{ 
    chmod +x "$SCRIPT_PATH/.java/Contents/Home/bin/java" && export JAVA_HOME="$SCRIPT_PATH/.java/Contents/Home"
} || {
    chmod +x "$SCRIPT_PATH/.java/bin/java" && export JAVA_HOME="$SCRIPT_PATH/.java";
}

export PATH="$JAVA_HOME/bin:$PATH"

if  [ ! -f "$SCRIPT_PATH/.java/jmeter/bin/jmeter" ]; then
    echo "jmeter not found. Extracting Jmeter..."
    tar -xzf "$SCRIPT_PATH/apache-jmeter-5.6.3.tar.gz" -C "$SCRIPT_PATH/.java/jmeter" --strip-components=1
    chmod +x "$SCRIPT_PATH/.java/jmeter/bin/jmeter"
else
    echo "jmeter is already installed."
fi

"$SCRIPT_PATH/.java/jmeter/bin/jmeter" -n -t setup.jmx    -l ".java/jmeter/setup$(date +%s).jtl" "$@" ||
    { echo "Setup failed!" && exit 1; }
RESULTS=".java/jmeter/results$(date +%s)"
"$SCRIPT_PATH/.java/jmeter/bin/jmeter" -n -t testplan.jmx -l "$RESULTS.jtl" "$@"
"$SCRIPT_PATH/.java/jmeter/bin/jmeter" -o "$RESULTS"      -g "$RESULTS.jtl"
