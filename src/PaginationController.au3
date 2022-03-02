Func _SetPagination($aListOfAnswers)
    If _IsInitDropdownText() Then
        Return
    EndIf

    $iMinAnswerIndex = 0
    $iMaxAnswerIndex = _GetCount($aListOfAnswers)

    If $iMinAnswerIndex < $iMaxAnswerIndex Then
        _EnableControl($cNextAnswerButton)
    Else
        _DisableControl($cPreviousAnswerButton)
        _DisableControl($cNextAnswerButton)
    EndIf

    _SetPaginationLabel($iMinAnswerIndex, $iMaxAnswerIndex)
EndFunc

Func _IsInitDropdownText()
    If GUICtrlRead($cTagDropdown) <> $sInitDropdownText Then
        Return False
    EndIf

    _ResetToEmptyQuillEditor()
    _SetGuiControlsDefaultState()
    _DisableCurrentAnswerArea()

    Return True
EndFunc

Func _LoadPreviousAnswer($aListOfAnswers)
    $iMinAnswerIndex -= 1

    If $iMinAnswerIndex == 0 Then
        _DisableControl($cPreviousAnswerButton)
        _EnableControl($cNextAnswerButton)
    EndIf

    _LoadAnswer($aListOfAnswers, $iMinAnswerIndex)
    _SetPaginationLabel($iMinAnswerIndex, $iMaxAnswerIndex)
EndFunc

Func _LoadNextAnswer($aListOfAnswers)
    $iMinAnswerIndex += 1

    If $iMinAnswerIndex == $iMaxAnswerIndex Then
        _DisableControl($cNextAnswerButton)
        _EnableControl($cPreviousAnswerButton)
    EndIf

    _LoadAnswer($aListOfAnswers, $iMinAnswerIndex)
    _SetPaginationLabel($iMinAnswerIndex, $iMaxAnswerIndex)
EndFunc
