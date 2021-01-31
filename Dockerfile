FROM pihole/pihole:latest

ARG DOH_BINARY_TGZ_URL=https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-arm.tgz

ENV DOH_URL="https://doh.cleanbrowsing.org/doh/security-filter/"
ENV DOH_SERVE_PORT=5053
ENV DNS=127.0.0.1#5053

COPY build/* /tmp/build/

RUN /bin/bash -c 'wget -q -O ./cloudflared.tgz $DOH_BINARY_TGZ_URL && \
tar -xvzf ./cloudflared.tgz && \
rm ./cloudflared.tgz && \
mkdir -p /tmp/build/bin && \
mv ./cloudflared /tmp/build/bin && \
/tmp/build/doh.sh && \
rm -rf /tmp/build'
