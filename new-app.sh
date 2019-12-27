#!/bin/bash

# run this script in the migrating apps git repo
# edit the resulting files
# exmaple: ~/git/herro/new-app.sh xxx

if [[ -z $1 ]]; then
  echo "usage: $0 <app> <dir>"
  exit 1
else
  APP=$1
fi

if [[ -n $2 ]]; then
  TARGET_DIR=$2
else
  TARGET_DIR=.
fi

if [[ -z $GIT_DIR ]]; then
  GIT_DIR=~/git
fi


for a in Dockerfile; do
  figlet $a | tee -a ${TARGET_DIR}/${a}
  cat ${GIT_DIR}/herro/${a} | tee -a ${TARGET_DIR}/${a}
done

for a in .Jenkinsfile; do
  figlet $a | tee -a ${TARGET_DIR}/${a}
  sed s/herro/${APP}/ ${GIT_DIR}/herro/${a} >> ${TARGET_DIR}/${a}
  grep $APP ${TARGET_DIR}/${a}
done

for a in package.json; do
  figlet $a | tee -a ${TARGET_DIR}/${a}
  grep 'ci-' ${GIT_DIR}/herro/${a} | sed s/herro/${APP}/ | tee -a ${TARGET_DIR}/${a}
done

for a in docker-compose; do
  figlet $a.ci.yml | tee -a ${TARGET_DIR}/${a}.ci.yml
  if [[ -f ${TARGET_DIR}/${a}.yml ]]; then
    cat ${TARGET_DIR}/${a}.yml | \
      sed s/"docker.invoice2go.io\/prom-pushgateway:latest"/"docker.io\/prom\/pushgateway:v0.9.1"/ | \
      sed s/"docker.invoice2go.io\/itg-node:8.9.0"/"registry.invoice2go.io\/i2g\/${APP}:\$\{DOCKER_SHA\}"/ | \
      sed s/"docker.invoice2go.io"/"registry.invoice2go.io\/i2g"/ | \
      egrep -v "command:|volumes:|\/code" | \
      tee -a ${TARGET_DIR}/${a}.ci.yml
  else 
    sed s/herro/${APP}/ ${GIT_DIR}/herro/${a}.ci.yml | tee -a ${TARGET_DIR}/${a}.ci.yml
  fi
done
