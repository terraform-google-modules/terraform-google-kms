#!/usr/bin/env bash

# Copyright 2019 Google LLC
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

# Prepare the setup environment
prepare_environment() {
  cd test/setup/
  terraform init
  terraform apply -auto-approve
  ./make_source.sh
  # shellcheck disable=SC1091
  source ../source.sh
  cd -
}

# Run kitchen_create
kitchen_do() {
  # shellcheck disable=SC1091
  source test/source.sh
  init_credentials
  export CMD="$*"
  kitchen "$CMD"
}
