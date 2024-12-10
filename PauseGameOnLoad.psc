Scriptname PauseGameOnLoad extends ReferenceAlias

String iniPath = "Data/PauseGameOnLoad_Settings.ini"
Float Waiting = 1.0

Event OnInit()
	Waiting = PapyrusIniManipulator.PullFloatFromIni(iniPath, "Settings", "Waiting", Waiting)
EndEvent

Event OnPlayerLoadGame()
	ConsoleUtil.ExecuteCommand("sgtm 0")
	Waiting = PapyrusIniManipulator.PullFloatFromIni(iniPath, "Settings", "Waiting", Waiting)
	Utility.Wait(Waiting)
	ConsoleUtil.ExecuteCommand("sgtm 1")
EndEvent
