# ---- Build stage ----
FROM ubuntu:22.04 AS build

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    ninja-build \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /src

# Copy source (includes submodules in repo checkout)
COPY . .

# Build (Release)
RUN cmake -S . -B /build -G Ninja -DCMAKE_BUILD_TYPE=Release \
 && cmake --build /build --parallel

# ---- Runtime stage ----
FROM ubuntu:22.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    gettext-base \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/falcata

# Copy runtime binaries (note: your top-level CMake sets runtime output to the build dir)
COPY --from=build /build/ ./bin/

# Config template + entrypoint
COPY config.template.json ./config.release.json
COPY docker/entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh

ENV FALCATA_CONFIG=/opt/falcata/config.release.json

EXPOSE 8080

ENTRYPOINT ["./entrypoint.sh"]
