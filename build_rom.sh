# sync rom
repo init --depth=1 -u git://github.com/LineageOS/android.git -b lineage-18.1 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/LinkBoi00/linkmanifest -b eleven --depth=1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# Clone custom lineage stuff
rm -rf vendor/lineage
git clone https://github.com/LinkBoi00/android_vendor_lineage vendor/lineage

# build rom
source build/envsetup.sh
lunch lineage_daisy-user
mka bacon

# Trigger zone
# 220214052021 - dirty
# 205115052021 - dirty

# upload rom los needs *UNOFFICIAL*
rclone copy out/target/product/daisy/*UNOFFICIAL*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d _ -f 2 | cut -d - -f 1) -P
