# ILLUMI
# DEMONICA
# www.bento.me/illumi

# POST-FS-DATA.SH
# MODDIR
MODDIR=${0%/*}

# BOOT
while [ -z "$(resetprop sys.boot_completed)" ]; do
  sleep 1
done

# WAIT
until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 1
done

# WAIT V2
wait_until_boot_complete() {
  while [[ "$(getprop sys.boot_completed)" != "1" ]]; do
    sleep 1
  done
}
wait_until_boot_complete

##########################################################################################
# BATAS SUCI :V
##########################################################################################

# SET PERMISSION 
write() {
    local path="$1"
    local data="$2"

    if [ -f "$path" ]; then
        if [ ! -w "$path" ]; then
            chmod +w "$path" 2>/dev/null || return 1
        fi

        echo "$data" >"$path" || {
            echo "Failed: $path → $data"
            return 1
        }
    fi
}

# ZRAM
write /proc/sys/vm/page-cluster 1
write /sys/block/zram0/max_comp_streams 8

# TOUCHBOOST ON
write /sys/module/msm_performance/parameters/touchboost 1
write /sys/power/pnpmgr/touch_boost 1

# SRTAE
if [[ -e "/sys/devices/virtual/touch/touch_dev/bump_sample_rate" ]]; then
  write "1" /sys/devices/virtual/touch/touch_dev/bump_sample_rate
fi
