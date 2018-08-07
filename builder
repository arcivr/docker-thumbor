#!/bin/bash
if [ -z "$THUMBOR_VERSION" ]
then
  THUMBOR_VERSION="6.3.0"
fi

echo "THUMBOR VERSION: $THUMBOR_VERSION"

echo "--> Wheelhousing requirements in /wheelhouse"
docker build -t test/builder -f Dockerfile.build .
mkdir -p wheelhouse
docker run --rm -v "$(pwd)"/wheelhouse:/wheelhouse test/builder

echo "Launch Pypiserver"
docker-compose -f docker-compose-travis.yml up -d pypiserver
docker ps -a

export DOCKERHOST=$(ip route | awk '/docker/ { print $NF }')

echo "--> BUILDING arcivr/thumbor"
docker build --build-arg DOCKERHOST=$DOCKERHOST -f thumbor/Dockerfile -t arcivr/thumbor thumbor/
echo "--> TAGGING arcivr/thumbor:$THUMBOR_VERSION"
docker tag arcivr/thumbor arcivr/thumbor:$THUMBOR_VERSION
echo "--> TAGGING arcivr/thumbor:latest"
docker tag arcivr/thumbor arcivr/thumbor:latest

# echo "--> BUILDING arcivr/thumbor:simd-sse4"
# docker build --build-arg SIMD_LEVEL=sse4  -f thumbor-simd/Dockerfile -t arcivr/thumbor-simd-sse4 thumbor-simd/
# echo "--> TAGGING arcivr/thumbor:$THUMBOR_VERSION-simd-sse4"
# docker tag arcivr/thumbor-simd-sse4 arcivr/thumbor:$THUMBOR_VERSION-simd-sse4
# echo "--> TAGGING arcivr/thumbor:latest-simd-sse4"
# docker tag arcivr/thumbor-simd-sse4 arcivr/thumbor:latest-simd-sse4
#
# echo "--> BUILDING arcivr/thumbor:simd-avx2"
# docker build --build-arg SIMD_LEVEL=avx2  -f thumbor-simd/Dockerfile -t arcivr/thumbor-simd-avx2 thumbor-simd/
# echo "--> TAGGING arcivr/thumbor:$THUMBOR_VERSION-simd-avx2"
# docker tag arcivr/thumbor-simd-avx2 arcivr/thumbor:$THUMBOR_VERSION-simd-avx2
# echo "--> TAGGING arcivr/thumbor:latest-simd-avx2"
# docker tag arcivr/thumbor-simd-avx2 arcivr/thumbor:latest-simd-avx2
#
# echo "--> BUILDING arcivr/thumbor-multiprocess"
# docker build --build-arg DOCKERHOST=$DOCKERHOST -f thumbor-multiprocess/Dockerfile -t arcivr/thumbor-multiprocess thumbor-multiprocess/
# echo "--> TAGGING arcivr/thumbor-multiprocess:$THUMBOR_VERSION"
# docker tag arcivr/thumbor-multiprocess arcivr/thumbor-multiprocess:$THUMBOR_VERSION
# echo "--> TAGGING arcivr/thumbor-multiprocess:latest"
# docker tag arcivr/thumbor-multiprocess arcivr/thumbor-multiprocess:latest
#
# echo "--> BUILDING arcivr/thumbor-multiprocess:simd-sse4"
# docker build --build-arg SIMD_LEVEL=sse4 -f thumbor-multiprocess-simd/Dockerfile -t arcivr/thumbor-multiprocess-simd-sse4 thumbor-multiprocess-simd/
# echo "--> TAGGING arcivr/thumbor-multiprocess:$THUMBOR_VERSION-simd-sse4"
# docker tag arcivr/thumbor-multiprocess-simd-sse4 arcivr/thumbor-multiprocess:$THUMBOR_VERSION-simd-sse4
# echo "--> TAGGING arcivr/thumbor-multiprocess:latest-simd-sse4"
# docker tag arcivr/thumbor-multiprocess-simd-sse4 arcivr/thumbor-multiprocess:latest-simd-sse4
#
# echo "--> BUILDING arcivr/thumbor-multiprocess:simd-avx2"
# docker build --build-arg SIMD_LEVEL=avx2 -f thumbor-multiprocess-simd/Dockerfile -t arcivr/thumbor-multiprocess-simd-avx2 thumbor-multiprocess-simd/
# echo "--> TAGGING arcivr/thumbor-multiprocess:$THUMBOR_VERSION-simd-avx2"
# docker tag arcivr/thumbor-multiprocess-simd-avx2 arcivr/thumbor-multiprocess:$THUMBOR_VERSION-simd-avx2
# echo "--> TAGGING arcivr/thumbor-multiprocess:latest-simd-avx2"
# docker tag arcivr/thumbor-multiprocess-simd-avx2 arcivr/thumbor-multiprocess:latest-simd-avx2

echo "--> BUILDING arcivr/thumbor-nginx"
docker build -f nginx/Dockerfile -t arcivr/thumbor-nginx nginx/
echo "--> TAGGING arcivr/thumbor-nginx:$THUMBOR_VERSION"
docker tag arcivr/thumbor-nginx arcivr/thumbor-nginx:$THUMBOR_VERSION
echo "--> TAGGING arcivr/thumbor-nginx:latest"
docker tag arcivr/thumbor-nginx arcivr/thumbor-nginx:latest

# echo "--> BUILDING arcivr/remotecv"
# docker build --build-arg DOCKERHOST=$DOCKERHOST -f remotecv/Dockerfile -t arcivr/remotecv remotecv/
# echo "--> TAGGING arcivr/remotecv:$THUMBOR_VERSION"
# docker tag arcivr/remotecv arcivr/remotecv:$THUMBOR_VERSION
# echo "--> TAGGING arcivr/remotecv:latest"
# docker tag arcivr/remotecv arcivr/remotecv:latest
