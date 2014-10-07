#!/system/bin/sh
# Copyright (c) 2009-2013, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

target=`getprop ro.board.platform`
if [ -f /sys/devices/soc0/soc_id ]; then
    platformid=`cat /sys/devices/soc0/soc_id`
else
    platformid=`cat /sys/devices/system/soc/soc0/id`
fi

serial=`getprop persist.serial.enable`
dserial=`getprop ro.debuggable`

case "$target" in
    "msm8960")
        case "$serial" in
            "0")
                echo 0 > /sys/devices/platform/msm_serial_hsl.0/console
                ;;
            "1")
                echo 1 > /sys/devices/platform/msm_serial_hsl.0/console
                start console
                ;;
            *)
                case "$dserial" in
                     "1")
                         start console
                         ;;
                esac
                ;;
        esac
        ;;
    *)
        case "$dserial" in
            "1")
                start console
                ;;
	esac
	;;
esac

#
# Function to start sensors for DSPS enabled platforms
#
start_sensors()
{
    if [ -c /dev/msm_dsps -o -c /dev/sensors ]; then
        mkdir -p /data/system/sensors
        touch /data/system/sensors/settings
        chmod -h 775 /data/system/sensors
        chmod -h 664 /data/system/sensors/settings
        chown -h system /data/system/sensors/settings

        mkdir -p /data/misc/sensors
        chmod -h 775 /data/misc/sensors
        mkdir -p /persist/misc/sensors
        chmod -h 775 /persist/misc/sensors

        if [ ! -s /data/system/sensors/settings ]; then
            # If the settings file is empty, enable sensors HAL
            # Otherwise leave the file with it's current contents
            echo 1 > /data/system/sensors/settings
        fi
        start sensors
    fi
}

#
# Allow persistent faking of bms
# User needs to set fake bms charge in persist.bms.fake_batt_capacity
#
fake_batt_capacity=`getprop persist.bms.fake_batt_capacity`
case "$fake_batt_capacity" in
    "") ;; #Do nothing here
    * )
    case $target in
        "msm8960")
        echo "$fake_batt_capacity" > /sys/module/pm8921_bms/parameters/bms_fake_battery
        ;;

	"msm8974")
        echo "$fake_batt_capacity" > /sys/module/qpnp_bms/parameters/bms_fake_battery
        ;;

	"msm8226")
        echo "$fake_batt_capacity" > /sys/module/qpnp_bms/parameters/bms_fake_battery
        ;;

	"msm8610")
        echo "$fake_batt_capacity" > /sys/module/qpnp_bms/parameters/bms_fake_battery
        ;;
    esac
esac

start_battery_monitor()
{
	if ls /sys/bus/spmi/devices/qpnp-bms-*/fcc_data ; then
		chown -h root.system /sys/module/pm8921_bms/parameters/*
		chown -h root.system /sys/module/qpnp_bms/parameters/*
		chown -h root.system /sys/bus/spmi/devices/qpnp-bms-*/fcc_data
		chown -h root.system /sys/bus/spmi/devices/qpnp-bms-*/fcc_temp
		chown -h root.system /sys/bus/spmi/devices/qpnp-bms-*/fcc_chgcyl
		chmod -h 0660 /sys/module/qpnp_bms/parameters/*
		chmod -h 0660 /sys/module/pm8921_bms/parameters/*
		mkdir -p /data/bms
		chown -h root.system /data/bms
		chmod -h 0770 /data/bms
		start battery_monitor
	fi
}

start_charger_monitor()
{
	if ls /sys/module/qpnp_charger/parameters/charger_monitor; then
		chown -h root.system /sys/module/qpnp_charger/parameters/*
		chown -h root.system /sys/class/power_supply/battery/input_current_max
		chown -h root.system /sys/class/power_supply/battery/input_current_trim
		chown -h root.system /sys/class/power_supply/battery/input_current_settled
		chown -h root.system /sys/class/power_supply/battery/voltage_min
		chmod -h 0664 /sys/class/power_supply/battery/input_current_max
		chmod -h 0664 /sys/class/power_supply/battery/input_current_trim
		chmod -h 0664 /sys/class/power_supply/battery/input_current_settled
		chmod -h 0664 /sys/class/power_supply/battery/voltage_min
		chmod -h 0664 /sys/module/qpnp_charger/parameters/charger_monitor
		start charger_monitor
	fi
}

#
# start ril-daemon only for targets on which radio is present
#
baseband=`getprop ro.baseband`
izat_premium_enablement=`getprop ro.qc.sdk.izat.premium_enabled`
multirild=`getprop ro.multi.rild`
dsds=`getprop persist.dsds.enabled`
netmgr=`getprop ro.use_data_netmgrd`
sgltecsfb=`getprop persist.radio.sglte_csfb`

case "$baseband" in
    "msm" | "csfb" | "svlte2a" | "mdm" | "sglte" | "unknown")
    start qmuxd
    case "$baseband" in
        "svlte2a" | "csfb")
        start qmiproxy
        ;;
        "sglte")
        if [ "x$sgltecsfb" != "xtrue" ]; then
          start qmiproxy
        else
          setprop persist.radio.voice.modem.index 0
        fi
    esac
    case "$multirild" in
        "true")
         case "$dsds" in
             "true")
             start ril-daemon1
         esac
    esac
    case "$netmgr" in
        "true")
        start netmgrd
    esac
esac

#
# start two rild when dsds property enabled
#
multisim=`getprop persist.radio.multisim.config`
if [ "$multisim" = "dsds" ] || [ "$multisim" = "dsda" ]; then
        stop ril-daemon
        start ril-daemon
        start ril-daemon1
elif [ "$multisim" = "tsts" ]; then
        stop ril-daemon
        start ril-daemon
        start ril-daemon1
        start ril-daemon2
fi

#
# Suppress default route installation during RA for IPV6; user space will take
# care of this
# exception default ifc
for file in /proc/sys/net/ipv6/conf/*
do
  echo 0 > $file/accept_ra_defrtr
done
echo 1 > /proc/sys/net/ipv6/conf/default/accept_ra_defrtr

#
# Start gpsone_daemon for SVLTE Type I & II devices
#
case "$target" in
        "msm7630_fusion")
        start gpsone_daemon
esac
case "$baseband" in
        "svlte2a")
        start gpsone_daemon
        start bridgemgrd
        ;;
        "sglte" | "sglte2")
        start gpsone_daemon
        ;;
esac
case "$target" in
        "msm7630_surf" | "msm8660" | "msm8960" | "msm8974")
        start quipc_igsn
esac
case "$target" in
        "msm7630_surf" | "msm8660" | "msm8960" | "msm8974")
        start quipc_main
esac

case "$target" in
        "msm8960" | "msm8974")
        start location_mq
        start lowi-server
        if [ "$izat_premium_enablement" -eq 1 ]; then
            start xtwifi_inet
            start xtwifi_client
        fi
esac

let "izat_service_gtp_wifi=$izat_service_mask & 2#1"
let "izat_service_gtp_wwan_lite=($izat_service_mask & 2#10)>>1"
let "izat_service_pip=($izat_service_mask & 2#100)>>2"

if [ "$izat_premium_enablement" -ne 1 ]; then
    if [ "$izat_service_gtp_wifi" -ne 0 ]; then
# GTP WIFI bit shall be masked by the premium service flag
        let "izat_service_gtp_wifi=0"
    fi
fi

if [ "$izat_service_gtp_wwan_lite" -ne 0 ] ||
   [ "$izat_service_gtp_wifi" -ne 0 ] ||
   [ "$izat_service_pip" -ne 0 ]; then
# OS Agent would also be started under the same condition
    start location_mq
fi

if [ "$izat_service_gtp_wwan_lite" -ne 0 ] ||
   [ "$izat_service_gtp_wifi" -ne 0 ]; then
# start GTP services shared by WiFi and WWAN Lite
    start xtwifi_inet
    start xtwifi_client
fi

if [ "$izat_service_gtp_wifi" -ne 0 ] ||
   [ "$izat_service_pip" -ne 0 ]; then
# advanced WiFi scan service shared by WiFi and PIP
    start lowi-server
fi

if [ "$izat_service_pip" -ne 0 ]; then
# PIP services
    start quipc_main
    start quipc_igsn
fi

start_sensors

case "$target" in
    "msm7630_surf" | "msm7630_1x" | "msm7630_fusion")
        insmod /system/lib/modules/ss_mfcinit.ko
        insmod /system/lib/modules/ss_vencoder.ko
        insmod /system/lib/modules/ss_vdecoder.ko
        chmod 0666 /dev/ss_mfc_reg
        chmod 0666 /dev/ss_vdec
        chmod 0666 /dev/ss_venc

        value=`cat /sys/devices/system/soc/soc0/hw_platform`

        case "$value" in
            "FFA" | "SVLTE_FFA")
             # linking to surf_keypad_qwerty.kcm.bin instead of surf_keypad_numeric.kcm.bin so that
             # the UI keyboard works fine.
             ln -s  /system/usr/keychars/surf_keypad_qwerty.kcm.bin /system/usr/keychars/surf_keypad.kcm.bin;;
            "Fluid")
             setprop ro.sf.lcd_density 240
             setprop qcom.bt.dev_power_class 2
             start profiler_daemon;;
            *)
             ln -s  /system/usr/keychars/surf_keypad_qwerty.kcm.bin /system/usr/keychars/surf_keypad.kcm.bin;;

        esac

# Dynamic Memory Managment (DMM) provides a sys file system to the userspace
# that can be used to plug in/out memory that has been configured as unstable.
# This unstable memory can be in Active or In-Active State.
# Each of which the userspace can request by writing to a sys file.

# ro.dev.dmm = 1; Indicates that DMM is enabled in the Android User Space. This
# property is set in the Android system properties file.

# ro.dev.dmm.dpd.start_address is set when the target has a 2x256Mb memory
# configuration. This is also used to indicate that the target is capable of
# setting EBI-1 to Deep Power Down or Self Refresh.

        mem="/sys/devices/system/memory"
        op=`cat $mem/movable_start_bytes`
        case "$op" in
           "0" )
                log -p i -t DMM DMM Disabled. movable_start_bytes not set: $op
            ;;

            "$mem/movable_start_bytes: No such file or directory " )
                log -p i -t DMM DMM Disabled. movable_start_bytes does not exist: $op
            ;;

            * )
                log -p i -t DMM DMM available. movable_start_bytes at $op
                movable_start_bytes=0x`cat $mem/movable_start_bytes`
                block_size_bytes=0x`cat $mem/block_size_bytes`
                block=$(($movable_start_bytes/$block_size_bytes))

                echo $movable_start_bytes > $mem/probe
                case "$?" in
                    "0" )
                        log -p i -t DMM $movable_start_bytes to physical hotplug succeeded.
                    ;;
                    * )
                        log -p e -t DMM $movable_start_bytes to physical hotplug failed.
                        return 1
                    ;;
                esac

               chown system system $mem/memory$block/state

                echo online > $mem/memory$block/state
                case "$?" in
                    "0" )
                        log -p i -t DMM \'echo online\' to logical hotplug succeeded.
                    ;;
                    * )
                        log -p e -t DMM \'echo online\' to logical hotplug failed.
                        return 1
                    ;;
                esac

                setprop ro.dev.dmm.dpd.start_address $movable_start_bytes
                setprop ro.dev.dmm.dpd.block $block
            ;;
        esac

        op=`cat $mem/low_power_memory_start_bytes`
        case "$op" in
            "0" )
                log -p i -t DMM Self-Refresh-Only Disabled. low_power_memory_start_bytes not set:$op
            ;;

            "$mem/low_power_memory_start_bytes No such file or directory " )
                log -p i -t DMM Self-Refresh-Only Disabled. low_power_memory_start_bytes does not exist:$op
            ;;

            * )
                log -p i -t DMM Self-Refresh-Only available. low_power_memory_start_bytes at $op
            ;;
        esac
        ;;
    "msm8660" )
        platformvalue=`cat /sys/devices/system/soc/soc0/hw_platform`
        case "$platformvalue" in
            "Fluid")
                start_sensors
                setprop ro.sf.lcd_density 240
                start profiler_daemon;;
            "Dragon")
                setprop ro.sound.alsa "WM8903";;
        esac
        ;;
    "msm8960")
        case "$baseband" in
            "msm")
                start_sensors;;
        esac

        platformvalue=`cat /sys/devices/system/soc/soc0/hw_platform`
        case "$platformvalue" in
             "Fluid")
                 start profiler_daemon;;
             "Liquid")
                 start profiler_daemon;;
        esac

        # lcd density is write-once. Hence the separate switch case
        case "$platformvalue" in
             "Liquid")
                 setprop ro.sf.lcd_density 160;;
             *)
                 setprop ro.sf.lcd_density 240;;
        esac

        # Dynamic Memory Managment (DMM) provides a sys file system to the userspace
        # that can be used to plug in/out memory that has been configured as 'Movable'.
        # This unstable memory can be in Active or In-Active State.
        # Each of which the userspace can request by writing to a sys file.

        # If ro.dev.dmm.dpd.start_address is set here then the target has a memory
        # configuration that supports DynamicMemoryManagement.
        mem="/sys/devices/system/memory"
        op=`cat $mem/movable_start_bytes`
        case "$op" in
            "0" )
                log -p i -t DMM DMM Disabled. movable_start_bytes not set: $op
            ;;

           "$mem/movable_start_bytes: No such file or directory " )
                log -p i -t DMM DMM Disabled. movable_start_bytes does not exist: $op
            ;;

            * )
		        log -p i -t DMM DMM available. movable_start_bytes at $op
		        movable_start_bytes=0x`cat $mem/movable_start_bytes`
		        block_size_bytes=0x`cat $mem/block_size_bytes`
		        block=$((#${movable_start_bytes}/${block_size_bytes}))


                chown system.system $mem/memory$block/state
                chown system.system $mem/probe
                chown system.system $mem/active
                chown system.system $mem/remove
				
				

                setprop ro.dev.dmm.dpd.start_address $movable_start_bytes
                setprop ro.dev.dmm.dpd.block $block
            ;;
        esac
        ;;
    "msm8974")
        platformvalue=`cat /sys/devices/soc0/hw_platform`
        case "$platformvalue" in
             "Fluid")
                 start profiler_daemon;;
             "Liquid")
                 start profiler_daemon;;
        esac
        case "$baseband" in
            "msm")
                start_battery_monitor
                ;;
        esac
        start_charger_monitor
        ;;
    "msm8226")
        start_charger_monitor
        ;;
    "msm8610")
        start_charger_monitor
        ;;
esac
