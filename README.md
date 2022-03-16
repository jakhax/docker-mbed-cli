# Docker Mbed Cli

>> Mbed Os now has an official docker image, see [https://github.com/ARMmbed/mbed-os/pkgs/container/mbed-os-env](https://github.com/ARMmbed/mbed-os/pkgs/container/mbed-os-env)

This is an un-official  [mbed-cli](https://os.mbed.com/docs/mbed-os/v5.12/tools/developing-mbed-cli.html) docker image. Currently it only supports `GCC Arm` as its default compiler.

## Building
```bash
docker build -t "mbed_cli" --build-arg USER_ID=$(id -u)  --build-arg GROUP_ID=$(id -g) .
```

if you dont plan on using it with your default user(shared user permissions) you can edit this part out in the Dockerfile
```dockerfile
#shared user permissions
ARG USER_ID
ARG GROUP_ID
RUN addgroup --gid $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user
USER user
```
then build using
```bash
docker build -t "mbed_cli" .
```

You can  add an alias like `mbed_docker` to use it like `mbed-cli`
```bash
alias mbed_docker='docker run -it -v $(pwd):/home/projects:cached mbed_cli mbed-cli'
```

## Usage

**Using above alias**
```bash
╰─$ mbed_docker
usage: mbed [-h] [--version]             ...

Command-line code management tool for ARM mbed OS - http://www.mbed.com
version 1.10.4

Use "mbed <command> -h|--help" for detailed help.
Online manual and guide available at https://github.com/ARMmbed/mbed-cli
...
```

**Without alias**
```bash
╰─$ docker run -it -v $(pwd):/home/projects:cached mbed_cli mbed-cli
usage: mbed [-h] [--version]             ...

Command-line code management tool for ARM mbed OS - http://www.mbed.com
version 1.10.4
...
```

For more usage see [https://os.mbed.com/docs/mbed-os/v6.2/build-tools/mbed-cli.html](https://os.mbed.com/docs/mbed-os/v6.2/build-tools/mbed-cli.html)


## Resources

- https://os.mbed.com/docs/mbed-os/v6.2/build-tools/install-and-set-up.html
- https://vsupalov.com/docker-shared-permissions/
- https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads
