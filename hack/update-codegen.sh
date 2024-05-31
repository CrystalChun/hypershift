#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

SCRIPT_ROOT=$(dirname "${BASH_SOURCE[0]}")
CODEGEN_PKG=${CODEGEN_PKG:-$(cd "${SCRIPT_ROOT}"; ls -d -1 ./tools/vendor/k8s.io/code-generator 2>/dev/null)}

source "${SCRIPT_ROOT}/${CODEGEN_PKG}/kube_codegen.sh"

# Deep-copies and what-not are generated by controller-gen, so we don't need to use kube::codegen::gen_helpers

kube::codegen::gen_client \
    --with-watch \
    --with-applyconfig \
    --output-dir ./client \
    --output-pkg github.com/openshift/hypershift/client \
    --versioned-name clientset \
    --boilerplate "${SCRIPT_ROOT}/boilerplate.go.txt" \
    ./api