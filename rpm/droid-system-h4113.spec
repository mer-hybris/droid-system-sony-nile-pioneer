%define device h4113
%define rpm_device h4113

%define dsd_path ./

%include droid-system-device/droid-system.inc

%post
setcap cap_setgid,cap_audit_control,cap_syslog+ep /system/bin/logd
chmod 0755 /system/bin/logd

