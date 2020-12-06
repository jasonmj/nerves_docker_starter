FROM erlang:23

# elixir expects utf8.
ENV ELIXIR_VERSION="v1.11.1" \
	LANG=C.UTF-8

RUN set -xe \
	&& ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/archive/${ELIXIR_VERSION}.tar.gz" \
	&& ELIXIR_DOWNLOAD_SHA256="724774eb685b476a42c838ac8247787439913667fe023d2f1ed9c933d08dc57c" \
	&& curl -fSL -o elixir-src.tar.gz $ELIXIR_DOWNLOAD_URL \
	&& echo "$ELIXIR_DOWNLOAD_SHA256  elixir-src.tar.gz" | sha256sum -c - \
	&& mkdir -p /usr/local/src/elixir \
	&& tar -xzC /usr/local/src/elixir --strip-components=1 -f elixir-src.tar.gz \
	&& rm elixir-src.tar.gz \
	&& cd /usr/local/src/elixir \
	&& make install clean

CMD ["iex"]

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get update && apt-get install -y build-essential automake autoconf git squashfs-tools ssh-askpass pkg-config curl wget rsync
RUN wget https://github.com/fhunleth/fwup/releases/download/v1.8.2/fwup_1.8.2_amd64.deb
RUN dpkg -i ./fwup_1.8.2_amd64.deb
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install --force hex nerves_bootstrap

WORKDIR /opt/app
