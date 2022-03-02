Func _RelativeToAbsolutePath($sRelativePath)
    Local $aPathHierarchy = StringRegExp($sRelativePath, '(.+?)\\', 3)
    Local $iRelativeCount = 0
    Local $iCount         = _GetCount($aPathHierarchy)

    For $i = 0 To $iCount Step 1
        If $aPathHierarchy[$i] == '..' Then
            $iRelativeCount += 1
        EndIf
    Next

    If $iRelativeCount < 0 Then
        Return $sRelativePath
    EndIf

    Local $sNewPath = StringReverse(@ScriptDir)

    $sNewPath = StringRegExpReplace($sNewPath, '(.+?)\\', '', $iRelativeCount)
    $sNewPath = StringReverse($sNewPath) & '\'

    Local $sRelativePart = _StringRepeat('..\', $iRelativeCount)

    Return StringReplace($sRelativePath, $sRelativePart, $sNewPath)
EndFunc

Func _GetCount($aList)
    Return UBound($aList) - 1
EndFunc

Func _WriteFile($sFile, $sText)
    Local Const $iUtf8WithoutBomAndOverwriteCreationMode = 256 + 2 + 8

    Local $hFile = FileOpen($sFile, $iUtf8WithoutBomAndOverwriteCreationMode)
    FileWrite($hFile, $sText)
    FileClose($hFile)
EndFunc

Func _DeleteArrayElement($aList, $iIndex)
    _ArrayDelete($aList, $iIndex)

    Return $aList
EndFunc

Func _SetFocusToGuiControl($cControl)
    Local Const $iControlFocus = 256
    GUICtrlSetState($cControl, $iControlFocus)
EndFunc

Func _IsQuestionAnsweredByYes($sQuestion)
    Local Const $iQuestionMarkIcon = 32
    Local Const $iYesNoButtons     = 4
    Local Const $iNo               = 7
    Local $iTypeOfMessageBox       = $iQuestionMarkIcon + $iYesNoButtons

    If MsgBox($iTypeOfMessageBox, 'Question', $sQuestion) == $iNo Then
        Return False
    EndIf

    Return True
EndFunc
