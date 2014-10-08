#
# Copyright (C) 2011 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

$(call inherit-product, vendor/xiaomi/armani/armani-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/xiaomi/armani/overlay

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

# Recovery allowed devices
TARGET_OTA_ASSERT_DEVICE := armani

# Ramdisk
PRODUCT_COPY_FILES += \
     $(LOCAL_PATH)/ramdisk/fstab.qcom:root/fstab.qcom \
     $(LOCAL_PATH)/ramdisk/init.qcom.rc:root/init.qcom.rc \
     $(LOCAL_PATH)/ramdisk/init.qcom.sh:root/init.qcom.sh \
     $(LOCAL_PATH)/ramdisk/init.target.rc:root/init.target.rc \
     $(LOCAL_PATH)/ramdisk/init.qcom.usb.rc:root/init.qcom.usb.rc \
     $(LOCAL_PATH)/ramdisk/init.qcom.usb.sh:root/init.qcom.usb.sh \
     $(LOCAL_PATH)/ramdisk/init.qcom.syspart_fixup.sh:root/init.qcom.syspart_fixup.sh \
     $(LOCAL_PATH)/ramdisk/ueventd.qcom.rc:root/ueventd.qcom.rc \
     $(LOCAL_PATH)/ramdisk/chargeonlymode:root/sbin/chargeonlymode \
#     $(LOCAL_PATH)/ramdisk/mdbd:root/sbin/mdbd \

# Recovery
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/recovery/init.recovery.qcom.rc:root/init.recovery.qcom.rc \
	$(LOCAL_PATH)/recovery/postrecoveryboot.sh:root/sbin/postrecoveryboot.sh
	
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/etc/init.qcom.post_boot.sh:system/etc/init.qcom.post_boot.sh \
	$(LOCAL_PATH)/etc/init.qcom.bt.sh:system/etc/init.qcom.bt.sh \
	
# keylayout
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/keylayout/AVRCP.kl:system/usr/keylayout/AVRCP.kl \
	$(LOCAL_PATH)/keylayout/Generic.kl:system/usr/keylayout/Generic.kl \
	$(LOCAL_PATH)/keylayout/ft5x06.kl:system/usr/keylayout/ft5x06.kl \
	$(LOCAL_PATH)/keylayout/ist30xx.kl:system/usr/keylayout/ist30xx.kl \
	$(LOCAL_PATH)/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
	$(LOCAL_PATH)/keylayout/qwerty.kl:system/usr/keylayout/qwerty.kl \
	$(LOCAL_PATH)/keylayout/msm8226-tapan-snd-card_Button_Jack.kl:system/usr/keylayout/msm8226-tapan-snd-card_Button_Jack.kl \
	$(LOCAL_PATH)/keylayout/synaptics_rmi4_i2c.kl:system/usr/keylayout/synaptics_rmi4_i2c.kl \
	$(LOCAL_PATH)/keylayout/Vendor_0079_Product_0011.kl:system/usr/keylayout/Vendor_0079_Product_0011.kl \
	$(LOCAL_PATH)/keylayout/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_028e.kl \
	$(LOCAL_PATH)/keylayout/Vendor_046d_Product_c216.kl:system/usr/keylayout/Vendor_046d_Product_c216.kl \
	$(LOCAL_PATH)/keylayout/Vendor_046d_Product_c219.kl:system/usr/keylayout/Vendor_046d_Product_c219.kl \
	$(LOCAL_PATH)/keylayout/Vendor_046d_Product_c21f.kl:system/usr/keylayout/Vendor_046d_Product_c21f.kl \
	$(LOCAL_PATH)/keylayout/Vendor_046d_Product_c294.kl:system/usr/keylayout/Vendor_046d_Product_c294.kl \
	$(LOCAL_PATH)/keylayout/Vendor_046d_Product_c299.kl:system/usr/keylayout/Vendor_046d_Product_c299.kl \
	$(LOCAL_PATH)/keylayout/Vendor_046d_Product_c532.kl:system/usr/keylayout/Vendor_046d_Product_c532.kl \
	$(LOCAL_PATH)/keylayout/Vendor_054c_Product_0268.kl:system/usr/keylayout/Vendor_054c_Product_0268.kl \
	$(LOCAL_PATH)/keylayout/Vendor_0583_Product_2060.kl:system/usr/keylayout/Vendor_0583_Product_2060.kl \
	$(LOCAL_PATH)/keylayout/Vendor_05ac_Product_0239.kl:system/usr/keylayout/Vendor_05ac_Product_0239.kl \
	$(LOCAL_PATH)/keylayout/Vendor_1038_Product_1412.kl:system/usr/keylayout/Vendor_1038_Product_1412.kl \
	$(LOCAL_PATH)/keylayout/Vendor_12bd_Product_d015.kl:system/usr/keylayout/Vendor_12bd_Product_d015.kl \
	$(LOCAL_PATH)/keylayout/Vendor_1689_Product_fd00.kl:system/usr/keylayout/Vendor_1689_Product_fd00.kl \
	$(LOCAL_PATH)/keylayout/Vendor_1689_Product_fd01.kl:system/usr/keylayout/Vendor_1689_Product_fd01.kl \
	$(LOCAL_PATH)/keylayout/Vendor_1689_Product_fe00.kl:system/usr/keylayout/Vendor_1689_Product_fe00.kl \
	$(LOCAL_PATH)/keylayout/Vendor_1bad_Product_f016.kl:system/usr/keylayout/Vendor_1bad_Product_f016.kl \
	$(LOCAL_PATH)/keylayout/Vendor_1bad_Product_f023.kl:system/usr/keylayout/Vendor_1bad_Product_f023.kl \
	$(LOCAL_PATH)/keylayout/Vendor_1bad_Product_f027.kl:system/usr/keylayout/Vendor_1bad_Product_f027.kl \
	$(LOCAL_PATH)/keylayout/Vendor_1bad_Product_f036.kl:system/usr/keylayout/Vendor_1bad_Product_f036.kl \
	$(LOCAL_PATH)/keylayout/Vendor_1d79_Product_0009.kl:system/usr/keylayout/Vendor_1d79_Product_0009.kl \
	$(LOCAL_PATH)/keylayout/Vendor_22b8_Product_093d.kl:system/usr/keylayout/Vendor_22b8_Product_093d.kl \
	$(LOCAL_PATH)/keylayout/Vendor_2378_Product_100a.kl:system/usr/keylayout/Vendor_2378_Product_100a.kl \


# keychars
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/keychars/Generic.kcm:system/usr/keychars/Generic.kcm \
	$(LOCAL_PATH)/keychars/qwerty2.kcm:system/usr/keychars/qwerty2.kcm \
	$(LOCAL_PATH)/keychars/qwerty.kcm:system/usr/keychars/qwerty.kcm \
	$(LOCAL_PATH)/keychars/Virtual.kcm:system/usr/keychars/Virtual.kcm

# idc
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/idc/qwerty2.idc:system/usr/idc/qwerty2.idc \
	$(LOCAL_PATH)/idc/qwerty.idc:system/usr/idc/qwerty.idc \
     
# Thermald
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/thermald/thermal-engine-8226.conf:system/etc/thermal-engine-8226.conf
	
# Wifi    
PRODUCT_PACKAGES += \
    wcnss_service
        
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/wifi/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
	$(LOCAL_PATH)/wifi/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf \
	$(LOCAL_PATH)/wifi/wpa_supplicant_wcn.conf:system/etc/wifi/wpa_supplicant_wcn.conf 

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/wifi/WCNSS_cfg.dat:system/etc/firmware/wlan/prima/WCNSS_cfg.dat \
    $(LOCAL_PATH)/wifi/WCNSS_qcom_cfg.ini:system/etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini \
    $(LOCAL_PATH)/wifi/WCNSS_qcom_wlan_nv.bin:system/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin \
    $(LOCAL_PATH)/prebuilt/modules/pronto/pronto_wlan.ko:system/lib/modules/pronto/pronto_wlan.ko
     
# FM radio
PRODUCT_PACKAGES += \
	qcom.fmradio \
	libqcomfm_jni \
	FM2 \
	FMRecord
	
PRODUCT_BOOT_JARS += qcom.fmradio

# Modules
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/modules/ansi_cprng.ko:system/lib/modules/ansi_cprng.ko \
    $(LOCAL_PATH)/prebuilt/modules/coresight-event.ko:system/lib/modules/coresight-event.ko \
    $(LOCAL_PATH)/prebuilt/modules/dma_test.ko:system/lib/modules/dma_test.ko\
    $(LOCAL_PATH)/prebuilt/modules/evbug.ko:system/lib/modules/evbug.ko \
    $(LOCAL_PATH)/prebuilt/modules/gpio_axis.ko:system/lib/modules/gpio_axis.ko \
    $(LOCAL_PATH)/prebuilt/modules/gpio_event.ko:system/lib/modules/gpio_event.ko \
    $(LOCAL_PATH)/prebuilt/modules/gpio_input.ko:system/lib/modules/gpio_input.ko \
    $(LOCAL_PATH)/prebuilt/modules/gpio_matrix.ko:system/lib/modules/gpio_matrix.ko \
    $(LOCAL_PATH)/prebuilt/modules/gpio_output.ko:system/lib/modules/gpio_output.ko \
    $(LOCAL_PATH)/prebuilt/modules/gspca_main.ko:system/lib/modules/gspca_main.ko \
    $(LOCAL_PATH)/prebuilt/modules/mcdrvmodule.ko:system/lib/modules/mcdrvmodule.ko \
    $(LOCAL_PATH)/prebuilt/modules/mckernelapi.ko:system/lib/modules/mckernelapi.ko \
    $(LOCAL_PATH)/prebuilt/modules/mmc_block_test.ko:system/lib/modules/mmc_block_test.ko \
    $(LOCAL_PATH)/prebuilt/modules/mmc_test.ko:system/lib/modules/mmc_test.ko \
    $(LOCAL_PATH)/prebuilt/modules/msm-buspm-dev.ko:system/lib/modules/msm-buspm-dev.ko \
    $(LOCAL_PATH)/prebuilt/modules/oprofile.ko:system/lib/modules/oprofile.ko \
    $(LOCAL_PATH)/prebuilt/modules/qcedev.ko:system/lib/modules/qcedev.ko \
    $(LOCAL_PATH)/prebuilt/modules/qcrypto.ko:system/lib/modules/qcrypto.ko\
    $(LOCAL_PATH)/prebuilt/modules/radio-iris-transport.ko:system/lib/modules/radio-iris-transport.ko \
    $(LOCAL_PATH)/prebuilt/modules/reset_modem.ko:system/lib/modules/reset_modem.ko \
    $(LOCAL_PATH)/prebuilt/modules/scsi_wait_scan.ko:system/lib/modules/scsi_wait_scan.ko \
    $(LOCAL_PATH)/prebuilt/modules/spidev.ko:system/lib/modules/spidev.ko \
    $(LOCAL_PATH)/prebuilt/modules/test-iosched.ko:system/lib/modules/test-iosched.ko\
    
# prebuilt
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/liboverlay.so:system/lib/liboverlay.so \
    $(LOCAL_PATH)/prebuilt/lights.msm8226.so:system/lib/hw/lights.msm8226.so
    
PRODUCT_PACKAGES += \
    Torch
    
# Recovery Options
PRODUCT_PROPERTY_OVERRIDES += \
    ro.cwm.forbid_format=/persist,/firmware,/boot,/sbl1,/tz,/rpm,/sdi,/aboot \
    ro.cwm.forbid_mount=/persist,/firmware

# Inherit from msm8226-common
$(call inherit-product, device/xiaomi/msm8226-common/msm8226.mk)

