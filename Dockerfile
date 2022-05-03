FROM ubuntu:20.04

# Prepare Timezone setting
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY sources.list /etc/apt/sources.list

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y --no-install-recommends cmake bc ninja-build virtualenv python python3 git openssh-client llvm clang curl wget unzip software-properties-common diffutils patch make file elfutils zip vim less python3-dev python3-numpy libopengl-dev mesa-common-dev libglew-dev pkg-config libwayland-client0 libssl-dev cppcheck

WORKDIR /root
RUN git clone https://gitlab.com/libeigen/eigen.git -b 3.3
WORKDIR /root/eigen
RUN cmake -B build -DCMAKE_INSTALL_PREFIX=/usr -DINCLUDE_INSTALL_DIR=include
RUN make -C build -j 5
RUN make -C build install

WORKDIR /root
RUN git clone --recursive https://github.com/stevenlovegrove/Pangolin
WORKDIR /root/Pangolin
RUN echo -ne "#!/bin/bash\necho \"SUDO: $@\"\n" > /usr/local/bin/sudo
RUN chmod 755 /usr/local/bin/sudo
RUN ./scripts/install_prerequisites.sh recommended
RUN cmake -B build -DCMAKE_INSTALL_PREFIX=/usr
RUN make -C build -j 5
RUN make -C build install

WORKDIR /root
RUN git clone https://github.com/opencv/opencv.git
WORKDIR /root/opencv
RUN cmake -B build -DCMAKE_INSTALL_PREFIX=/usr
RUN make -C build -j 5
RUN make -C build install

WORKDIR /root
RUN git clone https://github.com/UZ-SLAMLab/ORB_SLAM3.git
RUN apt-get install -y --no-install-recommends libboost-dev libclang-dev libstdc++-10-dev libboost-serialization-dev #build-essential
RUN ln -s /usr/include/stdint.h /usr/include/stdint-gcc.h

WORKDIR /root/ORB_SLAM3/Thirdparty/DBoW2
RUN cmake . -B build -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_STANDARD=14
RUN make -C build -j4

WORKDIR /root/ORB_SLAM3/Thirdparty/g2o
RUN cmake . -B build -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_STANDARD=14
RUN make -C build -j4

WORKDIR /root/ORB_SLAM3/Thirdparty/Sophus
RUN cmake . -B build -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_STANDARD=14
RUN make -C build -j4

WORKDIR /root/ORB_SLAM3/Vocabulary
RUN tar -xf ORBvoc.txt.tar.gz

WORKDIR /root/ORB_SLAM3
RUN cmake . -B build -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_STANDARD=14
RUN make -C build -j4

WORKDIR /root
ENV HOME=/root
ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib
ENV PATH=${PATH}:/usr/local/bin
COPY vimrc /root/.vimrc

CMD ["/bin/bash"]
