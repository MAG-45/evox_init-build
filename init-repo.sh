#!/bin/bash

# Init repo EvoX
mkdir evo && ln -sf ../build.sh evo/build.sh && cd evo
repo init -u https://github.com/Evolution-X/manifest -b vic --git-lfs
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
# Copy Private Keys
git clone ssh://git@github.com/MAG-45/evox-keys/ vendor/evolution-priv/keys
# Add Duchamp manifests
mkdir .repo/local_manifests
git clone https://github.com/MAG-45/evox_manifest_duchamp .repo/local_manifests
# Fix Hardware lineage manifests
sed -i '/<project path="hardware\/lineage\/compat" name="LineageOS\/android_hardware_lineage_compat" \/>/d' .repo/manifests/snippets/lineage.xml
# Fix FP Framework Issue
cd frameworks/base
git fetch https://github.com/snapboss/android_frameworks_base
git cherry-pick -Xtheirs 53ebff0802f1043f361c699442a982b5b6e7792a   
cd ../..
# Sync repo
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags


echo "You can start build EvoX for duchamp !"