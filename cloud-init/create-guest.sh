#!/bin/bash
#
# Takes RHEL KVM cloud image and creates VM configured with cloud-init
# 
# uses snapshot and increases size of root filesystem so base image not affected
# inserts cloud-init user, network, metadata into disk
# creates 2nd data disk
# then uses cloud-init to configure OS
#
#set -x

# image should be downloaded from ubuntu site
OS_VARIANT="rhel8.0" # osinfo-query os | grep rhel
BASEIMG=/var/lib/libvirt/images/<rhel-kvm-image>.qcow2
VMNAME=user1bastion

SNAPSHOT=/var/lib/libvirt/images/$VMNAME-snapshot-cloudimg.qcow2
SEED=/var/lib/libvirt/images/$VMNAME-seed.img
DISK2=/var/lib/libvirt/images/$VMNAME-extra.qcow2

# create working snapshot, increase size from 10G to 12G
#rm $SNAPSHOT
sudo qemu-img create -b $BASEIMG -F qcow2 -f qcow2 $SNAPSHOT 40G
sudo qemu-img info $SNAPSHOT

# insert metadata into seed image
echo "instance-id: $(uuidgen || echo i-abcdefg)" > meta-data
cp network_config_static.cfg network-config
cp cloud_init.cfg user-data

sudo genisoimage -output $SEED -volid cidata -joliet -rock meta-data network-config user-data

# ensure file permissions belong to kvm group
sudo chmod 666 $SNAPSHOT
sudo chown $USER:kvm $SNAPSHOT $SEED

# create 2nd data disk, 20G sparse
#sudo rm $DISK2
#qemu-img create -f qcow2 $DISK2 20G
#chmod 666 $DISK2
#chown $USER:kvm $DISK2

# create VM using libvirt
virt-install --name $VMNAME \
  --virt-type kvm --memory 2048 --vcpus 2 \
  --boot hd,menu=off \
  --disk path=$SEED,device=cdrom \
  --disk path=/var/lib/libvirt/images/<rhel_iso_image>.iso,device=cdrom \
  --disk path=$SNAPSHOT,device=disk,size=40 \
  --graphics none \
  --os-type Linux --os-variant $OS_VARIANT \
  --network network:macvtap-net \
  --noautoconsole \
  --noreboot
  