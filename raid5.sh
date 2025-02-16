#!/bin/bash
# ======================================================
# Script: crear_raid5.sh
# Descripción: Guía paso a paso para crear un RAID 5 con mdadm
#
# Advertencia: Modifica los nombres de disco (/dev/sdb, /dev/sdc, /dev/sdd)
# según tu sistema. Este script es referencial y debe ser adaptado a tus necesidades.
#
# Requisitos:
#   - Sistema Linux (Ubuntu, Debian, etc.)
#   - Mínimo 3 discos sin datos (por ejemplo: /dev/sdb, /dev/sdc, /dev/sdd)
#   - Permisos de superusuario
# ======================================================

# 1. Instalar mdadm (si no está instalado)
echo "Paso 1: Instalando mdadm..."
sudo apt-get update
sudo apt-get install -y mdadm

# 2. Verifica las unidades disponibles (personaliza esta parte según tu entorno)
echo "Paso 2: Verifica que las siguientes unidades están disponibles para RAID:"
echo "   Ejemplo: /dev/sdb, /dev/sdc, /dev/sdd"
lsblk

# 3. Crear el array RAID 5
echo "Paso 3: Creando el array RAID 5 en /dev/md0..."
sudo mdadm --create /dev/md0 --level=5 --raid-devices=3 /dev/sdb /dev/sdc /dev/sdd

# 4. Comprobar el estado del RAID y esperar a que se sincronice
echo "Paso 4: Verificando el estado del RAID..."
sudo mdadm --detail /dev/md0
echo "Nota: La sincronización puede tardar dependiendo del tamaño de los discos."

# 5. Crear un sistema de archivos en el nuevo RAID
echo "Paso 5: Formateando /dev/md0 con ext4..."
sudo mkfs.ext4 /dev/md0

# 6. Crear el punto de montaje y montar el RAID
echo "Paso 6: Creando punto de montaje en /mnt/raid5 y montando el RAID..."
sudo mkdir -p /mnt/raid5
sudo mount /dev/md0 /mnt/raid5

# 7. Guardar la configuración de mdadm para que se arme automáticamente al arrancar
echo "Paso 7: Guardando la configuración del RAID..."
sudo mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf

# 8. Actualizar el initramfs para que lea la nueva configuración al iniciar
echo "Paso 8: Actualizando initramfs..."
sudo update-initramfs -u

echo "--------------------------------------------"
echo "El RAID 5 se ha creado y montado en /mnt/raid5"
echo "Revisa /etc/mdadm/mdadm.conf y /mnt/raid5 para confirmar."
echo "--------------------------------------------"
#
