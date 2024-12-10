Scriptname PauseGameAnytime extends Quest

String iniPath = "Data/PauseGameAnytime_Settings.ini"
Int PauseHotkey = 12

Event OnInit()
	PauseHotkey = PapyrusIniManipulator.PullIntFromIni(iniPath, "Hotkeys", "PauseHotkey", PauseHotkey)
	RegisterForKey(PauseHotkey)
EndEvent

Event OnPlayerLoadGame()
	PauseHotkey = PapyrusIniManipulator.PullIntFromIni(iniPath, "Hotkeys", "PauseHotkey", PauseHotkey)
	RegisterForKey(PauseHotkey)
EndEvent

Event OnKeyDown(Int keyCode)
	If keyCode == PauseHotkey
		ConsoleUtil.ExecuteCommand("tfc 1")
	EndIf
EndEvent
