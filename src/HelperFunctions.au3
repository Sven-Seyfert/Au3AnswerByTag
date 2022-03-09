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

Func _GetFileContent($sFile)
    Local Const $iUtf8WithoutBomMode = 256

    Local $hFile        = FileOpen($sFile, $iUtf8WithoutBomMode)
    Local $sFileContent = FileRead($hFile)
    FileClose($hFile)

    Return $sFileContent
EndFunc

Func _DeleteArrayElement($aList, $iIndex)
    _ArrayDelete($aList, $iIndex)

    Return $aList
EndFunc

Func _ClickListOfTagsDropdown()
    _BringGuiToFront()

    Send('{RIGHT}')
    Sleep(100)

    MouseClick('left', 178, 78, 1, 0)
EndFunc

Func _CopyAction()
    _BringGuiToFront()
    _AddWithKindRegardsToAnswer()

    MouseClick('left', 20, 282, 1, 0)
    Sleep(100)

    Send('^a')
    Sleep(100)

    Send('^c')
    Sleep(100)
EndFunc

Func _AddWithKindRegardsToAnswer()
    Local Const $iNotCaseSensitive          = 2
    Local Const $iReplaceOnlyFirstOccurence = 0

    Local $sSearch  = '</div><div tabindex="'
    Local $sReplace = StringReplace(_GetFileContent($sSignatureFilePath), '$(Name)', $sWithKindRegardsOf) & $sSearch

    _ReplaceStringInFile($sQuillEditorFilePath, $sSearch, $sReplace, $iNotCaseSensitive, $iReplaceOnlyFirstOccurence)
    _LoadQuillEditor()
EndFunc

Func _BringGuiToFront()
    WinActivate($aGui[$eHandle])
    Sleep(100)
EndFunc

Func _GoBackToPreviousWindow()
    WinActivate($hLastActiveWindow)
    Sleep(200)

    Local $iXPosition = $aMousePosition[0]
    Local $iYPosition = $aMousePosition[1]

    MouseMove($iXPosition, $iYPosition, 0)
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

Func _ShouldMessageBoxBeDisplayed()
    Return (StringLower($sMessageBoxBeforeSaveOrUpdate) == 'y') ? True : False
EndFunc

Func _ShouldProgramBeMinimizedAfterCopyAction()
    Return (StringLower($sMinimizeProgramAfterCopyAction) == 'y') ? True : False
EndFunc

Func _OpenConfigFile()
    If Not $bWasConfigFileAlreadyOpened Then
        $bWasConfigFileAlreadyOpened = True

        Local Const $iWarningIcon = 48
        MsgBox($iWarningIcon, 'Hint', _
            'Please notice, in case you change a value in the "config.ini" file, your have to restart to program afterwards. ' & _
            'Only then you changes will be active.' )
    EndIf

    Run('notepad.exe ' & $sConfigFilePath)
EndFunc
