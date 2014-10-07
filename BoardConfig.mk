#
# Copyright (C) 2014 The Mokee OpenSource Project
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

# inherit from common msm8226-common
-include device/xiaomi/msm8226-common/BoardConfigCommon.mk

# inherit from the proprietary version
-include vendor/xiaomi/armani/BoardConfigVendor.mk

TARGET_BOOTLOADER_NAME		 := armani
TARGET_BOOTLOADER_BOARD_NAME := MSM8226

BOARD_HAVE_XIAOMI_ARMANI := true

BOARD_KERNEL_CMDLINE 	:= console=ttyHSL0,115200,n8 androidboot.console=ttyHSL0 androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x37

BOARD_KERNEL_BASE 	:= 0x00000000
BOARD_KERNEL_PAGESIZE 	:= 2048
BOARD_MKBOOTIMG_ARGS 	:= --ramdisk_offset 0x2000000 --tags_offset 0x01E00000 


BOARD_BOOTIMAGE_PARTITION_SIZE 	    := 16777216	#16M  boot
BOARD_RECOVERYIMAGE_PARTITION_SIZE  := 16777216	#16M  recovery
BOARD_SYSTEMIMAGE_PARTITION_SIZE 	:= 838860800	#800M system
BOARD_USERDATAIMAGE_PARTITION_SIZE  := 6241112064	#6G data
BOARD_FLASH_BLOCK_SIZE 		        := 131072

TARGET_PREBUILT_KERNEL := device/xiaomi/armani/kernel
BOARD_KERNEL_SEPARATED_DT := true

ifneq ($(TARGET_PREBUILT_KERNEL),)
BOARD_CUSTOM_BOOTIMG_MK := device/xiaomi/armani/mkbootimg_pre.mk
TARGET_KERNEL_SOURCE := kernel/xiaomi/msm8226-common
TARGET_KERNEL_CONFIG := cm_msm8226_perf_defconfig
else
TARGET_KERNEL_SOURCE := kernel/xiaomi/armani
TARGET_KERNEL_CONFIG := cm_armani_defconfig
BOARD_CUSTOM_BOOTIMG_MK := device/xiaomi/armani/mkbootimg.mk
endif

# Init
TARGET_NO_INITLOGO := true

# Vendor Init
TARGET_UNIFIED_DEVICE := true
TARGET_INIT_VENDOR_LIB := libinit_msm
TARGET_LIBINIT_DEFINES_FILE := device/xiaomi/armani/init/init_armani.c


# Bluetooth
BOARD_HAVE_BLUETOOTH_QCOM 		 := true
BLUETOOTH_HCI_USE_MCT 			 := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/xiaomi/armani/bluetooth

# Wifi
BOARD_HAS_QCOM_WLAN              := true
BOARD_WLAN_DEVICE                := qcwcn
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WIFI_DRIVER_MODULE_PATH          := "/system/lib/modules/wlan.ko"
WIFI_DRIVER_MODULE_NAME          := "wlan"
WIFI_DRIVER_FW_PATH_STA          := "sta"
WIFI_DRIVER_FW_PATH_AP           := "ap"


# Camera
COMMON_GLOBAL_CFLAGS += -DARMANI_CAMERA_HARDWARE
COMMON_GLOBAL_CFLAGS += -DNEEDS_VECTORIMPL_SYMBOLS

BOARD_VOLD_DISC_HAS_MULTIPLE_MAJORS := true
BOARD_VOLD_MAX_PARTITIONS := 29
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/msm_hsusb/gadget/lun%d/file

# Flags
COMMON_GLOBAL_CFLAGS += -DNO_SECURE_DISCARD

# Revcovery
BOARD_HAS_NO_SELECT_BUTTON 	:= true
BOARD_SUPPRESS_EMMC_WIPE	:= true
BOARD_HAS_LARGE_FILESYSTEM 	:= true
TARGET_USERIMAGES_USE_EXT4	:= true
BOARD_RECOVERY_ALWAYS_WIPES	:= true

BOARD_RECOVERY_SWIPE 		:= true
TARGET_RECOVERY_FSTAB 		:= device/xiaomi/armani/ramdisk/fstab.qcom
TARGET_RECOVERY_PIXEL_FORMAT 	:= "RGBX_8888"
BOARD_USE_CUSTOM_RECOVERY_FONT 	:= \"roboto_15x24.h\"

