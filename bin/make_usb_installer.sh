#!/bin/bash
# make usb installer
#
# ./make_usb_installer.sh <iso:/path/to/archlinux.iso> <usb:/dev/sdx>
#
# write command need sudo permission.

iso_file="$1"
usb_file="$2"

## check program and files
if ! command -v dd &> /dev/null; then
  echo "dd could not be found"
  exit
fi

if [[ ! -e $iso_file ]]; then
  echo "$iso_file is not exist"
  exit
fi

if [[ ! -e $usb_file ]]; then
  echo "$usb_file is not exist"
  exit
fi


## check no mounted usb flash install media using lsblk.
## if mounted usb flash install media, unmount media.
OLD_IFS=$IFS

IFS=$'\n'
checked_result=($(df -h | grep $usb_file))
IFS=' '
for res in "${checked_result[@]}"; do
  read -ra res_array <<< "$res"
  file_name=$(echo "${res_array[@]:5:${#res_array[@]}}" | sed -e 's/ /\ /g')

  echo "umount $file_name"
  umount "$file_name"
done

IFS=$OLD_IFS


## partition and formatting
echo "sudo gdisk $usbfile"
echo "1.   command o"
echo "2.   command n"
echo "2-1.   partition number: default"
echo "2-2.   first sector:     default"
echo "2-3.   last sector:      default"
echo "2-4.   hex code or GUID: 0700"
echo "3.   command w"

sudo gdisk "$usb_file"
sudo mkfs.vfat -v -c -F 32 -n TRANSCEND "$usb_file"


## write
echo "writing..."
echo "dd bs=4M if=$iso_file of=$usb_file status=progress && sync"
sudo dd bs=4M if=$iso_file of=$usb_file status=progress && sync
