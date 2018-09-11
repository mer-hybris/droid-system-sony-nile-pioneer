
#
# Before running this script please extract raw system image
# and mount loop image to some mount point. Give that mount point
# parameter for this script.
#
# 1. "simg2img system.img system.raw" (Run inside Mer SDK target)
# 2. "mkdir ~/system"
# 3. "sudo mount -t ext4 -o loop system.raw ~/system"
# 4. "./copy_system.sh ~/system/system"
#

if [ -z "$1" ]; then
  echo "No argument supplied, try $0 ~/path/to/system"
  exit
fi

SYSTEM_SPARSE="sparse/system"
SYSTEM_MOUNT=$1

# Add read permission for some binaries under system mount
source droid-system-device/helpers/fixup-permissions.sh

# Remove current sparse and create it again
rm -rf $SYSTEM_SPARSE
mkdir -p $SYSTEM_SPARSE

# Copy content
echo "Copy $SYSTEM_MOUNT/* to $SYSTEM_SPARSE"
cp -r $SYSTEM_MOUNT/* $SYSTEM_SPARSE

# Remove generic unused directories and files
source droid-system-device/helpers/remove-unused.sh

# Move build.prop to proper place
DEVICE=$(grep ro.product.name $SYSTEM_SPARSE/build.prop | cut -d '_' -f2)
mv $SYSTEM_SPARSE/build.prop $DEVICE/system
