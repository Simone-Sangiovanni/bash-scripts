#!/bin/bash
cd /home/username;
backup_name="desktop_backup_$(date +%Y-%m-%d).tar"

echo -n "Inserisci una password per la cifratura: "
read -s password
echo
echo -n "Ripeti la password: "
read -s password2
echo

if [[ $password == $password2 ]]
then
	echo "Creazione archivio..."
	tar -cf /home/username/$backup_name -C /home/username/Desktop .
	echo "Compressione archivio..."
#comprime file con compressione massima (molto lenta), usando 5 thread e rimuovendo il file non compresso
	zstd -z --rm -19 -T5  /home/username/$backup_name;
	echo "Cifratura archivio..."
	openssl enc -aes-256-cbc -salt -iter 10000 -k $password < /home/username/$backup_name.zst > /home/username/$backup_name.zst.enc

	rm /home/username/$backup_name.zst
	mv /home/username/$backup_name.zst.enc /home/username/Desktop/
else
	echo "Le password inserite non corrisopondono"
fi

cd /home/username/Desktop
chown username:username /home/username/Desktop/$backup_name.zst.enc
