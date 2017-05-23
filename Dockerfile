FROM python

#
# Install all required dependencies.
#
RUN apt-get update && apt-get install -y inotify-tools

#
# Add named init script.
#
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

#
# Install Pyhton deps.
#
COPY requirements.txt /tmp/requirements.txt
RUN cd /tmp/ && pip3 install -r requirements.txt

#
# Define container settings.
#
RUN mkdir -p /opt/service
WORKDIR /opt/service
ENTRYPOINT ["/bin/bash", "/docker-entrypoint.sh"]
