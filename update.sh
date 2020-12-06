#!/usr/bin/env bash
docker-compose up -d
docker-compose exec nerves mix deps.get
docker-compose exec nerves mix firmware
docker-compose exec nerves mix upload 192.168.0.11
docker-compose exec nerves mix upload 192.168.0.12
