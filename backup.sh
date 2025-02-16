#!/bin/bash
ORIGINAL=practica_backup
DESTINO=destino_backup
DATE=$(date +%Y-%m-%d_%H-%M)
BACKUP_FILE=$DESTINO/backup_$DATE.tar.gz

if [ ! -d "$DESTINO" ]; then
        mkdir -p "$DESTINO"
fi

tar -czf  $BACKUP_FILE $ORIGINAL

echo "Copia creada: $BACKUP_FILE"
#descomprimir: sudo tar -xzf destino_backup/backup_2025-02-16_19-04.tar.gz -C .
