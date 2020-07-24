# Copyright 2017 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
"""Rules to load all dependencies of rules_release_file."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

def repositories():
    """Download dependencies of container rules."""
    excludes = native.existing_rules().keys()

    if "bazel_skylib" not in excludes:
        http_archive(
            name = "bazel_skylib",
            sha256 = "e5d90f0ec952883d56747b7604e2a15ee36e288bb556c3d0ed33e818a4d971f2",
            strip_prefix = "bazel-skylib-1.0.2",
            urls = [
                "https://github.com/bazelbuild/bazel-skylib/archive/1.0.2.tar.gz",
            ],
        )

    if "rules_python" not in excludes:
        git_repository(
            name = "rules_python",
            remote = "https://github.com/bazelbuild/rules_python/",
            commit = "708ed8679d7510a331ce9a7b910a2a056d24f7b1",
            shallow_since = "1590213058 +1000",
        )

    io_bazel_rules_go_version = "0.23.5"
    io_bazel_rules_go_sha = "2d536797707dd1697441876b2e862c58839f975c8fc2f0f96636cbd428f45866"
    http_archive(
        name = "io_bazel_rules_go",
        sha256 = io_bazel_rules_go_sha,
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v{0}/rules_go-v{0}.tar.gz".format(io_bazel_rules_go_version),
            "https://github.com/bazelbuild/rules_go/releases/download/v{0}/rules_go-v{0}.tar.gz".format(io_bazel_rules_go_version),
        ],
    )

    bazel_gazelle_version = "0.21.1"
    bazel_gazelle_sha = "cdb02a887a7187ea4d5a27452311a75ed8637379a1287d8eeb952138ea485f7d"
    http_archive(
        name = "bazel_gazelle",
        sha256 = bazel_gazelle_sha,
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v{0}/bazel-gazelle-v{0}.tar.gz".format(bazel_gazelle_version),
            "https://github.com/bazelbuild/bazel-gazelle/releases/download/v{0}/bazel-gazelle-v{0}.tar.gz".format(bazel_gazelle_version),
        ],
    )
