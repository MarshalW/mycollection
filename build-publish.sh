#!/usr/bin/env bash

set -e

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit 1
fi

if [[ -z "${ANSIBLE_GALAXY_TOKEN}" ]]; then
  echo "warning: ANSIBLE_GALAXY_TOKEN unset"
fi

TAG=$1

sed -i "s|^version: .*|version: $TAG|" galaxy.yml

git add galaxy.yml
git commit -m "change version to $TAG"

git push
git tag "v$TAG"
git push origin "v$TAG"

ansible-galaxy collection build

ansible-galaxy collection publish ./marshalw-mycollection-$TAG.tar.gz --token=$ANSIBLE_GALAXY_TOKEN


