# Use Alpine Linux as the base image
FROM alpine:latest

# Install necessary packages including ffmpeg, Python, Git, build dependencies, and tzdata for timezone data
RUN apk add --no-cache ffmpeg python3 py3-pip fontconfig ttf-dejavu su-exec git tzdata && \
    apk add --no-cache --virtual .build-deps gcc python3-dev musl-dev libffi-dev openssl-dev cargo

# Install Poetry
RUN pip3 install poetry

# Clone the vcsi repository
WORKDIR /tmp
RUN git clone -b iphone14-plus-patch https://github.com/troyxmccall/vcsi

# Build and install vcsi
WORKDIR /tmp/vcsi
RUN poetry build && \
    pip3 install dist/*.whl

# Clean up build dependencies
RUN apk del .build-deps

# Set the timezone to EST
RUN ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime && \
    echo "America/New_York" > /etc/timezone

WORKDIR /

# Add your scripts to the container
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/entrypoint.sh /usr/local/bin/run.sh

# Setup Cron
# Move the script to the daily cron jobs directory
COPY run.sh /etc/periodic/daily/run
RUN chmod +x /etc/periodic/daily/run

# Start the cron daemon with the EST timezone
CMD ["crond", "-f", "-l", "2"]
