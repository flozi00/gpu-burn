ARG CUDA_VERSION=12.4.1
ARG IMAGE_DISTRO=ubi8

FROM nvidia/cuda:${CUDA_VERSION}-devel-${IMAGE_DISTRO} AS builder

WORKDIR /build

COPY . /build/

RUN make COMPUTE="5.0 6.0 6.1 7.0 7.5 8.0 8.6 8.9 9.0"

FROM nvidia/cuda:${CUDA_VERSION}-runtime-${IMAGE_DISTRO}

COPY --from=builder /build/gpu_burn /app/
COPY --from=builder /build/compare.ptx /app/

WORKDIR /app

CMD ["./gpu_burn", "120", "-m", "90%"]
