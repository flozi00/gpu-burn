ARG CUDA_VERSION=12.4.1
ARG IMAGE_DISTRO=ubi8

FROM nvidia/cuda:${CUDA_VERSION}-devel-${IMAGE_DISTRO} AS builder

WORKDIR /build

COPY . /build/

RUN make COMPUTE="8.9"

WORKDIR /app

CMD ["./gpu_burn", "120", "-m", "90%"]
