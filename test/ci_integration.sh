#!/usr/bin/env bash

# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Always clean up.
DELETE_AT_EXIT="$(mktemp -d)"
finish() {
  echo 'BEGIN: finish() trap handler' >&2
  kitchen destroy "$SUITE"
  [[ -d "${DELETE_AT_EXIT}" ]] && rm -rf "${DELETE_AT_EXIT}"
  echo 'END: finish() trap handler' >&2
}

# Map the input parameters provided by Concourse CI, or whatever mechanism is
# running the tests to Terraform input variables.  Also setup credentials for
# use with kitchen-terraform, inspec, and gcloud.
setup_auth() {
  if [[ -z "${SERVICE_ACCOUNT_JSON}" ]]; then
    echo "No \$SERVICE_ACCOUNT_JSON found"
  else
    echo "Populating auth from \$SERVICE_ACCOUNT_JSON"

    # local tmpfile
    tmpfile="$(mktemp)"
    echo "${SERVICE_ACCOUNT_JSON}" > "${tmpfile}"

    # gcloud variables
    export CLOUDSDK_AUTH_CREDENTIAL_FILE_OVERRIDE="${tmpfile}"
    # Application default credentials (Terraform google provider and inspec-gcp)
    export GOOGLE_APPLICATION_CREDENTIALS="${tmpfile}"
  fi
}

# Prepare the setup environment
prepare_environment() {
  setup_auth
  cd test/setup/
  terraform init
  terraform apply -auto-approve
  ./make_source.sh
  source ../source.sh
  cd -
}

# Run kitchen_create
kitchen_do() {
  source test/source.sh
  setup_auth
  export CMD="$@"
  kitchen $CMD
}

main() {
  export SUITE="${SUITE:-}"

  set -eu
  # Setup trap handler to auto-cleanup
  export TMPDIR="${DELETE_AT_EXIT}"
  trap finish EXIT

  # Setup environment variables
  setup_auth
  set -x

  # Execute the test lifecycle
  kitchen create "$SUITE"
  kitchen converge "$SUITE"
  kitchen verify "$SUITE"
}

# if script is being executed and not sourced.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi
