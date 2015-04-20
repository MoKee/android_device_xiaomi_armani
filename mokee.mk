# Inherit some common MK stuff
$(call inherit-product, vendor/mk/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/xiaomi/armani/full_armani.mk)

PRODUCT_NAME := mk_armani

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
