#!/bin/bash

if [[ $USER != 'root' ]]; then
	echo "Maaf, Anda harus menjalankan ini sebagai root"
	exit
fi

MYIP=$(wget -qO- ipv4.icanhazip.com)

echo "-----------------------------------"
echo "USERNAME              EXP DATE     "
echo "-----------------------------------"

while read expired
do
	AKUN="$(echo $expired | cut -d: -f1)"
	ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
	exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
	if [[ $ID -ge 1000 ]]; then
		printf "%-21s %2s\n" "$AKUN" "$exp"
	fi
done < /etc/passwd

JUMLAH="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"

echo "-----------------------------------"
echo "Jumlah akun: $JUMLAH user"
echo "-----------------------------------"
echo ""
echo "----------------------------------------------------------------"

	echo " DEVELOPED BY YUSUF ARDIANSYAH n ELANG OVERDOSIS"
echo "----------------------------------------------------------------"
echo ""

