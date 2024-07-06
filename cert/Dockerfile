ARG BUILD_FROM
FROM $BUILD_FROM

# Install requirements for add-on
RUN \
  apk add --no-cache \
    python3 \
    openssl 

# Python 3 HTTP Server serves the current working dir
# So let's set it to our add-on persistent data directory.
RUN mkdir /data
WORKDIR /data

# Copy data for add-on
COPY run.sh /data/
COPY run-cert.sh /data/
RUN chmod a+x /data/run.sh /data/run-cert.sh

CMD [ "run.sh" ]