# COMPRESSXZ

change `/etc/makepkg.conf` to applied multi threading of compressing.


1. open `/etc/makepkg.conf`
2. search `COMPRESSXZ`
3. change `COMPRESSXZ=(xz -c -z -) to
  COMPRESSXZ=(xz -c -z - --threads=0) or
  COMPRESSXZ=(xz -T 0 -c -z -)


