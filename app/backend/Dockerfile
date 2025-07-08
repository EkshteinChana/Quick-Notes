FROM python:3.13-slim

WORKDIR /app

COPY requirements.txt requirements.txt

# --- NETFREE CERT INTSALL ---
ADD https://netfree.link/dl/unix-ca2.sh /home/netfree-unix-ca.sh 
RUN cat  /home/netfree-unix-ca.sh | sh
ENV NODE_EXTRA_CA_CERTS=/etc/ca-bundle.crt
ENV REQUESTS_CA_BUNDLE=/etc/ca-bundle.crt
ENV SSL_CERT_FILE=/etc/ca-bundle.crt
# --- END NETFREE CERT INTSALL ---

RUN pip install -r requirements.txt

COPY . .

CMD ["sh", "-c", "python init_mysql.py && gunicorn -b 0.0.0.0:5000 app:app"]
