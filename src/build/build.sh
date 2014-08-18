#!/usr/bin/env bash

puppet apply /tmp/build/etc/puppet/manifests/build.pp

cp /tmp/build/etc/puppet/manifests/run.pp /etc/puppet/manifests/run.pp