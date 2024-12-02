/*	GTA V Useful Macros v6.4.2 (версия от MooNFish 04.09.2023)

Первоначальный скрипт от twentyafterfour https://www.reddit.com/r/GrandTheftAutoV_PC/comments/34vdrt/i_made_some_useful_macros_for_heistsgeneral/
Крутой новый скрипт от 2called-chaos, откуда я спёр часть кода https://github.com/2called-chaos/gtav-online-ahk
Руководство в Steam, где люди выкладывали свои версии и идеи http://steamcommunity.com/sharedfiles/filedetails/?id=502212548
>> Дополниетльаня благодарность ZacharyV, godOFslaves, Xo39uH_u3_CCC за версию, с которой я начал изучать AHK.

1) Установить https://www.autohotkey.com/
2) В настройках игры GTA5 выбрать оконный режим без рамки
3) Запустить скрипт GTA V Useful Macros.ahk правой кнопкой или двойным кликом
Если он не распознаётся программой, открыть его через правую кнопку "Открыть с помощью..." и выбрать AutoHotkey в качестве программы по умолчанию. 
Можно нажать Compile Script и использовать полученный экзешник. 

>> pssuspend.exe и  pskill.exe можно скачать с сайта Майкрософт https://docs.microsoft.com/en-us/sysinternals/downloads/pssuspend
их необходимо один раз предварительно запустить и согласится с лицензией

Кнопки можно менять
"sc002" - шестнадцатиричная система чисел для любого языка раскладки   https://www.autohotkey.com/docs/commands/GetKey.htm
список  кнопок https://www.autohotkey.com/docs/KeyList.htm
Инструкция на русском https://ahk-wiki.ru/


>> В файлах lan-off и lan-on нужно вписать название вашего сетевого подключения, если оно нестандартное
Запускать на Win10 только через скомпилированный exe от имени администратора. 
Может не сработать,  проверьте перед началом игры!
решенеи для WinXP (на всякий) https://thilina.piyasundara.org/2011/06/enabledisable-lan-interface-by-command.html

*/


; Адрес иконки
Menu, Tray, Icon, GTA_Macros_files\GTA5.ico, , 1

; Окно приветствия
Gui, 1: Margin , 0, 0
GUI, 1: +AlwaysOnTop -Border -SysMenu +Owner -Caption +ToolWindow
Gui, 1: Font, cBlack s12, verdana
Gui, 1: Add, Text, ,   GTAV: Useful Macros v6.4.2 (MooNFish, 2called-chaos и многие другие)
GUI, 1: Add, Picture, , GTA_Macros_files\useful_splash.gif
GUI, 1: Show, Center NoActivate autosize , dropDesk
Gui, Add, Button, x12 y528 w625 h40 Center, Run
return

GuiClose:
ButtonRun:
Gui, Submit
SoundPlay, GTA_Macros_files\Start.wav

#NoEnv  					; Отменяет проверку для пустых переменных
SetWorkingDir %A_ScriptDir%  			; Назначает рабочую папку
#IfWinActive ahk_class grcWindow		; Отключает кнопки, если GTA свёрнуто или не запущено



;	 --------- Назначение клавиш ---------   

; кнопки np работают только при включенном NumLock!

ToggleVIPKey := "NumpadAdd" 		; Переключить режим VIP (если вы стали Боссом/CEO/Мотоклубом) - добавляет одно смещение заходе в меню, не актуально на момент 04.09.2023
ToggleCPHKey  := "^NumpadAdd" 		; Переключить режим Ограбление Кайо-Перика Финал (еще один лишний пункт), см DoToggleCPHWithVIP ---- не проверено после обновлений! -----

Passive := "Numpad1" 				; Пассивный режим вкл/выкл (если не Босс)
HealthKey := "Numpad2"				; Съесть снэк из 4 слота
HealthKey2 := "^Numpad2"			; Открыть меню еды
ArmorKey := "Numpad3"				; Надеть сверхтяжёлый бронижелет
ArmorKey2 := "^Numpad3"				; Открыть меню брони

RetCarKey := "Numpad4"				; Запросить транспорт
BuzzardKey := "F9"				; Вызвать буззард (если Босс)

Call2LesterKey := "Numpad5"			; np5 Позвонить Лестеру
Call2MorsMKey := "Numpad6"			; np6 Позвонить в Морс Мючел
Call2PegKey := "Numpad7"			; np7 Позвонить в Пегасус
Call2MechKey := "Numpad8"			; np8 Позвонить Механику
Call2MerrKey := "Numpad9"			; np9 Позвонить Мерриуэзер

VisorKey := "+F11"				; shift+F11 Включить тепловизор/ПНВ (если уже надет нужный шлем), иногда нажать 2 раза, выключать на F11

Car1 := "End" 					; Закрыть все двери личного авто	
Car2 := "Delete" 				; Откр дверь левую	
Car3 := "PgDn" 					; Откр дверь правую
Car4 := "Insert" 				; Откр всё
Car5 := "Pause" 				; Вкл/выкл двигатель

ToggleRadarKey := "F10" 			; Переключение между большой и обычной мини-картой
KillGameKey  := "+F12" 				; Убить процесс GTA5, необходим pskill.exe
ForceDisconnectKey := "F12"			; Заморозить игру на 10 сек для дисконекта, необходим pssuspend.exe
LANdisconnectKey := "^F12"			; Выключает сетевое подключение (игру выкинет в сюжетный режим без сохранения недавнего прогресса)
LANconnectKey := "+^F12"			; Включает сетевое подключение
ToggleAFKKey := "+NumpadSub"			; Переключить в режим AFK
ToggleClickerKey := "^Numpad0" 			; Переключить в режим кликера - ещё тестируется!
Stop1 := "NumpadSub" 				; Перезагрузить скрипт --- для срочного отключения скрипта
DialDialogKey := "^Numpad1"			; Открыть спец меню звонков
EquipScarfKey := "^NumpadDot" 			; Надеть шарф вместо тяж брони (глич для ограбления)


;	 ----- Задержки. Подбираются индивидуально. Когда я ставил меньше, пункты телефона нажимались не всегда --------


global IntMenuDelay := 120				; Sets value(ms) for additional delay after opening interaction menu.
global KeySendDelay := 25				; Sets value(ms) for delay between send key commands.
global KeyPressDuration := 5			; Sets value(ms) for duration each key press is held down.
global IntPhoneDelay := 610			; Задаем задержку при вытаскивании телефона ---- основная
global KeyPhoneDelay := 120			; Задаем задержку при переходе по меню телефона.
					
global IntFocusDelay := 100 			; delay (in ms) after focussing game when AHK-GUI took focus.
global IntPhoneMenuDelay    := 650		; delay (in ms) after opening phone menu  ---- основная
global IntPhoneMenuDelay2 := 250  		; delay (in ms) after selecting phone menu entries.
global IntPhoneScrollDelay  := 75   		; delay (in ms) between scrolls in the phone menu.
global IntKeySendDelay      := 25   		; delay (in ms) delay between send key commands.
global IntKeyPressDuration  := 5  		 ; duration (in ms) each key press is held down.



; На случай, если вы изменяли управление в игре - нужно изменить и тут

global IGB_Interaction := "sc032"		;=m (меню действий)
global IGB_Phone := "Up" 				;=кнопка вверх (телефон)
global IGB_PhoneSpecial := "Space"	;=пробел (для ручного ввода нмоера телефона)
global IGB_Pause := "sc019"  			;=p (меню игры)


;	 ----- Прочее -------


global DoConfirmKill := true 			; If true the KillGame action will ask for confirmation before killing the process
global DoConfirmDisconnect := true  		; If true the ForceDisconnect action will ask for confirmation before suspending the process
global IntDisconnectDelay := 10			; Amount of seconds to freeze the process for, 10 works fine
global DoLANdisconnect := true  		; If true the LANdisconnect action will ask for confirmation before suspending the process
global DisableCapsOnAction  := true 		; Disable caps lock before executing macros, some macros might fail if caps lock is on
global IsClickerActivated := false 		; Initial status of Clicker (should always be false)

global DoToggleCPHWithVIP := false 		; If true ToggleVIP will become a 3-way toggle (off/on/CayoPericoHeistFinal)
global IsVIPActivated := false			; Initial status of CEO/VIP mode (after (re)loading script)
global IsCPHActivated := false 			; Initial status of CPH mode (should always be false)
global IsAFKActivated := false 			; Initial status of AFK mode (should always be false)



; Список телефонных номеров для спец меню звонков DialDialog GUI (можно менять и дополнять)

ArrayPhonebook := []
ArrayPhonebook.push("911           - Службы спасения")
ArrayPhonebook.push("346-555-0137  - Ассистент")
ArrayPhonebook.push("328-555-0153  - Механик")
ArrayPhonebook.push("611-555-0149  - страховая Mors Mutual Insurance")
ArrayPhonebook.push("328-555-0122  - транспорт Pegasus Lifestyle Management")
ArrayPhonebook.push("273-555-0120  - охрана Мерриуезер")
ArrayPhonebook.push("346-555-0176  - дирижабль Atomic Blimp")
ArrayPhonebook.push("323-555-5555  - такси Downtown Cab Co.")
ArrayPhonebook.push("346-555-0102  - Лестер Крест")
ArrayPhonebook.push("273-555-0172  - Капитан (Яхта)")
ArrayPhonebook.push("273-555-0185  - Брюси (тестостерон Bull Shark)")
ArrayPhonebook.push("346-555-0141  - Ламар (Грабитель/Задания)")
ArrayPhonebook.push("346-555-0188  - Мартин Мадразо (Задания)")
ArrayPhonebook.push("328-555-0198  - Рон (Задания)")
ArrayPhonebook.push("611-555-0120  - Симон (Задания)")
ArrayPhonebook.push("611-555-0152  - Джеральд (Задания)")
ArrayPhonebook.push("020-755-0152  - Агент 14 (?)")
ArrayPhonebook.push("273-555-0193  - Benny (не работает?)")
ArrayPhonebook.push("611-555-0192  - Пэйдж (?)")
ArrayPhonebook.push("273-555-0180  - Брайони (?)")
ArrayPhonebook.push("346-555-0196  - Венди (?)")

; Шлюшки (появляются если познакомится в стрип клубе)
ArrayPhonebook.push("611-555-0163  - Chastity (проститутка)")
ArrayPhonebook.push("328-555-0167  - Cheetah (проститутка")
ArrayPhonebook.push("346-555-0186  - Fufu (проститутка)")
ArrayPhonebook.push("611-555-0184  - Infernus (проститутка)")
ArrayPhonebook.push("346-555-0183  - Nikki (проститутка)")
ArrayPhonebook.push("273-555-0189  - Peach (проститутка)")
ArrayPhonebook.push("328-555-0177  - Sapphire (проститутка)")



; 	---- Присвоение  переменных кнопкам (менять не нужно) ----

Hotkey, %ToggleVIPKey%, ToggleVIP
Hotkey, %ToggleCPHKey%, ToggleCPH
Hotkey, %ToggleAFKKey%, ToggleAFK

Hotkey, %Passive%, Passive
Hotkey, %HealthKey%, Health
Hotkey, %HealthKey2%, Health2
Hotkey, %ArmorKey%, Armor
Hotkey, %ArmorKey2%, Armor2
Hotkey, %RetCarKey%, RetCar
Hotkey, %BuzzardKey%, Buzzard
Hotkey, %VisorKey%, Visor

Hotkey, %Call2LesterKey%, Call2Lester
Hotkey, %Call2MorsMKey%, Call2MorsM
Hotkey, %Call2PegKey%, Call2Peg
Hotkey, %Call2MechKey%, Call2Mech
Hotkey, %Call2MerrKey%, Call2Merr

Hotkey, %Car1%, Car1
Hotkey, %Car2%, Car2
Hotkey, %Car3%, Car3
Hotkey, %Car4%, Car4
Hotkey, %Car5%, Car5

Hotkey, %Stop1%, Stop1

Hotkey, %ToggleRadarKey%, ToggleRadar
Hotkey, %KillGameKey%, KillGame
Hotkey, %ForceDisconnectKey%, ForceDisconnect
Hotkey, %ToggleClickerKey%, ToggleClicker
Hotkey, %DialDialogKey%, DialDialog
Hotkey, %EquipScarfKey%, EquipScarf

Hotkey, %LANconnectKey%, LANconnect
Hotkey, %LANdisconnectKey%, LANdisconnect

return

; что это не разобрался, пока пусть будет:
setkeydelay, KeySendDelay, KeyPressDuration, KeyPhoneDelay
setkeydelay, IntKeySendDelay, IntKeyPressDuration






;		----Исполняемый код----

Stop1:		; Перезапустить скрипт
  SoundPlay, %A_WinDir%\Media\Windows Unlock.wav
  sleep, 1000
  Reload
  return


;Выключить капслок
turnCapslockOff() {
  if (!DisableCapsOnAction)
    return
  if (GetKeyState("CapsLock", "T") = 1) {
    ;Input, SingleKey, V L1
    SetCapsLockState, off
  }
}


openInteractionMenu(isVIPActive, isCPHActive) {
  turnCapslockOff()
  Send {%IGB_Interaction%}
  sleep, IntMenuDelay
  if (isCPHActive = 1) {
    Send {Down}
    Send {Down}
  } else if (isVIPActive = 1) {
    Send {Down}
  }
}

openSnackMenu() {
  Send {Down 3}{Enter}{Down 5}{Enter}
}

openArmorMenu() {
  Send {Down 3}{Enter}{Down 4}{Enter}
}

openOutfitMenu() {
  Send {Down 4}{Enter}
}

openTransportMenu() {
  Send {Down 5}{Enter}
}



;Переключение окон
bringGameIntoFocus(applyDelay = false) {
  WinActivate ahk_class grcWindow
  if(applyDelay)
    Sleep IntFocusDelay
}

openPhone() {
  turnCapslockOff()
  Send {%IGB_Phone%}

  ; Necessary delay to allow phone menu to open properly (which it often doesn't anyways)
  sleep, IntPhoneMenuDelay
}

scrollPhoneUp(by = 1) {
  Loop %by% {
    MouseClick, WheelUp, , , 20, 0, D, R
    Sleep IntPhoneScrollDelay
  }
}


;--------------------------------Звонилка----------------------------------------------

makeCall(scrollUp, doOpenPhone = false, menu = 2) {
  turnCapslockOff()
  if(doOpenPhone)
    openPhone()

  ; go to contacts
  scrollPhoneUp(menu)
  sleep IntKeySendDelay
  Send {Enter}
  sleep IntPhoneMenuDelay2

  ; scroll to contact
  scrollPhoneUp(scrollUp)

  ; call it
  Send {Enter}
}


dialNumber(number, doOpenPhone = false) {
  turnCapslockOff()
  if(doOpenPhone)
    openPhone()

  ; go to contacts
  scrollPhoneUp(2)
  Send {Enter}
  sleep IntPhoneMenuDelay2

  ; enter number screen
  Send {%IGB_PhoneSpecial%}
  sleep IntPhoneMenuDelay2

  ; change key delay for this function
  setkeydelay IntPhoneScrollDelay, IntKeyPressDuration

  ; cleanup number
  number_clean := RegExReplace(number, "[^0-9]", "")

  ; enter the actual number
  pointer := 1
  Loop, parse, number_clean
  {
    deltax := _phonePointerCol(A_LoopField) - _phonePointerCol(pointer)
    deltay := _phonePointerRow(A_LoopField) - _phonePointerRow(pointer)

    ; wrap around shortcuts
    if (deltax = 2)
      deltax := -1
    if (deltax = -2)
      deltax := 1
    if (deltay = -3)
      deltay := 1
    if (deltay = 3)
      deltay := -1

    ; move pointer
    if (deltax > 0)
      Send {right %deltax%}

    if (deltay > 0)
      Send {down %deltay%}
    
    if (deltax < 0) {
      deltax := Abs(deltax)
      Send {left %deltax%}
    }
    
    if (deltay < 0) {
      deltay := Abs(deltay)
      Send {up %deltay%}
    }

    pointer := A_LoopField
    Send {Enter}
  }

  ; reset key delay (should not be necessary)
  setkeydelay IntKeySendDelay, IntKeyPressDuration

  ; call it
  Send {%IGB_PhoneSpecial%}
}

_phonePointerRow(num) {
  if (num = 0)
    return 4
  else
    return Ceil(num / 3)
}

_phonePointerCol(num) {
  if (num = 0)
    return 2
  else
    div := Mod(num, 3)
    return div = 0 ? 3 : div
}




;------ Ввод любого номера и звонок ------------------------------


Call2Lester:                             ; Позвонить Лестеру
  ;makeCall(12, true)
  dialNumber("346-555-0102", true)
  return


Call2MorsM:				; Позвонить в Mors Mutual
  ;makeCall(6, true)
  dialNumber("611-555-0149", true)
  return


Call2Peg:                                   ; Позвонить в Пегас
  ;makeCall(4, true)
  dialNumber("328-555-0122", true)
  return


Call2Mech:                                  ; Позвонить Механику
  ;makeCall(8, true)
  dialNumber("328-555-0153", true)
  return


Call2Merr:                                  ; Позвонить Мерриуэзер
  ;makeCall(7, true)
  dialNumber("273-555-0120", true)
  return




;---------------------- Режим босса -------------------------------------------


; Перключить режим VIP (в нём минус один пункт в меню)
ToggleVIP:
  if (IsVIPActivated) {
    if (DoToggleCPHWithVIP) {
      if (IsCPHActivated) {
        IsCPHActivated := false
        IsVIPActivated := false
        SplashTextOn 280, 20, VIP&CPH mode, режим VIP&&CPH выключен
      } else {
        IsCPHActivated := true
        SplashTextOn 350, 20, CPH mode, ВКЛЮЧЕН режим Cayo Perico Heist 
      }
    } else {
      IsVIPActivated := false
      SplashTextOn 250, 20, VIP mode, режим VIP выключен
    }
  } else {
    IsVIPActivated := true
    SplashTextOn 250, 20, VIP mode, ВКЛЮЧЕН режим VIP
  }
  Sleep 2000
  SplashTextOff
  bringGameIntoFocus()
  return


; Переключить режим CPH (Ограбление Кайо-Перика Финал)
ToggleCPH:
  IsCPHActivated := !IsCPHActivated
  if (IsCPHActivated) {
    SplashTextOn 350, 20, CPH mode, ВКЛЮЧЕН режим Cayo Perico Heist
  } else {
    SplashTextOn 350, 20, CPH mode, режим Cayo Perico Heist выключен
  }
  Sleep 2000
  SplashTextOff
  bringGameIntoFocus()
  return



;--------------------------Полезные команды-----------------------------------------------------



Passive:
  openInteractionMenu(false, false) ; Ignore VIP status when going up
  Send {Up}{Enter}{%IGB_Interaction%}								
return

Health:
  openInteractionMenu(IsVIPActivated, IsCPHActivated)
  openSnackMenu()
  Send {Down 2}{Enter}{%IGB_Interaction%}
return

Health2:
SnackMenu:
  openInteractionMenu(IsVIPActivated, IsCPHActivated)
  openSnackMenu()
  return

Armor:
  openInteractionMenu(IsVIPActivated, IsCPHActivated)
  openArmorMenu()
  Send {Up 3}{Enter}{%IGB_Interaction%}
return

Armor2:
  openInteractionMenu(IsVIPActivated, IsCPHActivated)
  openArmorMenu()
  Send {Down 3}
return


RetCar:
  openInteractionMenu(IsVIPActivated, IsCPHActivated)
  openTransportMenu()
  Send {Enter}{%IGB_Interaction%}
return


Buzzard: 
  openInteractionMenu(false, false)
  Send {Enter}{Up 2}{Enter}{Down 4}{Enter}
return


Visor:
  openInteractionMenu(IsVIPActivated, IsCPHActivated)
  openOutfitMenu()
  Send {Down 6}{Enter} 						; опустить визор
  Send {Up 5}{Enter}{Down 4}{Space}				; вкл
  Send {%IGB_Interaction%}
return


;----------------------------------------------------------------------------------------------

Car1:
  openInteractionMenu(IsVIPActivated, IsCPHActivated)
  openTransportMenu()
  Send {Up 7}{Enter}
  Send {Enter}{%IGB_Interaction%}									
return

Car2:
  openInteractionMenu(IsVIPActivated, IsCPHActivated)
  openTransportMenu()
  Send {Up 7}{Enter}
  Send {Right}{Enter}{%IGB_Interaction%}									
return

Car3:
  openInteractionMenu(IsVIPActivated, IsCPHActivated)
  openTransportMenu()
  Send {Up 7}{Enter}
  Send {Right 2}{Enter}{%IGB_Interaction%}									
return

Car4:
  openInteractionMenu(IsVIPActivated, IsCPHActivated)
  openTransportMenu()
  Send {Up 7}{Enter}
  Send {Left}{Enter}{%IGB_Interaction%}									
return

Car5:
  openInteractionMenu(IsVIPActivated, IsCPHActivated)
  openTransportMenu()
  Send {Up 3}{Enter}
  Send {Enter}{%IGB_Interaction%}									
return


EquipScarf:
  openInteractionMenu(IsVIPActivated, IsCPHActivated)
  openOutfitMenu()
  Send {Down}{Enter}
  ; equip scarf and exit menu. This line can be changed to pick different scarfs.
  Send {Up 4}{Right}{%IGB_Interaction%}
  return



;----------------------Особое--------------------------------------------------


;Окно обратного отсчёта
splashCountdown(title, message, seconds, addZero = false) {
  Loop %seconds% {
    SplashTextOn 250, 20, %title%, % StrReplace(message, "%i", seconds + 1 - A_Index)
    Sleep 1000
  }
  if(addZero) {
    SplashTextOn 250, 20, %title%, % StrReplace(message, "%i", 0)
    Sleep 1000
  }
}



; Выполнить дисконект заморозив игру на 10 сек
; необходим pssuspend.exe
ForceDisconnect:
  if (DoConfirmDisconnect) {
    MsgBox, 1, , Выгнать всех из сесии?, 5
    IfMsgBox, Cancel
      Return
    IfMsgBox, Timeout
      Return
  }
  Run, pssuspend gta5.exe ,,Hide
  splashCountdown("Дисконект", "Ожидайте (%i) сек", IntDisconnectDelay, true)
  Run, pssuspend -r gta5.exe ,,Hide
  Sleep 1000
  SplashTextOff
  bringGameIntoFocus()
  return



; Закрыть игру
; необходим pskill.exe
KillGame:
  if (DoConfirmKill) {
    MsgBox, 1, , Завершить игру принудительно?, 30
    IfMsgBox, Cancel
      Return
    IfMsgBox, Timeout
      Return
  }
  Run, pskill gta5.exe ,,Hide
  return



; Поменять режим радара
ToggleRadar:
  ; Open settings
  turnCapslockOff()
  SoundPlay, %A_WinDir%\Media\Windows Proximity Notification.wav
  Send {sc019}

  sleep, IntPhoneMenuDelay2

  Send {Right 5}
  Sleep IntPhoneMenuDelay2 * 2
  Send {Enter}
  Sleep IntPhoneMenuDelay2
  Send {Down 5}
  Sleep IntPhoneMenuDelay2
  Send {Enter}
  Sleep IntPhoneMenuDelay2 * 2
  Send {Down 5}
  Sleep IntPhoneMenuDelay2
  Send {Enter}
  Sleep IntPhoneMenuDelay2
  Send {sc019}
  return



; Режим AFK (ходить вправо-влево)
ToggleAFK:
  IsAFKActivated := !IsAFKActivated
  if (IsAFKActivated) {
    SplashTextOn 250, 20, AFK mode, ВКЛЮЧЕН режим AFK 
  } else {
    SplashTextOn 250, 20, AFK mode, режим AFK выключен
  }
  Sleep 2000
  SplashTextOff
  bringGameIntoFocus()
  Sleep 100

  if (IsAFKActivated) {
    Loop {
      sleep, 800
      send, {a}

      if (!IsAFKActivated) {
        break
      }

      sleep, 800
      send, {d}

      if (!IsAFKActivated) {
        break
      }
    }
  }
  return


; звонки из списка
DialDialog:
  pbl := ""
  For each, item in ArrayPhonebook
    pbl .= (!pbl ? "" : "|") item
  Gui, DIAL:add, Text, , двойной клик
  Gui, DIAL:Font,, Courier New
  Gui, DIAL:add, ListBox, w500 h250 vPhoneNumberSelect g_DialDialogMakeCallFromSelect, %pbl%
  Gui, DIAL:Font,, Arial
  Gui, DIAL:add, Text, , ввести вручную:
  Gui, DIAL:add, Edit, w500 vPhoneNumber,
  Gui, DIAL:add, Button, w500 Default g_DialDialogMakeCall, позвонить...
  Gui, DIAL:show
  return

DIALGuiEscape:
  Gui, DIAL:cancel
  Gui, DIAL:destroy
  bringGameIntoFocus()
  return

DIALGuiClose:
  Gui, DIAL:cancel
  Gui, DIAL:destroy
  bringGameIntoFocus()
  return

_DialDialogMakeCallFromSelect:
  if(A_GuiEvent = "DoubleClick")
    GoTo _DialDialogMakeCall
  Return

_DialDialogMakeCall:
  Gui, DIAL:submit
  bringGameIntoFocus(true)
  if PhoneNumber
    dialNumber(PhoneNumber, true)
  else if PhoneNumberSelect
    dialNumber(PhoneNumberSelect, true)
  Gui, DIAL:destroy
  return


; Включить кликер
ToggleClicker:
  IsClickerActivated := !IsClickerActivated
  if (IsClickerActivated) {
    SoundPlay, %A_WinDir%\Media\Windows Battery Critical.wav
  } else {
    SoundPlay, %A_WinDir%\Media\Windows Balloon.wav
  }
  bringGameIntoFocus()
  Sleep 10

  if (IsClickerActivated) {
    Loop {
      Click
      Sleep 10

      if (!IsClickerActivated) {
        break
      }
    }
  }
  return



LANdisconnect:
  if (DoLANdisconnect) {
    MsgBox, 1, , Отключить интернет?, 30
    IfMsgBox, Cancel
      Return
    IfMsgBox, Timeout
      Return
  }
  Run, lan-off.bat ,,Hide
  return

LANconnect:
  if (DoLANdisconnect) {
    MsgBox, 1, , Включить интернет?, 30
    IfMsgBox, Cancel
      Return
    IfMsgBox, Timeout
      Return
  }
  Run, lan-on.bat ,,Hide
  return


;--------------------------------------------------------------------------------------------------------------------


; Напомнить действующие кнопки (Выводит картинку на экран). Активация - намапад *


~NumpadMult::
Gui, 2:Margin , 0, 0
GUI, 2:+AlwaysOnTop -Border -SysMenu +Owner -Caption +ToolWindow
GUI, 2: Add, Picture, , GTA_Macros_files\useful_splash.gif
GUI, 2: Show, Center NoActivate autosize , dropDesk
KeyWait, NumpadMult
Gui,2:destroy
return

