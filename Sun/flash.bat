@echo off
title ��������ڱ��������ʾ[ѡ��]�������밴�»س���������Ҽ����ѡ�񣬷�����ִͣ�������
mode con cols=100 lines=30

if %PROCESSOR_ARCHITECTURE%==x86 (set cpuArch=x86) else set cpuArch=amd64



echo.
echo       ��ӭʹ��GTר����ˢ�ű�
echo           ���ߣ�Ȼ���Ϊ�ϵܶ���
echo.
echo    ���ͣ�RMX2202
echo.
echo �뽫�ֻ����뵽fastbootģʽ����������ס�����º͵�Դ����


)
echo ���������ʼˢ��
cd images
pause >nul
zstd.exe super.img.zst -d -o super.img
echo ����������fastbootdģʽ���ֻ����Զ�����ָ�ģʽ���������ֻ�!
fastboot.exe reboot fastboot >nul
::fastboot.exe  getvar is-userspace 2>&1 | findstr /r /c:"^is-userspace: *yes" || goto FB_FIX 

fastboot.exe getvar is-userspace 2>&1 | findstr /r /c:"^is-userspace: *yes" || goto FB_FIX
goto FLASH

:FLASH
echo ����ˢ��A��λ

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



echo ����ˢ��B��λ

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
echo ����������A��λ
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
echo ˢ�����!�����ש�����recovery�������
echo.
echo QQ��1239120048
echo ���������뷴������ˮ
pause
exit

:FB_FIX
echo �����޸�fastbootd����!
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
echo �޸��޸��ɹ� 
pause
goto FLASH

:FB_FAIL
echo �޸�fastbootd����ʧ��!�˳�ˢ��ģʽ
echo ����ϵ��ˮ
echo QQ��1239120048
echo.
pause
