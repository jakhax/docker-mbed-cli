FROM python:3.7.11-buster

# Set up a tools dev directory
WORKDIR /home/dev

#update
RUN apt-get update 

#requirements
RUN apt-get install -y build-essential\
                    python3-dev\
                    git\
                    mercurial



#download GCC_ARM 9-2020-q2-update x86_64 linux
RUN wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2020q2/gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2\
    && tar xvf gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2 \
    && rm gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2

# Set up the compiler path
ENV PATH $PATH:/home/dev/gcc-arm-none-eabi-9-2020-q2-update/bin

#install mbed cli
RUN python3 -m pip install mbed-cli

# set GCC_ARM  as global toolchain
RUN mbed-cli config --global toolchain gcc_arm

# install mbed os requirements
RUN wget https://raw.githubusercontent.com/ARMmbed/mbed-os/master/requirements.txt
RUN python3 -m pip install -r ./requirements.txt

RUN python3 -m pip install icetea

#workdir
WORKDIR /home/projects

#shared user remove if not needed
ARG USER_ID
ARG GROUP_ID
RUN addgroup --gid $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user
USER user

