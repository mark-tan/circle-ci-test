#!/bin/bash
set -e
cmd="$@"

source ~/.bashrc
airflow initdb
airflow upgradedb

exec $cmd
