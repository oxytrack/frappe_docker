#!/bin/bash

docker kill $(docker ps -q)
docker rm $(docker ps -a -q)
#docker image rm $(docker image ls -q)
docker volume rm $(docker volume ls -q)