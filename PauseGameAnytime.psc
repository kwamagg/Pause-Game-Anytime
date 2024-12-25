Scriptname PauseGameAnytime extends ReferenceAlias

Actor Property PGA_Player Auto
GlobalVariable Property PGA_Hotkey Auto
GlobalVariable Property PGA_CameraSpeed Auto
GlobalVariable Property PGA_FreeCamEnabled Auto
GlobalVariable Property PGA_PauseOnLoadEnabled Auto
GlobalVariable Property PGA_Waiting Auto

Bool isPaused = False
Bool pausedInFreeCam = False
Int CameraState = 0

Event OnInit()
	UnregisterForAllKeys()
	RegisterForKey(PGA_Hotkey.GetValueInt())
EndEvent

Event OnPlayerLoadGame()
	If PGA_PauseOnLoadEnabled.GetValue() == 1.0
		ConsoleUtil.ExecuteCommand("sgtm 0")
		Utility.Wait(PGA_Waiting.GetValue())
		ConsoleUtil.ExecuteCommand("sgtm 1")
	EndIf
	UnregisterForAllKeys()
	RegisterForKey(PGA_Hotkey.GetValueInt())
EndEvent

Event OnKeyDown(Int keyCode)
	CameraState = Game.GetCameraState()
	If keyCode == PGA_Hotkey.GetValueInt()
		if !isPaused
			If CameraState == 0 || (PGA_FreeCamEnabled.GetValue() == 0.0)
				ConsoleUtil.ExecuteCommand("sgtm 0")
				ConsoleUtil.ExecuteCommand("disableplayercontrols 1 1 1 1")
				pausedInFreeCam = False
				isPaused = True		
			ElseIf PGA_FreeCamEnabled.GetValue() == 1.0
				ConsoleUtil.ExecuteCommand("tfc 1")
				ConsoleUtil.ExecuteCommand("sucsm " + PGA_CameraSpeed.GetValue())
				pausedInFreeCam = True
				isPaused = True
			EndIf
		Else 
			If pausedInFreeCam
				ConsoleUtil.ExecuteCommand("tfc 1")
				pausedInFreeCam = False
				isPaused = False
			Else
				ConsoleUtil.ExecuteCommand("sgtm 1")
				ConsoleUtil.ExecuteCommand("enableplayercontrols")
				isPaused = False
			EndIf
		EndIf
	EndIf
EndEvent
