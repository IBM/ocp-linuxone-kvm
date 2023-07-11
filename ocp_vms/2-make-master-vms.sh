#/bin/bash
# Script to create all control plane guest vms
# Don't forget to virsh start <vm name> for each guest vm to start them


. ./env
echo "LOCATION= ${LOCATION}"

virt-install --name ${CLUSTER_NAME}-${MASTER1_HOSTNAME} --debug \
  --disk ${VIRT_IMAGE_DIR}/${CLUSTER_NAME}-${MASTER1_HOSTNAME}.qcow2,size=120 --ram 16000 --cpu host --vcpus 4 \
  --os-type linux --os-variant rhel8.0 \
  --network network=${VIR_NET} --noreboot --wait -1 --graphics none --console pty,target_type=serial \
  --location ${VIRT_IMAGE_DIR},kernel=${KERNEL},initrd=${INITRAMFS} \
  --extra-args "nomodeset console=ttyS0,115200n8 rd.neednet=1 coreos.inst=yes coreos.inst.install_dev=vda coreos.live.rootfs_url=${LOCATION}/ocp/${ROOTFS} ip=${MASTER1_IP}::${DEFAULT_GW}:${SUBNET_MASK}:${MASTER1_HOSTNAME}.${CLUSTER_NAME}.${DOMAIN}::none nameserver=${NAMESERVER} coreos.inst.ignition_url=${LOCATION}/ignitions/master.ign"

virt-install --name ${CLUSTER_NAME}-${MASTER2_HOSTNAME} --debug \
  --disk ${VIRT_IMAGE_DIR}/${CLUSTER_NAME}-${MASTER2_HOSTNAME}.qcow2,size=120 --ram 16000 --cpu host --vcpus 4 \
  --os-type linux --os-variant rhel8.0 \
  --network network=${VIR_NET} --noreboot --wait -1 --graphics none --console pty,target_type=serial \
  --location ${VIRT_IMAGE_DIR},kernel=${KERNEL},initrd=${INITRAMFS} \
  --extra-args "nomodeset console=ttyS0,115200n8 rd.neednet=1 coreos.inst=yes coreos.inst.install_dev=vda coreos.live.rootfs_url=${LOCATION}/ocp/${ROOTFS} ip=${MASTER2_IP}::${DEFAULT_GW}:${SUBNET_MASK}:${MASTER2_HOSTNAME}.${CLUSTER_NAME}.${DOMAIN}::none nameserver=${NAMESERVER} coreos.inst.ignition_url=${LOCATION}/ignitions/master.ign"

virt-install --name ${CLUSTER_NAME}-${MASTER3_HOSTNAME} --debug \
  --disk ${VIRT_IMAGE_DIR}/${CLUSTER_NAME}-${MASTER3_HOSTNAME}.qcow2,size=120 --ram 16000 --cpu host --vcpus 4 \
  --os-type linux --os-variant rhel8.0 \
  --network network=${VIR_NET} --noreboot --wait -1 --graphics none --console pty,target_type=serial \
  --location ${VIRT_IMAGE_DIR},kernel=${KERNEL},initrd=${INITRAMFS} \
  --extra-args "nomodeset console=ttyS0,115200n8 rd.neednet=1 coreos.inst=yes coreos.inst.install_dev=vda coreos.live.rootfs_url=${LOCATION}/ocp/${ROOTFS} ip=${MASTER3_IP}::${DEFAULT_GW}:${SUBNET_MASK}:${MASTER3_HOSTNAME}.${CLUSTER_NAME}.${DOMAIN}::none nameserver=${NAMESERVER} coreos.inst.ignition_url=${LOCATION}/ignitions/master.ign"