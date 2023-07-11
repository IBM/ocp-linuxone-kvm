#!/bin/bash

unit_hosts=(
	user1bastion.user1.local
	bootstrap.kvm1.user1.local
	master1.kvm1.user1.local
	master2.kvm1.user1.local
	master3.kvm1.user1.local
	worker1.kvm1.user1.local
	worker2.kvm1.user1.local
	worker3.kvm1.user1.local
	api.kvm1.user1.local
	api-int.kvm1.user1.local
	test.apps.kvm1.user1.local
)

overall_rc=0

for unit_host in ${unit_hosts[*]}; do
	echo "attempting to resolve $unit_host..."
	nslookup $unit_host

	if [ $? -eq 0 ]; then
		echo "resolution successful"
	else
		echo "resolution issues encountered"
		overall_rc=$((overall_rc+1))
	fi
done

exit $overall_rc