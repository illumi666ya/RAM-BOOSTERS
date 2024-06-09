# ILLUMI
# DEMONICA
# www.bento.me/illumi

# SERVICE.SH
# MODDIR
MODDIR=${0%/*}

# DETECT BOOT IF COMPLETE OR NOT FROM KTWEAK (TYTYDRACO) , THANKS
while [[ "$(getprop sys.boot_completed)" -ne 1 ]] && [[ ! -d "/sdcard" ]]
do
       sleep 1
done

# WAIT FOR BOOT TO FINISH COMPLETELY
dbg "Sleeping until boot completes."
while [[ `getprop sys.boot_completed` -ne 1 ]]
do
       sleep 1
done

# WAIT TO THE BOOT BE COMPLETED
sleep_needed_time() {
until [[ $(getprop sys.boot_completed) -eq 1 || $(getprop dev.bootcomplete) -eq 1 ]]; do
sleep 1
done
}

sleep_needed_time

##########################################################################################
# BATAS SUCI :V
##########################################################################################

# ZRAM 4GB
swapoff /dev/block/zram0
echo "1" > /sys/block/zram0/reset
echo "4096000000" >/sys/block/zram0/disksize
echo "4096M" > /sys/block/zram0/mem_limit
echo "8" > /sys/block/zram0/max_comp_streams
echo "lz4" > /sys/block/zram0/comp_algorithm
echo "1024" > /sys/block/zram0/queue/read_ahead_kb
echo "36" > /sys/block/zram0/queue/nr_requests
echo "2" > /sys/block/zram0/queue/rq_affinity
echo "2" > /sys/block/zram0/queue/nomerges
mkswap /dev/block/zram0
swapon /dev/block/zram0

# VM OPTIMIZATION
echo "0" > /proc/sys/vm/block_dump
echo "1" > /proc/sys/vm/compact_memory
echo "1" > /proc/sys/vm/compact_unevictable_allowed
echo "90" > /proc/sys/vm/dirty_ratio
echo "0" > /proc/sys/vm/dirty_bytes
echo "95" > /proc/sys/vm/dirty_background_ratio
echo "1000" > /proc/sys/vm/dirty_expire_centisecs
echo "2000" > /proc/sys/vm/dirty_writeback_centisecs
echo "43200" > /proc/sys/vm/dirtytime_expire_centisecs
echo "3" > /proc/sys/vm/drop_caches
echo "29615" > /proc/sys/vm/extra_free_kbytes
echo "500" > /proc/sys/vm/extfrag_threshold
echo "0" > /proc/sys/vm/laptop_mode
echo "0" > /proc/sys/vm/legacy_va_layout
echo "25632" > /proc/sys/vm/lowmem_reserve_ratio
echo "16" > /proc/sys/vm/mmap_rnd_compat_bits
echo "65530" > /proc/sys/vm/max_map_count
echo " 7610" > /proc/sys/vm/min_free_kbytes
echo "32768" > /proc/sys/vm/mmap_min_addr
echo "24" > /proc/sys/vm/mmap_rnd_bits
echo "0" > /proc/sys/vm/nr_pdflush_threads
echo "1" > /proc/sys/vm/oom_dump_tasks
echo "0" > /proc/sys/vm/oom_kill_allocating_task
echo "0" > /proc/sys/vm/overcommit_kbytes
echo "1" > /proc/sys/vm/overcommit_memory
echo "100" > /proc/sys/vm/overcommit_ratio
echo "1" > /proc/sys/vm/page-cluster
echo "0" > /proc/sys/vm/panic.on.oom
echo "0" > /proc/sys/vm/percpu_pagelist_fraction
echo "0" > /proc/sys/vm/swap_ratio_enable
echo "100" > /proc/sys/vm/swappiness
echo "30" > /proc/sys/vm/stat_interval
echo "131072" > /proc/sys/vm/user_reserve_kbytes
echo "10" > /proc/sys/vm/vfs_cache_pressure
echo "32" > /proc/sys/vm/watermark_scale_factor

# LMK OPTIMIZATION
chmod 666 /sys/module/lowmemorykiller/parameters/minfree
chown root /sys/module/lowmemorykiller/parameters/minfree
echo "2560,5120,11520,25600,35840,38400" > /sys/module/lowmemorykiller/parameters/minfree
chmod 444 /sys/module/lowmemorykiller/parameters/minfree
echo "1" > /sys/module/lowmemorykiller/parameters/oom_reaper
echo "0" > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
echo "0" > /sys/module/lowmemorykiller/parameters/enable_lmk
echo "0" > /sys/module/lowmemorykiller/parameters/debug_level

# DELETE PERFD FOR DEFAULT VALUES
rm /data/system/perfd/default_values
