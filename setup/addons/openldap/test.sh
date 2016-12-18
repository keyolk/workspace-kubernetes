#!/bin/bash

cat<<EOF1>users.ldif
dn: uid=keyolk,ou=users,dc=local,dc=io
objectClass: top
objectClass: account
objectClass: posixAccount
objectClass: shadowAccount
cn: keyolk
uid: keyolk
uidNumber: 16859
gidNumber: 100
homeDirectory: /home/adam
loginShell: /bin/bash
gecos: keyolk
userPassword: {crypt}9dnjf3dlf
shadowLastChange: 0
shadowMax: 0
shadowWarning: 0
EOF1

ldapadd -x -D "cn=admin,dc=local,dc=io" -w admin -f users.ldif
ldappasswd -D "cn=admin,dc=local,dc=io" -w admin -x "uid=keyolk,ou=users,dc=local,dc=io" -s 9dnjf3dlf 

cat<<EOF>groups.ldif
dn: cn=cnct,ou=groups,dc=local,dc=io
objectClass: top
objectClass: posixGroup
gidNumber: 678
EOF

ldapadd -x -D "cn=admin,dc=local,dc=io" -w admin -f groups.ldif

cat<<EOF>add_user_to_group.ldif
dn: cn=cnct,ou=groups,dc=local,dc=io
changetype: modify
add: memberuid
memberuid: keyolk
EOF2

ldapadd -x -D "cn=admin,dc=local,dc=io" -w admin -f groups.ldif
ldapsearch -x -b 'dc=local,dc=io'
