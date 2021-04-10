FROM alpine:latest

ENV PATH /usr/local/texlive/2021/bin/x86_64-linuxmusl:$PATH

RUN mkdir /tmp/texlive && \
  apk add --no-cache perl curl && \
  apk add --no-cache --virtual .dev-deps wget tar && \
  curl -L http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz | \
    tar -xz --strip-components=1 -C /tmp/texlive && \
  printf "%s\n" \
    "selected_scheme scheme-custom" \
    "collection-basic 1" \
    "collection-latexrecommended 1" \
    "collection-luatex 1" \
    "tlpdbopt_install_docfiles 0" \
    "tlpdbopt_install_srcfiles 0" \
    > /tmp/texlive/texlive.profile && \
  /tmp/texlive/install-tl --profile /tmp/texlive/texlive.profile && \
  tlmgr install luatexja haranoaji && \
  apk del .dev-deps && \
  rm -rf /tmp/texlive

WORKDIR /workdir

CMD ["ash"]
