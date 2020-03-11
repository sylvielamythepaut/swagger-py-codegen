# syntax=docker/dockerfile:experimental

ARG base_tag



FROM eccr-dev.ecmwf.int/servicelib/servicelib:${base_tag}

# Copy the Python services code.
COPY *.py /code/services/{{ module }}/

# Copy the default configuration file
COPY servicelib.ini /etc/servicelib.ini


