#/bin/bash
# Script to create the compute node vms
# Don't forget to virsh start <vm name> after this script runs

. ./env
echo "LOCATION= ${LOCATION}"

virt-install --name ${CLUSTER_NAME}-${WORKER1_HOSTNAME} --debug \
  --disk ${VIRT_IMAGE_DIR}/${CLUSTER_NAME}-${WORKER1_HOSTNAME}.qcow2,size=120 --ram 32000 --cpu host --vcpus 12 \
  --os-type linux --os-variant rhel8.0 \
  --network network=${VIR_NET} --noreboot --wait -1 --graphics none --console pty,target_type=serial \
  --location ${VIRT_IMAGE_DIR},kernel=${KERNEL},initrd=${INITRAMFS} \
  --extra-args "nomodeset console=ttyS0,115200n8 rd.neednet=1 coreos.inst=yes coreos.inst.install_dev=vda coreos.live.rootfs_url=${LOCATION}/ocp/${ROOTFS} ip=${WORKER1_IP}::${DEFAULT_GW}:${SUBNET_MASK}:${WORKER1_HOSTNAME}.${CLUSTER_NAME}.${DOMAIN}::none nameserver=${NAMESERVER} coreos.inst.ignition_url=${LOCATION}/ignitions/worker.ign"

virt-install --name ${CLUSTER_NAME}-${WORKER2_HOSTNAME} --debug \
  --disk ${VIRT_IMAGE_DIR}/${CLUSTER_NAME}-${WORKER2_HOSTNAME}.qcow2,size=120 --ram 32000 --cpu host --vcpus 12 \
  --os-type linux --os-variant rhel8.0 \
  --network network=${VIR_NET} --noreboot --wait -1 --graphics none --console pty,target_type=serial \
  --location ${VIRT_IMAGE_DIR},kernel=${KERNEL},initrd=${INITRAMFS} \
  --extra-args "nomodeset console=ttyS0,115200n8 rd.neednet=1 coreos.inst=yes coreos.inst.install_dev=vda coreos.live.rootfs_url=${LOCATION}/ocp/${ROOTFS} ip=${WORKER2_IP}::${DEFAULT_GW}:${SUBNET_MASK}:${WORKER2_HOSTNAME}.${CLUSTER_NAME}.${DOMAIN}::none nameserver=${NAMESERVER} coreos.inst.ignition_url=${LOCATION}/ignitions/worker.ign"

virt-install --name ${CLUSTER_NAME}-${WORKER3_HOSTNAME} --debug \
  --disk ${VIRT_IMAGE_DIR}/${CLUSTER_NAME}-${WORKER3_HOSTNAME}.qcow2,size=120 --ram 32000 --cpu host --vcpus 12 \
  --os-type linux --os-variant rhel8.0 \
  --network network=${VIR_NET} --noreboot --wait -1 --graphics none --console pty,target_type=serial \
  --location ${VIRT_IMAGE_DIR},kernel=${KERNEL},initrd=${INITRAMFS} \
  --extra-args "nomodeset console=ttyS0,115200n8 rd.neednet=1 coreos.inst=yes coreos.inst.install_dev=vda coreos.live.rootfs_url=${LOCATION}/ocp/${ROOTFS} ip=${WORKER3_IP}::${DEFAULT_GW}:${SUBNET_MASK}:${WORKER3_HOSTNAME}.${CLUSTER_NAME}.${DOMAIN}::none nameserver=${NAMESERVER} coreos.inst.ignition_url=${LOCATION}/ignitions/worker.ign"