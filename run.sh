#!/bin/sh

# JAVA="/usr/lib64/jvm/java-17-openjdk/bin/java"
JAVA="$HOME/.var/app/org.prismlauncher.PrismLauncher/data/PrismLauncher/java/eclipse_temurin_jre17.0.13+11/bin/java"
JVM_ARGS="-Xmx16G"
MC_VERSION="forge:1.20.1"
WORK_DIR="$PWD/mc_instance"
PACK_TOML="file://$PWD/packwiz/pack.toml"
WRAPPER_CMD="gamemoderun"

# Tests
test ! -f $(echo $PACK_TOML | sed  "s/file\:\/\///") && {
  echo "$PACK_TOML is not found!"
  exit 1
}
if ! command -v portablemc 2>&1>/dev/null; then
  echo "portablemc is not found in \$PATH"
  exit 1
fi

# Setup Working Dir
test ! -d $WORK_DIR && mkdir $WORK_DIR
cd $WORK_DIR

# Pre launche
test ! -f packwiz-installer-bootstrap.jar && {
  echo "Downloading Packwiz Installer Bootstrap"
  wget https://github.com/packwiz/packwiz-installer-bootstrap/releases/download/v0.0.3/packwiz-installer-bootstrap.jar
}
"$JAVA" -jar packwiz-installer-bootstrap.jar -g -s both $PACK_TOML

# launche
$WRAPPER_CMD portablemc -v --work-dir $WORK_DIR start --jvm "$JAVA"  $MC_VERSION
