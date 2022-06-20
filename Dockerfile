FROM nvidia/cuda:11.4.0-cudnn8-devel-ubuntu18.04
ENV DEBIAN_FRONTEND=noninteractive
RUN sed -i -- 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list 
RUN apt-get update
#RUN pip config set global.index-url https://pypi.mirrors.ustc.edu.cn/simple/
#RUN pip install pip -U
#get deps
RUN apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
python3-dev python3-pip python3-setuptools git g++ wget make libprotobuf-dev protobuf-compiler libopencv-dev \
libgoogle-glog-dev libboost-all-dev libcaffe-cuda-dev libhdf5-dev libatlas-base-dev

#for python api
RUN pip3 install --upgrade pip
RUN pip3 install numpy opencv-python jupyter vedo  -i https://pypi.mirrors.ustc.edu.cn/simple/

#replace cmake as old version has CUDA variable bugs
RUN wget https://github.com/Kitware/CMake/releases/download/v3.16.0/cmake-3.16.0-Linux-x86_64.tar.gz && \
tar xzf cmake-3.16.0-Linux-x86_64.tar.gz -C /opt && \
rm cmake-3.16.0-Linux-x86_64.tar.gz
ENV PATH="/opt/cmake-3.16.0-Linux-x86_64/bin:${PATH}"

WORKDIR /workspace

