#!/bin/bash
#sudo apt install slapd ldap-utils


echo 'dn: uid=$nombre,ou=$uni,dc=$dominio,dc=local
objectClass: top
objectClass: posixAccount
objectClass: inetOrgPerson
objectClass: person
cn: $nombre
uid: $nombre
ou: $uni
uidNumber: $uid
gidNumber: $gid
homeDirectory: /home/$nombre
loginShell: /bin/bash
userPassword:
sn: $ape
mail: $nombre.$ape@$dominio.local
givenName: $nombre' > usr.ldif


#sed -e 's/$nombre//g' -e 's/$uni//g' -e 's/$dominio//g' -e 's/$uid//g' -e 's/$gid//g' -e 's/$ape//g' usr.ldif > usr1.ldif


echo 'dn: ou=$unidad,dc=$dominio,dc=local
objectClass: top
objectClass: organizationalUnit
ou: $unidad' > ou.ldif


#sed -e 's/$unidad//g' -e 's/$dominio//g' ou.ldif > ou1.ldif




echo 'dn: cn=$grupo,ou=$unidad,dc=$dominio,dc=local
objectClass: top
objectClass: posixGroup
gidNumber: $gid
cn: $grupo' > grp.ldif


#sed -e's/$grupo//g' -e 's/$unidad//g' -e 's/$gid//g' -e 's/$dominio//g'
