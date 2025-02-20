#!/bin/bash
# Init repo EvoX
mkdir evo && cd evo
repo init -u https://github.com/Evolution-X/manifest -b vic --git-lfs
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
# Copy Private Keys
git clone ssh://git@github.com/MAG-45/evox-keys/ vendor/evolution-priv/keys
# Add Duchamp manifests
mkdir .repo/local_manifests
ln -S init-repo/duchamp.xml .repo/local_manifests/duchamp.xml
rm hardware/lineage/compat -rf
# Sync repo
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
# Lunch !
lunch lineage_duchamp-ap4a-userdebug
