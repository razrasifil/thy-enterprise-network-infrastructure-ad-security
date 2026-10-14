Microsoft Windows Server [Version 10.0.17763]
(c) Microsoft Corporation. All rights reserved.

C:\Windows\system32> :: 1. Adım: Merkez sunucunun statik IP, Alt Ağ Maskesi ve Gateway ayarlarının yapılması
C:\Windows\system32> netsh interface ipv4 set address name="Ethernet" static 10.0.100.10 255.255.255.0 10.0.100.1

C:\Windows\system32> :: 2. Adım: Sunucunun kendisi aynı zamanda DNS sunucusu (Active Directory) olduğu için yerel DNS tanımlanması
C:\Windows\system32> netsh interface ipv4 set dns name="Ethernet" static 10.0.100.10

C:\Windows\system32> :: 3. Adım: Yapılandırılan IP ve DNS servis bilgilerinin teyit edilmesi
C:\Windows\system32> ipconfig /all

Windows IP Configuration
   Host Name . . . . . . . . . . . . : WIN-QN6UHRU4QQR
   Primary Dns Suffix  . . . . . . . : thy.local
 

Ethernet adapter Ethernet:
   IPv4 Address. . . . . . . . . . . : 10.0.100.10 
   Subnet Mask . . . . . . . . . . . : 255.255.255.0
   Default Gateway . . . . . . . . . : 10.0.100.1
   DNS Servers . . . . . . . . . . . : 10.0.100.10

C:\Windows\system32> :: 4. Adım: Erzurum-Client (10.0.100.20) makinesine doğru hat kontrolü
C:\Windows\system32> ping 10.0.100.20

Pinging 10.0.100.20 with 32 bytes of data:
Reply from 10.0.100.20: bytes=32 time=1ms TTL=128
Reply from 10.0.100.20: bytes=32 time<1ms TTL=128
Reply from 10.0.100.20: bytes=32 time<1ms TTL=128
Reply from 10.0.100.20: bytes=32 time=1ms TTL=128

Ping statistics for 10.0.100.20:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum = 0ms, Maximum = 1ms, Average = 0ms

C:\Windows\system32> :: 5. Adım: Istanbul-Manager (10.0.100.30) makinesine doğru hat kontrolü
C:\Windows\system32> ping 10.0.100.30

Pinging 10.0.100.30 with 32 bytes of data:
Reply from 10.0.100.30: bytes=32 time=1ms TTL=128
Reply from 10.0.100.30: bytes=32 time<1ms TTL=128
Reply from 10.0.100.30: bytes=32 time=1ms TTL=128
Reply from 10.0.100.30: bytes=32 time<1ms TTL=128

Ping statistics for 10.0.100.30:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum = 0ms, Maximum = 1ms, Average = 0ms

C:\Windows\system32>


-----------------------------------------------------------------------------
Microsoft Windows [Version 10.0.19045]
(c) Microsoft Corporation. All rights reserved.

C:\Windows\system32> :: 1. Adım: İstanbul yönetim bilgisayarına statik IP, Maske ve Gateway tanımlanması
C:\Windows\system32> netsh interface ipv4 set address name="Ethernet" static 10.0.100.30 255.255.255.0 10.0.100.1

C:\Windows\system32> :: 2. Adım: thy.local alan adını çözebilmesi için DNS hedefi olarak Ankara Merkez Sunucusunun girilmesi
C:\Windows\system32> netsh interface ipv4 set dns name="Ethernet" static 10.0.100.10

C:\Windows\system32> :: 3. Adım: Önbellek temizliği ve IP durum kontrolü
C:\Windows\system32> ipconfig /all

Windows IP Configuration
   Host Name . . . . . . . . . . . . : Istanbul-Manager
   Primary Dns Suffix  . . . . . . . : thy.local
  

Ethernet adapter Ethernet:
   IPv4 Address. . . . . . . . . . . : 10.0.100.30 
   Subnet Mask . . . . . . . . . . . : 255.255.255.0
   Default Gateway . . . . . . . . . : 10.0.100.1
   DNS Servers . . . . . . . . . . . : 10.0.100.10

C:\Windows\system32> :: 4. Adım: Ankara HQ Merkez Sunucusuna (Domain Controller) ping bağlantı doğrulaması
C:\Windows\system32> ping 10.0.100.10

Pinging 10.0.100.10 with 32 bytes of data:
Reply from 10.0.100.10: bytes=32 time=1ms TTL=128
Reply from 10.0.100.10: bytes=32 time<1ms TTL=128
Reply from 10.0.100.10: bytes=32 time<1ms TTL=128
Reply from 10.0.100.10: bytes=32 time=1ms TTL=128

Ping statistics for 10.0.100.10:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum = 0ms, Maximum = 1ms, Average = 0ms

C:\Windows\system32> :: 5. Adım: Erzurum Şubesi İstemci bilgisayarına (10.0.100.20) ping bağlantı doğrulaması
C:\Windows\system32> ping 10.0.100.20

Pinging 10.0.100.20 with 32 bytes of data:
Reply from 10.0.100.20: bytes=32 time=1ms TTL=128
Reply from 10.0.100.20: bytes=32 time=2ms TTL=128
Reply from 10.0.100.20: bytes=32 time=1ms TTL=128
Reply from 10.0.100.20: bytes=32 time=1ms TTL=128

Ping statistics for 10.0.100.20:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum = 1ms, Maximum = 2ms, Average = 1ms

C:\Windows\system32>
---------------------------------------------------------------------------------------------
Microsoft Windows [Version 10.0.19045.3803]
(c) Microsoft Corporation. Tüm hakları saklıdır.

C:\Windows\system32> :: 1. Adım: Erzurum yerel ağ kartına statik IP, Maske ve Gateway tanımlanması
C:\Windows\system32> netsh interface ipv4 set address name="Ethernet" static 10.0.100.20 255.255.255.0 10.0.100.1

C:\Windows\system32> :: 2. Adım: thy.local alan adını çözebilmesi için DNS hedefi olarak Ankara Merkez Sunucusunun girilmesi
C:\Windows\system32> netsh interface ipv4 set dns name="Ethernet" static 10.0.100.10

C:\Windows\system32> :: 3. Adım: Önbellek temizliği ve IP kontrolü
C:\Windows\system32> ipconfig /all

Windows IP Configuration
   Host Name . . . . . . . . . . . . : Erzurum-Client
   Primary Dns Suffix  . . . . . . . : thy.local

Ethernet adapter Ethernet:
   IPv4 Address. . . . . . . . . . . : 10.0.100.20
   Subnet Mask . . . . . . . . . . . : 255.255.255.0
   Default Gateway . . . . . . . . . : 10.0.100.1
   DNS Servers . . . . . . . . . . . : 10.0.100.10

C:\Windows\system32> :: 4. Adım: Ankara HQ Merkez Sunucusuna (10.0.100.10) ping bağlantı doğrulaması
C:\Windows\system32> ping 10.0.100.10

Pinging 10.0.100.10 with 32 bytes of data:
Reply from 10.0.100.10: bytes=32 time=1ms TTL=128
Reply from 10.0.100.10: bytes=32 time<1ms TTL=128
Reply from 10.0.100.10: bytes=32 time=1ms TTL=128
Reply from 10.0.100.10: bytes=32 time<1ms TTL=128

Ping statistics for 10.0.100.10:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum = 0ms, Maximum = 1ms, Average = 0ms

C:\Windows\system32> :: 5. Adım: Istanbul-Manager Yönetici bilgisayarına (10.0.100.30) ping bağlantı doğrulaması
C:\Windows\system32> ping 10.0.100.30

Pinging 10.0.100.30 with 32 bytes of data:
Reply from 10.0.100.30: bytes=32 time=1ms TTL=128
Reply from 10.0.100.30: bytes=32 time=1ms TTL=128
Reply from 10.0.100.30: bytes=32 time=2ms TTL=128
Reply from 10.0.100.30: bytes=32 time=1ms TTL=128

Ping statistics for 10.0.100.30:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum = 1ms, Maximum = 2ms, Average = 1ms

C:\Windows\system32>