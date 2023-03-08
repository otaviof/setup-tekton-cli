#!/usr/bin/env bash

shopt -s inherit_errexit
set -eu -o pipefail

source "$(dirname ${BASH_SOURCE[0]})/common.sh"

phase "Inspecting enviroment variables"

readonly INPUT_VERSION="${INPUT_VERSION:-}"

[[ -z "${INPUT_VERSION}" ]] &&
	fail "INPUT_VERSION environment variable is not set!"

phase "Searching for '${INPUT_VERSION}' release artifact"

org_repo="tektoncd/cli"
url=""

if [ "${INPUT_VERSION}" == "latest" ]; then
	url=$(get_latest_release_artifact_url ${org_repo})
else
	url=$(get_release_artifact_url ${org_repo} ${INPUT_VERSION})
fi

[[ -z "${url}" ]] &&
	fail "Unable to acrquire the release artifact download URL"

phase "Download URL '${url}'"
download_and_install ${url} "tkn"
