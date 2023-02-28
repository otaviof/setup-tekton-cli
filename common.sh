#
# Helper Functions
#

# print error message and exit on error.
function fail() {
    echo "ERROR: ${*}" >&2
    exit 1
}

# print out a strutured message.
function phase() {
    echo "---> Phase: ${*}..."
}

# inspect the path after the informed executable name.
function probe_bin_on_path() {
    local name="${1}"

    if ! type -a ${name} >/dev/null 2>&1; then
        fail "Can't find '${name}' on 'PATH=${PATH}'"
    fi
}

# print out the github release url for the informed organization/repository.
function github_releases_url() {
	local org_repo="${1}"
	echo "https://api.github.com/repos/${org_repo}/releases"
}

# get the latest release artifact url.
function get_latest_release_artifact_url() {
	local org_repo="${1}"

	local url="$(github_releases_url ${org_repo})"

	echo $(
		curl -s ${url}/latest |
			jq -r '.assets[].browser_download_url' |
			egrep -i 'linux_(x86_64|amd64)' |
			head -n 1
	)
}

# get the artifact url for the specific version (release).
function get_release_artifact_url() {
	local org_repo="${1}"
	local version="${2}"

	local url=$(github_releases_url ${org_repo})

	echo $(
		curl -s ${url} |
			jq -r ".[] | select(.tag_name == \"${version}\") | .assets[].browser_download_url" |
			egrep -i 'linux_(x86_64|amd64)' |
			head -n 1
	)
}

# given the download url and excutable name, download and extract the executable from the artifact
# tarball on the `/usr/local/bin` (prefix).
function download_and_install() {
    local url="${1}"
	local bin_name="${2}"

	local tarball="$(basename ${url})"
    local tmp_tarball="/tmp/${tarball}"
    local prefix="/usr/local/bin"

    [[ -f "${tmp_tarball}" ]] && rm -f "${tmp_tarball}"

    phase "Downloading '${url}' to '${tmp_tarball}'"
    curl -sL ${url} >${tmp_tarball}

    phase "Installing '${bin_name}' on prefix '${prefix}'"
    tar -C ${prefix} -zxvpf ${tmp_tarball} ${bin_name}
    rm -fv "${tmp_tarball}"
}