#!/usr/bin/env bash

shopt -s inherit_errexit
set -eu -o pipefail

source "$(dirname ${BASH_SOURCE[0]})/common.sh"

phase "Inspecting enviroment variables"

readonly INPUT_CLI_VERSION="${INPUT_CLI_VERSION:-}"

[[ -z "${INPUT_CLI_VERSION}" ]] &&
	fail "INPUT_CLI_VERSION environment variable is not set!"

phase "Searching for '${INPUT_CLI_VERSION}' release artifact"

org_repo="tektoncd/cli"
url=""

if [ "${INPUT_CLI_VERSION}" == "latest" ]; then
	url=$(get_latest_release_artifact_url ${org_repo})
else
	url=$(get_release_artifact_url ${org_repo} ${INPUT_CLI_VERSION})
fi

phase "Download URL '${url}'"
download_and_install ${url} "tkn"
