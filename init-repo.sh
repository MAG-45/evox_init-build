#!/bin/bash

# Init repo EvoX
mkdir evo && cp build.sh evo/build.sh && cd evo
repo init -u https://github.com/Evolution-X/manifest -b vic --git-lfs
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
# Copy Private Keys
git clone ssh://git@github.com/MAG-45/evox-keys/ vendor/evolution-priv/keys
# Add Duchamp manifests
mkdir .repo/local_manifests
git clone https://github.com/MAG-45/evox_manifest_duchamp .repo/local_manifests
rm hardware/lineage/compat -rf
# Fix Hardware lineage manifests
sed -i '/<project path="hardware\/lineage\/compat" name="LineageOS\/android_hardware_lineage_compat" \/>/d' .repo/manifests/snippets/lineage.xml
# Fix FP Framework Issue
cd frameworks/base
git fetch https://github.com/xiaomi-mt6897-duchamp/android_frameworks_base_new
git cherry-pick -Xtheirs 1d372ceec9c401d2521fb5d51284a8d2e309b6c0 1f4591d4818b77c732963e16175776e09a981c6d
cd ../..
# Sync repo
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags


echo "You can start build EvoX for duchamp !"