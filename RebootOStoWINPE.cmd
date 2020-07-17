bcdedit.exe /create {ramdiskoptions} /d "Ramdisk options"
bcdedit.exe /set {ramdiskoptions} ramdisksdidevice partition=c:
bcdedit.exe /set {ramdiskoptions} ramdisksdipath \WinPE\boot\boot.sdi
for /f "tokens=2 delims={}" %%g in  ('bcdedit.exe /create /d "WINPE" /application OSLOADER') do (set guid={%%g})
echo %guid%
bcdedit.exe /set %guid% device ramdisk=[c:]\WinPE\sources\boot.wim,{ramdiskoptions}
bcdedit.exe /set %guid% path \windows\system32\winload.efi
bcdedit.exe /set %guid% osdevice ramdisk=[c:]\WinPE\sources\boot.wim,{ramdiskoptions}
bcdedit.exe /set %guid% systemroot \windows
bcdedit.exe /set %guid% winpe yes
bcdedit.exe /set %guid% detecthal yes
bcdedit.exe /displayorder %guid% -addlast
bcdedit.exe /bootsequence %guid% /addfirst
bcdedit.exe /timeout 0
shutdown /r -t 0
