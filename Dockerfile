FROM elixir:1.11.2

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get update && apt-get install -y build-essential automake autoconf git squashfs-tools ssh-askpass pkg-config curl wget rsync
RUN wget https://github.com/fhunleth/fwup/releases/download/v1.8.2/fwup_1.8.2_amd64.deb
RUN dpkg -i ./fwup_1.8.2_amd64.deb
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install --force hex nerves_bootstrap

WORKDIR /opt/app
