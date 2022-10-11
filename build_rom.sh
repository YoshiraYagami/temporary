# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/PixelExperience/manifest -b thirteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/rushiranpise/local_manifest.git --depth 1 -b pe13 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosp_chef-userdebug
export KBUILD_BUILD_USER=rushiranpise
export KBUILD_BUILD_HOST=rushiranpise
export BUILD_USERNAME=rushiranpise
export BUILD_HOSTNAME=rushiranpise
export TZ=Asia/Kolkata #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
# rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
rclone copy out/target/product/chef/*.zip cirrus:chef/pe13 -P

# 4
