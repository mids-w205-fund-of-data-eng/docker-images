FROM ubuntu:16.04
MAINTAINER Mark Mims <mark@digitalocean.com>

RUN apt-get -qq update \
  && apt-get -qq upgrade -y \
  && apt-get install -y \
      curl \
      dnsutils \
      pandoc \
      texlive-latex-recommended texlive-xetex texlive-luatex pandoc-citeproc etoolbox wkhtmltopdf texlive \
  && apt-get autoremove -y 

RUN curl -OL https://github.com/jgm/pandoc/releases/download/2.0.6/pandoc-2.0.6-1-amd64.deb \
  && dpkg -i pandoc-2.0.6-1-amd64.deb

COPY templates/mids-revealjs-template.html /templates/

WORKDIR /source

ENTRYPOINT ["/usr/bin/pandoc"]
CMD ["--version"]
