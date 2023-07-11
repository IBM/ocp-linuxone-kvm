#/bin/bash
# Script to create the bootstrap guest kvm 

. ./env
echo "LOCATION= ${LOCATION}"

virt-install --name ${CLUSTER_NAME}-bootstrap --debug \
  --disk ${VIRT_IMAGE_DIR}/${CLUSTER_NAME}-bootstrap.qcow2,size=120 --ram 16000 --cpu host --vcpus 4 \
  --os-type linux --os-variant rhel8.0 \
  --network network=${VIR_NET} --noreboot --wait -1 --graphics none --console pty,target_type=serial \
  --location ${VIRT_IMAGE_DIR},kernel=${KERNEL},initrd=${INITRAMFS} \
  --extra-args "nomodeset console=ttyS0,115200n8 rd.neednet=1 coreos.inst=yes coreos.inst.install_dev=vda coreos.live.rootfs_url=${LOCATION}/ocp/${ROOTFS} ip=${BOOTSTRAP_IP}::${DEFAULT_GW}:${SUBNET_MASK}:${BOOTSTRAP_HOSTNAME}.${CLUSTER_NAME}.${DOMAIN}::none nameserver=${NAMESERVER} coreos.inst.ignition_url=${LOCATION}/ignitions/bootstrap.ign"
