; Battery notification
;
; When the battery is charged, a notification
; will appear to tell the user to remove the charger
;
; When the battery is below 30%, a notification
; will appear to tell the user to plug in the charger

; run script as admin (reload if not as admin) 
;if not A_IsAdmin
;{
   ;Run *RunAs "%A_AhkPath%" "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ;ExitApp
;}

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force
SetTitleMatchMode 2

; set desired low battery percentage to get alert
lowBatteryPercentage := 30
;

sleepTime := 60
chargedPercentage := 44
percentage := "%"

Loop
{ ;Loop forever

;Grab the current data.
VarSetCapacity(powerstatus, 1+1+1+1+4+4)
success := DllCall("kernel32.dll\GetSystemPowerStatus", "uint", &powerstatus)

acLineStatus:=ReadInteger(&powerstatus,0)
batteryLifePercent:=ReadInteger(&powerstatus,2)

;Is the battery charged higher than 99%
if (batteryLifePercent > chargedPercentage){ ;Yes. 

	if (acLineStatus == 1){ ;Only notify me once
		if (batteryLifePercent == 255){
			sleepTime := 60
			}
		else{
                        
                        SoundBeep, 750, 200
                        sleep 10
                        SoundBeep, 750, 200
                        sleep 30
			MsgBox, 1, ,Please remove charger Battery at %batteryLifePercent%`%
                        winset, AlwaysOnTop, on, warning
                        IfMsgBox, OK
                            sleep 300000
                        else IfMsgBox, Cancel
                                 sleep 3600000
                        
		}
	}
	else{
		sleepTime := 60
	}
}