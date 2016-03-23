#!/usr/bin/env bash

set -x

if [[ ! -f /agent/buildAgent.zip ]]
then
    mkdir -p /agent
    cd /agent

    wget http://${server}/update/buildAgent.zip
    unzip buildAgent.zip
    chmod +x ./bin/agent.sh

    sed "s/localhost:8111/${server}/" < conf/buildAgent.dist.properties > conf/buildAgent.properties

    if [[ ! -z "${special_config}" ]]
    then
        echo -e "\n${special_config}\n" >> conf/buildAgent.properties
    fi
fi

sed -re "s/^.*ownAddress.*$/ownAddress=$(ip addr show eth0 | egrep -o '([0-9]{1,3}.){3}[0-9]{1,3}')/" -i conf/buildAgent.properties
sed -re "s/^name=.*$/name=${name_prefix}$(hostname)/" -i conf/buildAgent.properties

cat conf/buildAgent.properties

./bin/agent.sh run
