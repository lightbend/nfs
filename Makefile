#!/usr/bin/env bash

# Copyright (C) 2016-2019 Lightbend Inc. <https://www.lightbend.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##
# Chart Makefiles must implement lint, package, and test targets.  They are free to implement
# those however they want.  If desired, the Makefile can include this file that provides
# default recipes for those targets.
##

# Package up the chart files and move the tarball to the helm-charts repository.
# Include a .helmignore file in your directory to specify files to omit from the package.
package: init
	helm package .

lint: init
	helm lint .

# This satisfies the need for a test target but does nothing.
test:
	@echo NO tests are implemented!!

init:
	@helm init -c > /dev/null

.PHONY: lint package test init
