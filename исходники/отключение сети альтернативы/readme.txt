Необходимо включить или отключить сетевой адаптер через командную строку

netsh interface set interface name="Подключение по локальной сети" admin=DISABLED
netsh interface set interface name="Подключение по локальной сети" admin=ENABLED


--

А вообще знаю что для проделывания этой операции надо докачать файлик devcon.exe с сайта мелкомягких
Так же, после установки сего файла надо написать в CMD
devcon disable "PCI\and so on, and so further"
- отключает

devcon enable "PCI\and so on, and so further"
- включает

--

Нашел более простой способ решения этой проблемы:
netsh interface set interface name="Имя сетевого адаптера" enable

----


я для переподключения чтобы не ошибиться с именем адаптера еще так делал:
@echo off
for /f "tokens=2 delims==" %%m in ('wmic path Win32_networkadapter where ^(NetConnectionStatus^="2"^) get NetConnectionID /value^|find "="') do (
 for /f "delims=" %%a in ("%%~m") do (
  netsh interface set interface name="%%a" admin=DISABLED
  netsh interface set interface name="%%a" admin=ENABLED
))
pause>nul


---------------



CNic - консольная утилита от Microsoft, которая позволяет управлять подключением / отключением локальных сетевых адаптеров.
В отличие от встроенной в ОС утилиту netsh, позволяет работать с сетевыми адаптерами и в том числе и на Win XP / 2003.
Поддерживает команды:
c - подключить
d - отключить
s - получить статус (используйте вместе с ключом -v)
e - отключить/подключить все адаптеры, кроме указанного
v - выводить поддробную информацию
l - перечислить имена сетевых подключений

Внимание: утилита плохо умеет перечислять адаптеры с русскими буквами в имени, точнее заменяет их на ========. Поэтому для перечисления лучше воспользоваться командой:
netsh interface show interface

Пример отключения адаптера "Ethernet 2":
CNic "Ethernet 2" -d

Пример подключения адаптера "Ethernet 2":
CNic "Ethernet 2" -c

P.S. Не забудьте, что управлять подключением можно только при запуске утилиты с повышенными привилегиями (если включён UAC).



--------


С помощью программки CNic.exe
Пишите cmd файлик, где указываете путь к Cnic.exe, в кавычках имя своей локальной сети, параметр отключения, 2-я строчка для задержки исполнения

start e:\System\LAN\TechniquesForSimp\CNic.exe "LAN" -d
TIMEOUT /T 10 /NOBREAK


для включения сети:
start e:\System\LAN\TechniquesForSimp\CNic.exe "LAN" -c




----------




А я такой утилей выключаю сетевой интерфейс:

@if %showdh%!==! start "" /D"C:\Program Files (x86)\MitwadSoft\for inet\Net Disabler v1.1" "NetDisabler_x64.exe" /D /T 1

так только блокировку инета по dns можно отключить:
@if %showdh%!==! start "" /D"C:\Program Files (x86)\MitwadSoft\for inet\Net Disabler v1.1" "NetDisabler_x64.exe" /D /T 2


включать так:
@if %showdh%!==! start "" /D"C:\Program Files (x86)\MitwadSoft\for inet\Net Disabler v1.1" "NetDisabler_x64.exe" /E /T 1
@if %showdh%!==! start "" /D"C:\Program Files (x86)\MitwadSoft\for inet\Net Disabler v1.1" "NetDisabler_x64.exe" /E /T 2


p.s. вообще , утилита Gui , но умеет и коммандную строку. ещё вроде блокирует через прокси - но я не пробовал
утиля бесплатная. брал тут: https://www.sordum.org/