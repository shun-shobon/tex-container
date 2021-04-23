FROM alpine:latest

ENV PATH /usr/local/texlive/2021/bin/x86_64-linuxmusl:$PATH

WORKDIR /tmp/texlive

COPY texlive.profile ./

RUN apk add --no-cache perl curl && \
  apk add --no-cache --virtual .dev-deps wget tar && \
  curl -L http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz | \
    tar -xz --strip-components=1 -C ./ && \
  ./install-tl --profile ./texlive.profile && \
  tlmgr install luatexja haranoaji && \
  apk del .dev-deps && \
  rm -rf /tmp/texlive

WORKDIR /workdir

CMD ["ash"]
