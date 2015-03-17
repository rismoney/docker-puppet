#!/bin/bash
set -e
set -o noclobber

# Import smitty.
source script/functions

say Create puppetmaster image.
base_tag="jumanjiman/puppetmaster"
hash_tag="${base_tag}:${short_hash}"
late_tag="${base_tag}:latest"
cp -r ssl puppetmaster/
smitty docker build --rm -t $hash_tag puppetmaster/ 2>&1 | tee /tmp/build-puppetmaster.out
smitty docker tag -f $hash_tag $late_tag
