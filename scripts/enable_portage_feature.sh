#!/usr/bin/env bash

set -Eeuo pipefail

MAKE_CONF=/etc/portage/make.conf

case $(grep --line-regexp --quiet "FEATURES=.*" ${MAKE_CONF} ; echo $?) in
  0)
    echo "Extending FEATURES with '${1}'"
    sed --in-place --regexp-extended --expression="s#FEATURES=\"(.*)\"#FEATURES=\"\1 ${1}\"#g" "${MAKE_CONF}"
    ;;
  1)
    echo "Currently no FEATURES are explicitly set in make.conf adding FEATURES=\"${1}\""
    echo FEATURES=\""${1}"\" >> "${MAKE_CONF}"
    ;;
  *)
    echo "Error occurred during parsing ${MAKE_CONF}"
    ;;
esac
