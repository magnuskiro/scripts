@echo off
	echo !----------------!
	echo '----------------'
	echo This script is Written by Magnus Kiro, under the GPL License. 
	echo See http://www.gnu.org/licenses/ for further information.  	
	echo .----------------.
	echo !----------------!
	echo date: 03.11.09 (dd.mm.yy)
pause
cls
	echo ----------
	echo This script will format your usb penn and make it an windows7 startup disk. 
	echo You need an usb penn with at least 3.5GB free space and an win7 cd/image. 
	echo ----------
pause
cls
echo >> c:\script1.src list disk
echo >> c:\script1.src exit
Diskpart < c:\script1.src 
del c:\script1.src
	echo ----------
	echo Careful to continue, the disk will be formated with NTFS file system!
	echo ctrl+c to abort script.
	echo ----------
set /P input=[enter Disk number(0-)] 
set disk=%input%
cls
	echo ----------
	echo Chosen disk is disk: %disk% 
	echo This might take some time....
	echo ----------
echo >> C:\script2.src sel disk %disk%
echo >> c:\script2.src clean
echo >> c:\script2.src create part pri
echo >> c:\script2.src active
echo >> c:\script2.src format fs=NTFS QUICK
echo >> c:\script2.src assign
echo >> c:\script2.src exit
Diskpart < c:\script2.src
del C:\script2.src
cls
		echo ----------
	echo Formating complete.
	echo Now it's time to copy the windows files!
	echo ----------
pause 
cls
echo >> c:\script3.src list vol
echo >> c:\script3.src exit
diskpart < c:\script3.src
del c:\script3.src
set /P inputimg=[Enter the device letter of your cdrom or location of the image file. Write full path]
set img=%inputimg%
	echo ----------
	echo Now set the device letter of the usb penn. 
	echo ----------
set /p inputusb=[usb Device letter, letter only, ':\' is added.] 
set usb=%inputusb%:\
cls
	echo ----------
	echo Chosen location for cd image is %img%
	echo The usb device is assigned the to %usb%
	echo ----------
pause
cls
	echo ----------
	echo Making the usbdisk bootable. 
	echo -----------
%img%\boot\bootsect /nt60 %usb%
cls 
	echo ----------
	echo Copying files, this will take som time ...... (less the 15min)
	echo ----------
XCOPY %img%\ %usb%\ /S /E /H /Y
cls
	echo Operation complete!
pause
