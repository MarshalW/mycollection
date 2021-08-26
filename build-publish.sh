#!/usr/bin/env bash

set -e

TAG=$1

sed -i "s|^version: .*|version: $TAG|" galaxy.yml

git push
git tag "v$TAG"
git push origin "v$TAG"

ansible-galaxy collection build

ansible-galaxy collection publish ./marshalw-mycollection-$TAG.tar.gz --token='{{ lookup('env', 'ANSIBLE_GALAXY_TOKEN') }}'


