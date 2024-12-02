@echo on
chcp 1251 >NUL
netsh interface set interface name="Ethernet" admin=ENABLED

:: Необходимо ввести название вашего сетевого подключения сюда "Ethernet"
