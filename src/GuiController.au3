Func _MinimizeGui()
    GUISetState(@SW_MINIMIZE, $aGui[$eHandle])
EndFunc

Func _ShowGui()
    $hLastActiveWindow = WinGetHandle('')
    $aMousePosition    = MouseGetPos()

    GUISetState(@SW_SHOW, $aGui[$eHandle])
    _ClickListOfTagsDropdown()
EndFunc

Func _LoadTagDropdown($sListOfTags)
    GUICtrlSetData($cTagDropdown, '')
    GUICtrlSetData($cTagDropdown, $sInitDropdownText & '|' & $sListOfTags)

    _ShowFirstDropdownEntry()
EndFunc

Func _ShowFirstDropdownEntry()
    GUICtrlSetData($cTagDropdown, $sInitDropdownText)
EndFunc

Func _SetPaginationLabel($iMin, $iMax)
    GUICtrlSetData($cPaginationLabel, $iMin + 1 & ' of ' & $iMax + 1)
EndFunc

Func _LoadQuillEditor()
    _IENavigate($oIE, _RelativeToAbsolutePath($sQuillEditorFilePath))
EndFunc

Func _GuiDispose()
    GUIDelete($aGui[$eHandle])
EndFunc

Func _ResetToEmptyQuillEditor()
    GUICtrlSetData($cPaginationLabel, '0 of 0')
    GUICtrlSetData($cCurrentTagInput, '')

    _CreateQuillEditorHtmlFile()
    _LoadQuillEditor()
EndFunc

Func _SetGuiControlsDefaultState()
    _DisableControl($cPreviousAnswerButton)
    _DisableControl($cNextAnswerButton)
    _DisableControl($cCopyButton)
EndFunc

Func _DisableCurrentAnswerArea()
    _DisableControl($cUpdateAnswerButton)
    _DisableControl($cDeleteAnswerButton)
    _DisableControl($cCurrentTagInput)
EndFunc

Func _EnabelCurrentAnswerArea()
    _EnableControl($cUpdateAnswerButton)
    _EnableControl($cDeleteAnswerButton)
    _EnableControl($cCurrentTagInput)
EndFunc

Func _DisableNewAnswerArea()
    _DisableControl($cSaveAnswerButton)
    _DisableControl($cNewTagInput)
EndFunc

Func _EnableNewAnswerArea()
    _EnableControl($cSaveAnswerButton)
    _EnableControl($cNewTagInput)
EndFunc

Func _DisableControl($cControl)
    Local Const $iDisable = 128
    GUICtrlSetState($cControl, $iDisable)
EndFunc

Func _EnableControl($cControl)
    Local Const $iEnable = 64
    GUICtrlSetState($cControl, $iEnable)
EndFunc

Func _WatchDropdownInput_WindowsMessage($hWnd, $iMsg, $wParam, $lParam)
    Local $cControl = _WinAPI_LoWord($wParam)
    Local $iCode    = _WinAPI_HiWord($wParam)

    If $cControl <> $cTagDropdown Then
        Return
    EndIf

    If $iCode <> $CBN_EDITCHANGE Then
        Return
    EndIf

    _GUICtrlComboBox_AutoComplete($cTagDropdown)
EndFunc
