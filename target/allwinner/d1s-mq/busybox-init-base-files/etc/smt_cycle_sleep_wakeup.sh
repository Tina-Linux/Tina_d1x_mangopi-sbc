#!/bin/ash

cycle_sleep()
{
	i=0;
	echo 0 > /proc/sys/kernel/printk;
	#echo 8 > /proc/sys/kernel/printk;			
	#echo N > /sys/module/printk/parameters/console_suspend;
	#echo Y > /sys/module/kernel/parameters/initcall_debug;
	while true; do
		if [ -f '/sys/power/wakeup_count' ] ; then
			cnt=$(cat /sys/power/wakeup_count);
			echo "Read wakeup_count: $cnt";
			echo $cnt > /sys/power/wakeup_count;
			
			if [ $? -eq 0 ] ; then
				echo "###########";
				echo "#####times: $((i++))";
				echo "###########";
				echo +1 > /sys/class/rtc/rtc0/wakealarm;
				echo mem > /sys/power/state;
				continue;
			else
				echo "Error: write wakeup_count($cnt)";
				sleep 1;
				continue;
			fi
		else
			echo "Error: File wakeup_count not exist";
			break;
		fi
	done
}

test()
{
	echo "start----------------"
}

cycle_sleep
