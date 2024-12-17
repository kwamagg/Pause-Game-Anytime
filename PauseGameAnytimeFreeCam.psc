; You need to rename the file name to "PauseGameAnytime"
Scriptname PauseGameAnytime extends Quest

Bool isPaused = False
String iniPath = "Data/PauseGameAnytime_Settings.ini"
Int PauseHotkey = 12
Float CameraSpeed = 1.0
Int CameraState = 0

Event OnInit()
	PauseHotkey = PapyrusIniManipulator.PullIntFromIni(iniPath, "Hotkeys", "PauseHotkey", PauseHotkey)
	CameraSpeed = PapyrusIniManipulator.PullFloatFromIni(iniPath, "Settings", "CameraSpeed", CameraSpeed)
	RegisterForKey(PauseHotkey)
EndEvent

Event OnPlayerLoadGame()
	PauseHotkey = PapyrusIniManipulator.PullIntFromIni(iniPath, "Hotkeys", "PauseHotkey", PauseHotkey)
	CameraSpeed = PapyrusIniManipulator.PullFloatFromIni(iniPath, "Settings", "CameraSpeed", CameraSpeed)
	RegisterForKey(PauseHotkey)
EndEvent

Event OnKeyDown(Int keyCode)
	CameraState = Game.GetCameraState()
	If keyCode == PauseHotkey
		if !isPaused
			If CameraState == 0
				ConsoleUtil.ExecuteCommand("sgtm 0")
				ConsoleUtil.ExecuteCommand("disableplayercontrols 1 1 1 1")
				isPaused = True		
			Else
				ConsoleUtil.ExecuteCommand("tfc 1")
				ConsoleUtil.ExecuteCommand("sucsm " + CameraSpeed)
				isPaused = True
			EndIf
		Else 
			If CameraState == 0
				ConsoleUtil.ExecuteCommand("sgtm 1")
				ConsoleUtil.ExecuteCommand("enableplayercontrols")
				isPaused = False
			Else
				ConsoleUtil.ExecuteCommand("tfc 1")
				isPaused = False
			EndIf
		EndIf
	EndIf
EndEvent
