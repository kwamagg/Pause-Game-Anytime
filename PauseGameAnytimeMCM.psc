Scriptname PauseGameAnytimeMCM extends MCM_ConfigBase

Quest Property PauseGameAnytimeQuest Auto
GlobalVariable Property PGA_Hotkey Auto
GlobalVariable Property PGA_CameraSpeed Auto
GlobalVariable Property PGA_FreeCamEnabled Auto
GlobalVariable Property PGA_PauseOnLoadEnabled Auto
GlobalVariable Property PGA_Waiting Auto

Bool migrated = False

Int Function GetVersion()
    return 1
EndFunction

Event OnUpdate()
    parent.OnUpdate()
    If !migrated
        MigrateToMCMHelper()
        migrated = True
    EndIf
EndEvent

Event OnGameReload()
    parent.OnGameReload()
    If !migrated
        MigrateToMCMHelper()
        migrated = True
    EndIf
    If GetModSettingBool("bLoadSettingsonReload:Maintenance")
        LoadSettings()
    EndIf
EndEvent

Event OnConfigOpen()
    parent.OnConfigOpen()
    If !migrated
        MigrateToMCMHelper()
        migrated = True
    EndIf
EndEvent

Event OnConfigInit()
    parent.OnConfigInit()
    migrated = True
    LoadSettings()
EndEvent

Event OnSettingChange(String a_ID)
    parent.OnSettingChange(a_ID)
    If a_ID == "iHotkey:General"
        PGA_Hotkey.SetValue(GetModSettingInt("iHotkey:General") as Float)
        (PauseGameAnytimeQuest.GetAlias(0) as ReferenceAlias).OnPlayerLoadGame()
        RefreshMenu()
    ElseIf a_ID == "bPauseOnLoadEnabled:General"
        PGA_PauseOnLoadEnabled.SetValue(GetModSettingBool("bPauseOnLoadEnabled:General") as Float)
        (PauseGameAnytimeQuest.GetAlias(0) as ReferenceAlias).OnPlayerLoadGame()
        RefreshMenu()
    ElseIf a_ID == "fWaiting:General"
        PGA_Waiting.SetValue(GetModSettingFloat("fWaiting:General") as Float)
        (PauseGameAnytimeQuest.GetAlias(0) as ReferenceAlias).OnPlayerLoadGame()
        RefreshMenu()
    ElseIf a_ID == "bEnableFreeCam:General"
        PGA_FreeCamEnabled.SetValue(GetModSettingBool("bEnableFreeCam:General") as Float)
        (PauseGameAnytimeQuest.GetAlias(0) as ReferenceAlias).OnPlayerLoadGame()
        RefreshMenu()
    ElseIf a_ID == "fCameraSpeed:General"
        PGA_CameraSpeed.SetValue(GetModSettingFloat("fCameraSpeed:General") as Float)
        (PauseGameAnytimeQuest.GetAlias(0) as ReferenceAlias).OnPlayerLoadGame()
        RefreshMenu()
    EndIf
EndEvent

Event OnPageSelect(String a_page)
    parent.OnPageSelect(a_page)
EndEvent

Function Default()
    SetModSettingInt("iHotkey:General", 34)
    SetModSettingBool("bPauseOnLoadEnabled:General", True)
    SetModSettingFloat("fWaiting:General", 1.0)
    SetModSettingBool("bEnableFreeCam:General", True)
    SetModSettingFloat("fCameraSpeed:General", 1.0)
    SetModSettingBool("bEnabled:Maintenance", True)
    SetModSettingInt("iLoadingDelay:Maintenance", 0)
    SetModSettingBool("bLoadSettingsonReload:Maintenance", False)
    Load()
EndFunction

Function Load()
    PGA_Hotkey.SetValue(GetModSettingInt("iHotkey:General") as Float)
    PGA_PauseOnLoadEnabled.SetValue(GetModSettingBool("bPauseOnLoadEnabled:General") as Float)
    PGA_Waiting.SetValue(GetModSettingFloat("fWaiting:General") as Float)
    PGA_FreeCamEnabled.SetValue(GetModSettingBool("bEnableFreeCam:General") as Float)
    PGA_CameraSpeed.SetValue(GetModSettingFloat("fCameraSpeed:General") as Float)
    (PauseGameAnytimeQuest.GetAlias(0) as ReferenceAlias).OnPlayerLoadGame()
EndFunction

Function LoadSettings()
    If GetModSettingBool("bEnabled:Maintenance") == False
        Return
    EndIf
    Utility.Wait(GetModSettingInt("iLoadingDelay:Maintenance"))
    Load()
EndFunction

Function MigrateToMCMHelper()
    SetModSettingInt("iHotkey:General", PGA_Hotkey.GetValue() as Int)
    SetModSettingBool("bPauseOnLoadEnabled:General", PGA_PauseOnLoadEnabled.GetValue() as Bool)
    SetModSettingFloat("fWaiting:General", PGA_Waiting.GetValue() as Float)
    SetModSettingBool("bEnableFreeCam:General", PGA_FreeCamEnabled.GetValue() as Bool)
    SetModSettingFloat("fCameraSpeed:General", PGA_CameraSpeed.GetValue() as Float)
EndFunction
