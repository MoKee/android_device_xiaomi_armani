# Inherit from hardware-specific part of the product configuration
$(call inherit-product, device/xiaomi/armani/full_armani.mk)

# Boot animation
TARGET_SCREEN_HEIGHT := 1280
TARGET_SCREEN_WIDTH := 720

TARGET_BOOTANIMATION_NAME := 720

# Inherit some common Mokee stuff.
$(call inherit-product, vendor/mk/config/gsm.mk)

$(call inherit-product, vendor/mk/config/cdma.mk)

# Inherit some common Mokee stuff.
$(call inherit-product, vendor/mk/config/common_full.mk)



## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := armani
PRODUCT_NAME := mk_armani
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := HM1S
PRODUCT_MANUFACTURER := Xiaomi

PRODUCT_DEFAULT_LANGUAGE := zh
PRODUCT_DEFAULT_REGION := CN

#PRODUCT_LOCALES := zh_CN zh_TW en_US

# Set build fingerprint / ID / Product Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=HM1S \
    TARGET_DEVICE=armani \
    #BUILD_FINGERPRINT=Xiaomi/armani/armani:4.4.4/KTU84Q/JHCCNBF36.0:user/release-keys \
    #PRIVATE_BUILD_DESC="mk_armani-userdebug 4.4.4 KTU84Q JHCCNBF36.0 release-keys"

#MK_NIGHTLY := true

