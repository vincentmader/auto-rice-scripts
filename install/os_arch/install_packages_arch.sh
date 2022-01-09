#!/bin/sh

echo "test1234"

for i in $(cat $RICE/install/os_arch/pkg_list_arch.txt); do
    $PACKAGE_MANAGER -S $i
done

