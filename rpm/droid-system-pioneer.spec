%define device pioneer
%define rpm_device pioneer

%define dsd_path ./

Requires(post): coreutils
Requires(post): libcap

%include droid-system-device/droid-system.inc

%post
/usr/sbin/setcap cap_setgid,cap_audit_control,cap_syslog+ep /system/bin/logd
/bin/chmod 0755 /system/bin/logd

