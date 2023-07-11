#!/bin/bash

WWW_IGNITION_DIR="/var/www/html/ignitions/"
OCPDEPLOY_DIR="/root/ocp-install/ocp-deploy"

# create kubernetes manifests
./openshift-install create manifests --dir=${OCPDEPLOY_DIR}

# ensure masters are not schedulable
sed -i 's/mastersSchedulable: true/mastersSchedulable: false/g' ${OCPDEPLOY_DIR}/manifests/cluster-scheduler-02-config.yml

# create ignition config files
./openshift-install create ignition-configs --dir=${OCPDEPLOY_DIR}

cp ${OCPDEPLOY_DIR}/bootstrap.ign ${OCPDEPLOY_DIR}/master.ign ${OCPDEPLOY_DIR}/worker.ign ${WWW_IGNITION_DIR}
chmod o+xr ${WWW_IGNITION_DIR}/*.ign