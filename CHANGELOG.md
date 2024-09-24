# Changelog

All notable changes to this project will be documented in this file.

The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.1.0](https://github.com/terraform-google-modules/terraform-google-kms/compare/v3.0.0...v3.1.0) (2024-09-17)


### Features

* Introduce autokey feature ([#151](https://github.com/terraform-google-modules/terraform-google-kms/issues/151)) ([f4471fd](https://github.com/terraform-google-modules/terraform-google-kms/commit/f4471fd65b36775f10f50f3624f573beadc77b81))

## [3.0.0](https://github.com/terraform-google-modules/terraform-google-kms/compare/v2.3.0...v3.0.0) (2024-08-29)


### ⚠ BREAKING CHANGES

* **TPG>=5.23:** bump TPG for crypto_key_backend ([#139](https://github.com/terraform-google-modules/terraform-google-kms/issues/139))
* Add import flags ([#133](https://github.com/terraform-google-modules/terraform-google-kms/issues/133))

### Features

* Add import flags ([#133](https://github.com/terraform-google-modules/terraform-google-kms/issues/133)) ([70d2718](https://github.com/terraform-google-modules/terraform-google-kms/commit/70d27186756a8fd2860f8107eba511dca5771f8f))
* Add support for EXTERNAL_VPC ([#137](https://github.com/terraform-google-modules/terraform-google-kms/issues/137)) ([f553b67](https://github.com/terraform-google-modules/terraform-google-kms/commit/f553b67d5e8143200a9368e2dd7cbd7e9f455094))
* **deps:** Update Terraform google to v6 ([#150](https://github.com/terraform-google-modules/terraform-google-kms/issues/150)) ([b7d99e3](https://github.com/terraform-google-modules/terraform-google-kms/commit/b7d99e382972642cd5dc33ebc6d4fac7e7e6a36c))


### Bug Fixes

* **TPG>=5.23:** bump TPG for crypto_key_backend ([#139](https://github.com/terraform-google-modules/terraform-google-kms/issues/139)) ([36d0319](https://github.com/terraform-google-modules/terraform-google-kms/commit/36d0319740c7fd751e879df01180e32dcb1cc924))

## [2.3.0](https://github.com/terraform-google-modules/terraform-google-kms/compare/v2.2.3...v2.3.0) (2024-01-30)


### Features

* add support for destroy_scheduled_duration ([#109](https://github.com/terraform-google-modules/terraform-google-kms/issues/109)) ([c26f3fb](https://github.com/terraform-google-modules/terraform-google-kms/commit/c26f3fb91186d809bbc4c7856fe6a73c9b193344))


### Bug Fixes

* Change default rotation period from 28 hours to 90 days  ([#111](https://github.com/terraform-google-modules/terraform-google-kms/issues/111)) ([44d01da](https://github.com/terraform-google-modules/terraform-google-kms/commit/44d01da9fc471b03b48bbf67bc977b7d98a19d79))

## [2.2.3](https://github.com/terraform-google-modules/terraform-google-kms/compare/v2.2.2...v2.2.3) (2023-10-16)


### Bug Fixes

* upgraded versions.tf to include minor bumps from tpg v5 ([#102](https://github.com/terraform-google-modules/terraform-google-kms/issues/102)) ([f35c882](https://github.com/terraform-google-modules/terraform-google-kms/commit/f35c8822ba48b1deff1c996a2cffe83bc9ba59c9))

## [2.2.2](https://github.com/terraform-google-modules/terraform-google-kms/compare/v2.2.1...v2.2.2) (2023-04-13)


### Bug Fixes

* updates for tflint and dev-tools 1.11 ([#86](https://github.com/terraform-google-modules/terraform-google-kms/issues/86)) ([ba59dab](https://github.com/terraform-google-modules/terraform-google-kms/commit/ba59dabda03d1375f63ed2b0c224d99c3bd5702b))

## [2.2.1](https://github.com/terraform-google-modules/terraform-google-kms/compare/v2.2.0...v2.2.1) (2022-07-20)


### Bug Fixes

* adding missing purpose field for ephemeral keys ([#61](https://github.com/terraform-google-modules/terraform-google-kms/issues/61)) ([1d6b259](https://github.com/terraform-google-modules/terraform-google-kms/commit/1d6b259d9796ac1cc76ee424966e2771ee93ee4b))

## [2.2.0](https://github.com/terraform-google-modules/terraform-google-kms/compare/v2.1.0...v2.2.0) (2022-06-10)


### Features

* expose purpose field ([#59](https://github.com/terraform-google-modules/terraform-google-kms/issues/59)) ([ec9dd06](https://github.com/terraform-google-modules/terraform-google-kms/commit/ec9dd06b654b482dd9896adc7ae27f39cf483cf7))

## [2.1.0](https://www.github.com/terraform-google-modules/terraform-google-kms/compare/v2.0.1...v2.1.0) (2021-12-13)


### Features

* update TPG version constraints to allow 4.0 ([#50](https://www.github.com/terraform-google-modules/terraform-google-kms/issues/50)) ([14d80d7](https://www.github.com/terraform-google-modules/terraform-google-kms/commit/14d80d70966ff2ea64481cca83e8acbfff3fa65b))

### [2.0.1](https://www.github.com/terraform-google-modules/terraform-google-kms/compare/v2.0.0...v2.0.1) (2021-08-11)


### Bug Fixes

* Create dependency with grant ([#46](https://www.github.com/terraform-google-modules/terraform-google-kms/issues/46)) ([9f4129d](https://www.github.com/terraform-google-modules/terraform-google-kms/commit/9f4129d87799c1c22c388e1a3808717b09a58ab3))

## [2.0.0](https://www.github.com/terraform-google-modules/terraform-google-kms/compare/v1.2.0...v2.0.0) (2021-03-15)


### ⚠ BREAKING CHANGES

* add Terraform 0.13 constraint and module attribution (#40)

### Features

* add Terraform 0.13 constraint and module attribution ([#40](https://www.github.com/terraform-google-modules/terraform-google-kms/issues/40)) ([e46c56c](https://www.github.com/terraform-google-modules/terraform-google-kms/commit/e46c56c683961ceb750684409cbdfdff4492031d))

## [1.2.0](https://www.github.com/terraform-google-modules/terraform-google-kms/compare/v1.1.1...v1.2.0) (2020-06-01)


### Features

* Add support for var.labels ([#29](https://www.github.com/terraform-google-modules/terraform-google-kms/issues/29)) ([ca19209](https://www.github.com/terraform-google-modules/terraform-google-kms/commit/ca19209f19c4679d9f5d663b05a8c7b9b7edc702))
* Add variables to configure key_algorithm and key_protection_level  ([#27](https://www.github.com/terraform-google-modules/terraform-google-kms/issues/27)) ([3f01a09](https://www.github.com/terraform-google-modules/terraform-google-kms/commit/3f01a09f816da0b39f1ab35bed8f6cea694bed57))

### [1.1.1](https://www.github.com/terraform-google-modules/terraform-google-kms/compare/v1.1.0...v1.1.1) (2020-05-20)


### Bug Fixes

* Map outputs by slicing the outputs to the length of inputs ([#20](https://www.github.com/terraform-google-modules/terraform-google-kms/issues/20)) ([338fff6](https://www.github.com/terraform-google-modules/terraform-google-kms/commit/338fff65ea1ae1cefcb40ed8166268d4400b7038))

## [Unreleased]

## [1.1.0]

### Added

- Allow setting prevent_destroy lifecycle value on keys, add keyring resource output [#14]
- Added continuous integration using Cloud Build. [#11]

## [1.0.0] - 2019-07-19

### Changed

- Supported version of Terraform is 0.12. [#3]

## [0.1.0] - 2019-05-16

### Added

- Initial release

[Unreleased]: https://github.com/terraform-google-modules/terraform-google-kms/compare/v1.0.0...HEAD
[1.1.0]: https://github.com/terraform-google-modules/terraform-google-kms/releases/tag/v1.1.0
[1.0.0]: https://github.com/terraform-google-modules/terraform-google-kms/releases/tag/v1.0.0
[0.1.0]: https://github.com/terraform-google-modules/terraform-google-kms/releases/tag/v0.1.0

[#14]: https://github.com/terraform-google-modules/terraform-google-kms/pull/11
[#11]: https://github.com/terraform-google-modules/terraform-google-kms/pull/11
[#3]: https://github.com/terraform-google-modules/terraform-google-kms/pull/3
