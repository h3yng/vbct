# vestibulect

npm wrapper for **vbct** from [https://github.com/h3yng/tabby](https://github.com/h3yng/tabby).

## Install

    npm install -g vestibulect

## Usage

    vbct 

## How it works

- During postinstall, the package downloads the matching release asset for your platform.
- The binary is stored in ./bin and exposed through npm bin.
- No Go toolchain is required on end-user machines.

## Included platform mappings
- darwin-arm64 -> vbct_v0.0.1_macos_arm64.tar.gz
- linux-x64 -> vbct_v0.0.1_linux_amd64.tar.gz

## Release source

- Version: v0.0.1
- Repository: https://github.com/h3yng/tabby
