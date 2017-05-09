FROM python
COPY requirements.txt /tmp/requirements.txt
RUN cd /tmp/ && pip3 install -r requirements.txt