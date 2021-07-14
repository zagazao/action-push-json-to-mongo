#!/bin/bash -l

set -x
set -v
set -e

mongo_cmd="db.${INPUT_MONGO_COLLECTION}.drop()"

# If Username and password as set as env, we create auth options..
[ ! -z "${INPUT_MONGO_USER}" ] && [ ! -z "${INPUT_MONGO_PASSWORD}" ] && auth="--username ${INPUT_MONGO_USER} --password ${INPUT_MONGO_PASSWORD}" || auth=""

#echo "$auth"

mongo --host "${INPUT_MONGO_HOST}" ${auth} --authenticationDatabase admin "${INPUT_MONGO_DATABASE}" --eval "${mongo_cmd}"
mongoimport --host "${INPUT_MONGO_HOST}" ${auth} --authenticationDatabase admin -d "${INPUT_MONGO_DATABASE}" -c "${INPUT_MONGO_COLLECTION}" --jsonArray "${INPUT_MODEL_CFG_OUT}"
