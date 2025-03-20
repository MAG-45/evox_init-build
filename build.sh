#!/bin/bash
PAID_SERVER=false
# Prepare dev env
source build/envsetup.sh

# GAPPS
export WITH_GMS=true

# Lunch !
lunch lineage_duchamp-ap4a-userdebug

# Start Building
m evolution

# Copy it t OneDrive Mirror
rclone copy out/target/product/duchamp/EvolutionX-*.zip onedrive:/Backup/perso/evox_build_duchamp/Build/
rclone copy out/target/product/duchamp/vendor_boot.img onedrive:/Backup/perso/evox_build_duchamp/Build/
rclone copy out/target/product/duchamp/boot.img onedrive:/Backup/perso/evox_build_duchamp/Build/
rclone copy out/target/product/duchamp/dtbo.img onedrive:/Backup/perso/evox_build_duchamp/Build/
rclone copy out/target/product/duchamp/vendor_kernel_boot onedrive:/Backup/perso/evox_build_duchamp/Build
# remove from the server
rm out/target/product/duchamp/EvolutionX-*.zip
rm out/target/product/duchamp/vendor_boot.img
rm out/target/product/duchamp/boot.img
rm out/target/product/duchamp/dtbo.img
rm out/target/product/duchamp/vendor_kernel_boot.img

# Send a notification to discord
curl -X POST -H "Content-Type: application/json" -d '{"content": "🚀 Your Android ROM have been built ! See your OneDrive Mirror 🎉 <@1085964586588586045> "}' "$URL_WEBHOOK"

<<<<<<< HEAD
# Clean Artefacts

m installclean

if [[ "$PAID_SERVER" -eq "true" ]]
then 
    sudo poweroff
=======

export WITH_GMS=false
# Lunch !
lunch lineage_duchamp-ap4a-userdebug

# Start Building
m evolution

# Send a notification to discord
curl -X POST -H "Content-Type: application/json" -d '{"content": "🚀 Your Android ROM have been built ! See your OneDrive Mirror 🎉 <@1085964586588586045> "}' "$URL_WEBHOOK"


if [[ "$PAID_SERVER" -eq "true" ]]
then
    poweroff
>>>>>>> b545952faa9950e0fa12d471f278ef68aade64c6
fi
