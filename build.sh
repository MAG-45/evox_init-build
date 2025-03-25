#!/bin/bash
PAID_SERVER=true
# Prepare dev env
source build/envsetup.sh

# GAPPS
export WITH_GMS=true

# Lunch !
lunch lineage_duchamp-bp1a-userdebug

# Start Building
m evolution

# Copy it t OneDrive Mirror
rclone copy /mnt/evo/out/target/product/duchamp/EvolutionX-*.zip onedrive:/Backup/perso/evox_build_duchamp/Build/
rclone copy /mnt/evo/out/target/product/duchamp/vendor_boot.img onedrive:/Backup/perso/evox_build_duchamp/Build/
rclone copy /mnt/evo/out/target/product/duchamp/boot.img onedrive:/Backup/perso/evox_build_duchamp/Build/
rclone copy /mnt/evo/out/target/product/duchamp/dtbo.img onedrive:/Backup/perso/evox_build_duchamp/Build/
rclone copy /mnt/evo/out/verbose.log* onedrive:/Backup/perso/evox_duchamp_files/GAAPs_logs/

# remove from the server

# Send a notification to discord
curl -X POST -H "Content-Type: application/json" -d '{"content": "🚀 Your Android ROM have been built ! See your OneDrive Mirror 🎉 <@1085964586588586045> "}' "$URL_WEBHOOK"

export WITH_GMS=false

# Lunch !
lunch lineage_duchamp-bp1a-userdebug

# Start Building
m evolution

# Upload to OneDrive
rclone copy /mnt/evo/out/target/product/duchamp/EvolutionX-*.zip onedrive:/Backup/perso/evox_build_duchamp/Build/Vanilla
rclone copy /mnt/evo/out/target/product/duchamp/vendor_boot.img onedrive:/Backup/perso/evox_build_duchamp/Build/Vanilla
rclone copy /mnt/evo/out/target/product/duchamp/boot.img onedrive:/Backup/perso/evox_build_duchamp/Build/Vanilla
rclone copy /mnt/evo/out/target/product/duchamp/dtbo.img onedrive:/Backup/perso/evox_build_duchamp/Build/Vanilla
rclone copy /mnt/evo/out/verbose.log* onedrive:/Backup/perso/evox_duchamp_files/VANILLA_logs/

# Send a notification to discord
curl -X POST -H "Content-Type: application/json" -d '{"content": "🚀 Your Android ROM have been built ! See your OneDrive Mirror 🎉 <@1085964586588586045> "}' "$URL_WEBHOOK"

m installclean

if [[ "$PAID_SERVER" -eq "true" ]]
then
    sudo poweroff
fi
