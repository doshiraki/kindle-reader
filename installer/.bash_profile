#!/bin/bash -x
cat .env
. <(sed -e 's/^/export /' .env)
[ -d /root/.wine/drive_c/windows/syswow64/gecko/2.47.2 ] || wine msiexec /i wine-gecko-2.47.2-x86.msi
if [ ! -f '/root/.wine/drive_c/Program Files (x86)/Amazon/Kindle/Kindle.exe' ]
then
	wine KindleForPC-installer-1.40.65535.exe
	echo 再度起動してください
	exit
fi
alias "kindle=bash ~/kindle"
kindle
exit
