# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.0.2] - 2024-08-01
### Changed

- Further improvement of vault-agent-integration's README
- Removed auto update of helm repo after addition in helm.mk and in manifests directories, because of too many refreshes

## [2.0.1] - 2024-08-01

### Changed
- Updated main README
- Updated vault-agent-integration scenario README

## [2.0.0] - 2024-08-01

### Changed
- Contour installation moved from k8s to manifests
- Scenarios moved from manifests. To allow reuse the very same charts but different values for different scenarios 

### Added
- Vault-agent-integration scenario
- WebApp helm chart
