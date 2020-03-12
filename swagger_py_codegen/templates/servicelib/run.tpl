#!/usr/bin/env bash

set -e

me="$(basename $0)"

worker_dir=.
if [ -z "$worker_dir" ] ; then
  echo "Usage: $me <worker-dir>"
  exit 1
fi

if [ ! -d "$worker_dir" ] ; then
  echo "${me}: Not a directory"
  exit 1
fi
worker_dir="$(cd $worker_dir && pwd)"

worker_name="$(echo $(basename $worker_dir) | tr _ -)"
image_tag="${base_tag:-latest}"

swagger_yaml="${worker_dir}/swagger.yaml"
if [ -r $swagger_yaml ] ; then
  swagger_vol="--volume $swagger_yaml:/code/services/swagger.yaml:ro"
else
  swagger_vol=""
fi

scratch_dir=/tmp/servicelib-worker-${worker_name}

set -x
mkdir -p $scratch_dir
chmod 01777 $scratch_dir

port="$1"
if [ -z "$port" ] ; then
  port=8000
fi
echo "Starting on port $port"


hostname="${SERVICELIB_RESULTS_HTTP_HOSTNAME:-127.0.0.1}"
docker run \
  --rm \
  --name worker-${worker_name} \
  --env SERVICELIB_WORKER_PORT=${port} \
  --env SERVICELIB_RESULTS_HTTP_PORT=${port} \
  --env SERVICELIB_RESULTS_HTTP_HOSTNAME=$hostname \
  --volume ${worker_dir}:/code/services/$(basename $worker_dir):ro \
  --volume ${worker_dir}/servicelib.ini:/etc/servicelib.ini:ro \
  --volume ${scratch_dir}:/var/cache/servicelib \
  $swagger_vol \
  --publish ${port}:${port} \
  --read-only \
  eccr-dev.ecmwf.int/servicelib/worker-${worker_name}:${image_tag}

