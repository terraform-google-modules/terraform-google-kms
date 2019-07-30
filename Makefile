# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Please note that this file was generated from [terraform-google-module-template](https://github.com/terraform-google-modules/terraform-google-module-template).
# Please make sure to contribute relevant changes upstream!

# Make will use bash instead of sh
SHELL := /usr/bin/env bash

# Docker build config variables
CREDENTIALS_PATH					?= /workspace/credentials.json
DOCKER_ORG							:= gcr.io/cloud-foundation-cicd
DOCKER_TAG_BASE_KITCHEN_TERRAFORM	?= 2.4.0
DOCKER_TAG_BASE_LINT				?= 2.5.0
DOCKER_REPO_BASE_KITCHEN_TERRAFORM	:= ${DOCKER_ORG}/cft/kitchen-terraform:${DOCKER_TAG_BASE_KITCHEN_TERRAFORM}
DOCKER_REPO_BASE_LINT				:= ${DOCKER_ORG}/cft/lint:${DOCKER_TAG_BASE_LINT}

# All is the first target in the file so it will get picked up when you just run 'make' on its own
.PHONY: all
all: check generate_docs

.PHONY: test_lint
test_lint: \
	check_whitespace \
	check_shell \
	check_headers \
	check_python \
	check_terraform

# Integration tests
.PHONY: test_lint
test_lint: \
	check_whitespace \
	check_shell \
	check_headers \
	check_python \
	check_terraform

.PHONY: check_headers
check_headers:
	@source /usr/local/bin/task_helper_functions.sh && check_headers

.PHONY: check_shell
check_shell:
	@source /usr/local/bin/task_helper_functions.sh && check_shell

.PHONY: check_python
check_python:
	@source /usr/local/bin/task_helper_functions.sh && check_python

.PHONY: check_whitespace
check_whitespace:
	@source /usr/local/bin/task_helper_functions.sh && check_whitespace

.PHONY: check_terraform
check_terraform:
	@source /usr/local/bin/task_helper_functions.sh && check_terraform

.PHONY: generate_docs
generate_docs:
	@source test/make.sh && generate_docs

# Versioning
.PHONY: version
version:
	@source helpers/version-repo.sh

# Run docker
# .PHONY: docker_run
# docker_run:
# 	docker run --rm -it \
# 		-e SERVICE_ACCOUNT_JSON \
# 		-v $(CURDIR):/workspace \
# 		${DOCKER_REPO_BASE_KITCHEN_TERRAFORM} \
# 		/bin/bash -c "source test/ci_integration.sh && setup_auth && exec /bin/bash"

.PHONY: docker_run
docker_run: ## Launch a shell within the Docker test environment
	docker run --rm -it \
		-e SERVICE_ACCOUNT_JSON \
		-v $(CURDIR):/workspace \
		cft/developer-tools:0.0.1 \
		/bin/bash

# Execute lint tests within the docker container
.PHONY: docker_test_lint
docker_test_lint:
	docker run --rm -it \
		-v $(CURDIR):/workspace \
		cft/developer-tools:0.0.1 \
		/usr/local/bin/test_lint.sh

.PHONY: docker_prepare
docker_prepare:
	docker run --rm \
		-e SERVICE_ACCOUNT_JSON \
		-v $(CURDIR):/workspace \
		${DOCKER_REPO_BASE_KITCHEN_TERRAFORM} \
		/bin/bash -c "source test/ci_integration.sh && prepare_environment"

.PHONY: docker_create
docker_create:
	docker run --rm \
		-e SERVICE_ACCOUNT_JSON \
		-v $(CURDIR):/workspace \
		${DOCKER_REPO_BASE_KITCHEN_TERRAFORM} \
		/bin/bash -c "source test/ci_integration.sh && kitchen_do create"

.PHONY: docker_converge
docker_converge:
	docker run --rm \
		-e SERVICE_ACCOUNT_JSON \
		-v $(CURDIR):/workspace \
		${DOCKER_REPO_BASE_KITCHEN_TERRAFORM} \
		/bin/bash -c "source test/ci_integration.sh && kitchen_do converge"

.PHONY: docker_verify
docker_verify:
	docker run --rm \
		-e SERVICE_ACCOUNT_JSON \
		-v $(CURDIR):/workspace \
		${DOCKER_REPO_BASE_KITCHEN_TERRAFORM} \
		/bin/bash -c "source test/ci_integration.sh && kitchen_do verify"

.PHONY: docker_destroy
docker_destroy:
	docker run --rm \
		-e SERVICE_ACCOUNT_JSON \
		-v $(CURDIR):/workspace \
		${DOCKER_REPO_BASE_KITCHEN_TERRAFORM} \
		/bin/bash -c "source test/ci_integration.sh && kitchen_do destroy"

.PHONY: test_integration_docker
test_integration_docker:
	docker run --rm -it \
		-e PROJECT_ID \
		-e SERVICE_ACCOUNT_JSON \
		-e GOOGLE_APPLICATION_CREDENTIALS=${CREDENTIALS_PATH} \
		-v $(CURDIR):/cft/workdir \
		${DOCKER_REPO_BASE_KITCHEN_TERRAFORM} \
		make test_integration
