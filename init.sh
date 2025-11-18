#!/bin/bash
set -e
src="/opt"

if [ "$(id -u)" -eq 0 ]; then
    echo "You are root."
else
    echo -e "\n===[ERROR]===\n  Please run this script as root!!!\n"
    exit 0
fi

if command -v docker &> /dev/null; then
  echo "Docker is already installed."
else
  curl -fsSL https://get.docker.com -o ${src}/install-docker.sh
  sh ${src}/install-docker.sh
fi

if [[ $# -gt 0 ]]; then
  BRANCH=${1}
else
  echo -e "\n===[ERROR]===\n  Brunch not set !!!\n"
  exit 0
fi

echo "Init for branch: $BRANCH"

case "$BRANCH" in
    main)
        TARGET_DIR="/opt/wordpress-main"
        ;;
    *)
        TARGET_DIR="/opt/wordpress-dev"
        ;;
esac

if [ ! -d ${TARGET_DIR} ]; then
  mkdir -p ${TARGET_DIR}
fi

if [ ! -f ${TARGET_DIR}/acme.json ]; then
  touch ${TARGET_DIR}/acme.json
  chmod 600 ${TARGET_DIR}/acme.json
fi

echo "Init Done!"
