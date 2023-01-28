@echo off
title ←如果窗口标题左侧显示[选择]字样，请按下回车或按下鼠标右键清除选择，否则将暂停执行输出。
mode con cols=100 lines=30

if %PROCESSOR_ARCHITECTURE%==x86 (set cpuArch=x86) else set cpuArch=amd64



echo.
echo       欢迎使用GT专用线刷脚本
echo           作者：然后成为老弟二号
echo.
echo    机型：RMX2202
echo.
echo 请将手机进入到fastboot模式（重启并按住音量下和电源键）


)
echo 按任意键开始刷机
cd images
pause >nul
zstd.exe super.img.zst -d -o super.img
echo 正在重启至fastbootd模式，手机将自动进入恢复模式，请勿触碰手机!
fastboot.exe reboot fastboot >nul
::fastboot.exe  getvar is-userspace 2>&1 | findstr /r /c:"^is-userspace: *yes" || goto FB_FIX 

fastboot.exe getvar is-userspace 2>&1 | findstr /r /c:"^is-userspace: *yes" || goto FB_FIX
goto FLASH

:FLASH
echo 正在刷入A槽位

fastboot.exe set_active a
fastboot.exe flash boot boot.img
fastboot.exe flash dtbo dtbo.img
fastboot.exe flash vendor_boot vendor_boot.img
fastboot.exe flash vbmeta vbmeta.img
fastboot.exe flash vbmeta_system vbmeta_system.img
fastboot.exe flash vbmeta_vendor vbmeta_vendor.img
fastboot.exe flash abl abl.elf
fastboot.exe flash aop aop.mbn
fastboot.exe flash bluetooth BTFM.bin
fastboot.exe flash cpucp cpucp.elf
fastboot.exe flash devcfg devcfg.mbn
fastboot.exe flash dsp dspso.bin
fastboot.exe flash engineering_cdt engineering_cdt.img
fastboot.exe flash featenabler featenabler.mbn
fastboot.exe flash hyp hypvm.mbn
fastboot.exe flash imagefv imagefv.elf
fastboot.exe flash keymaster km41.mbn
fastboot.exe flash multiimgoem multi_image.mbn
fastboot.exe flash oplus_sec oplus_sec.mbn
fastboot.exe flash oplusstanvbk static_nvbk.20627.bin
fastboot.exe flash qupfw qupv3fw.elf
fastboot.exe flash qweslicstore qweslicstore.bin
fastboot.exe flash shrm shrm.elf
fastboot.exe flash splash splash.img
fastboot.exe flash tz tz.mbn
fastboot.exe flash uefisecapp uefi_sec.mbn
fastboot.exe flash vm-bootsys vm-bootsys.img
fastboot.exe flash xbl xbl.elf
fastboot.exe flash xbl_config xbl_config.elf



echo 正在刷入B槽位

fastboot.exe set_active b
fastboot.exe flash boot boot.img
fastboot.exe flash dtbo dtbo.img
fastboot.exe flash vendor_boot vendor_boot.img
fastboot.exe flash vbmeta vbmeta.img
fastboot.exe flash vbmeta_system vbmeta_system.img
fastboot.exe flash vbmeta_vendor vbmeta_vendor.img
fastboot.exe flash abl abl.elf
fastboot.exe flash aop aop.mbn
fastboot.exe flash bluetooth BTFM.bin
fastboot.exe flash cpucp cpucp.elf
fastboot.exe flash devcfg devcfg.mbn
fastboot.exe flash dsp dspso.bin
fastboot.exe flash engineering_cdt engineering_cdt.img
fastboot.exe flash featenabler featenabler.mbn
fastboot.exe flash hyp hypvm.mbn
fastboot.exe flash imagefv imagefv.elf
fastboot.exe flash keymaster km41.mbn
fastboot.exe flash multiimgoem multi_image.mbn
fastboot.exe flash oplus_sec oplus_sec.mbn
fastboot.exe flash oplusstanvbk static_nvbk.20627.bin
fastboot.exe flash qupfw qupv3fw.elf
fastboot.exe flash qweslicstore qweslicstore.bin
fastboot.exe flash shrm shrm.elf
fastboot.exe flash splash splash.img
fastboot.exe flash tz tz.mbn
fastboot.exe flash uefisecapp uefi_sec.mbn
fastboot.exe flash vm-bootsys vm-bootsys.img
fastboot.exe flash xbl xbl.elf
fastboot.exe flash xbl_config xbl_config.elf

timeout /t 10 /nobreak >NUL
echo 正在重启至A槽位
fastboot.exe  set_active a 
fastboot.exe  getvar is-userspace 2>&1 | findstr /r /c:"^is-userspace: *no" || fastboot.exe reboot bootloader

fastboot.exe set_active b
fastboot.exe flash modem NON-HLOS.bin
fastboot.exe set_active a
fastboot.exe flash modem NON-HLOS.bin
fastboot.exe flash super super.img
)
timeout /t 10 /nobreak >NUL
fastboot.exe  reboot 
echo 刷机完成!建议救砖后进入recovery清除数据
echo.
echo QQ：1239120048
echo 发现问题请反馈给秋水
pause
exit

:FB_FIX
echo 尝试修复fastbootd环境!
 fastboot.exe set_active a
 fastboot.exe reboot fastboot 
 fastboot.exe getvar is-userspace 2>&1 | findstr /r /c:"^is-userspace: *no" || goto FLASH 

 fastboot.exe --disable-verity --disable-verification flash vbmeta vbmeta.img
 fastboot.exe reboot fastboot 
 fastboot.exe getvar is-userspace 2>&1 | findstr /r /c:"^is-userspace: *no" || goto FLASH 
 
 fastboot.exe set_active b
 fastboot.exe reboot fastboot 
 fastboot.exe getvar is-userspace 2>&1 | findstr /r /c:"^is-userspace: *no" || goto FLASH 
 
 fastboot.exe --disable-verity --disable-verification flash vbmeta vbmeta.img
 fastboot.exe reboot fastboot 
 fastboot.exe getvar is-userspace 2>&1 | findstr /r /c:"^is-userspace: *no" || goto FLASH 
 
fastboot.exe flash boot boot.img
fastboot.exe flash dtbo dtbo.img
fastboot.exe flash vendor_boot vendor_boot.img
fastboot.exe flash modem modem.img
fastboot.exe --disable-verity --disable-verification flash vbmeta vbmeta.img
fastboot.exe reboot fastboot 
fastboot.exe  getvar is-userspace 2>&1 | findstr /r /c:"^is-userspace: *yes" || goto FB_FAIL 
echo 修复修复成功 
pause
goto FLASH

:FB_FAIL
echo 修复fastbootd环境失败!退出刷机模式
echo 请联系秋水
echo QQ：1239120048
echo.
pause
