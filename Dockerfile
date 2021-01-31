FROM pihole/pihole:latest

ARG DOH_BINARY_TGZ_URL=https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-arm.tgz

ENV DOH_URL="https://doh.cleanbrowsing.org/doh/security-filter/"
ENV DOH_SERVE_PORT=5053
ENV DNS=127.0.0.1#5053

ENV SSL_HOSTNAME=
ENV SSL_CERTIFICATE=

COPY build/* /tmp/build/

RUN /bin/bash -c 'mkdir -p /tmp/build && cd /tmp/build && \
	wget -q -O ./cloudflared.tgz $DOH_BINARY_TGZ_URL && \
	tar -xvzf ./cloudflared.tgz && \
	mkdir ./bin && mv ./cloudflared ./bin && \
	/tmp/build/doh.sh && \
	rm -rf /tmp/build'
