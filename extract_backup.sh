#!/bin/bash

echo -n "Inserisci il percorso del file di backup cifrato: "
read encrypted_file
echo

echo -n "Inserisci la password di cifratura: "
read -s password
echo

#assegna alla variabile archive il nome del file 'encrypted_file senza l'estensione .enc'
archive=$(basename $encrypted_file .enc)

echo "Sto decifrando..."
# Decifra il file di backup cifrato
openssl enc -d -aes-256-cbc -iter 10000 -k $password < $encrypted_file > $archive
echo "Decifratura completata con successo"

echo "Decompressione file..."
zstd -d --rm $archive

archive=$(basename $archive .zst)
echo "Estrazione file..."
tar -xf $archive

rm $archive $encrypted_file
