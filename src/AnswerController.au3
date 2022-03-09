
Func _CreateQuillEditorHtmlFile($sAnswerContent = '')
    Local $sHtml = _
        '<!DOCTYPE html>' & @CRLF & _
        '<html lang="en">' & @CRLF & _
        '  <head>' & @CRLF & _
        '    <meta charset="UTF-8" />' & @CRLF & _
        '    <meta http-equiv="X-UA-Compatible" content="IE=edge" />' & @CRLF & _
        '    <meta name="viewport" content="width=device-width, initial-scale=1.0" />' & @CRLF & _
        '    <title>Au3AnswerByTag</title>' & @CRLF & _
        '    <link href="https://cdn.quilljs.com/1.3.7/quill.snow.css" rel="stylesheet" />' & @CRLF & _
        '  </head>' & @CRLF & _
        '  <body>' & @CRLF & _
        '    <div id="editor" style="min-height: ' & $iQuillEditorHeight - 60 & 'px;">' & @CRLF & _
        '      ' & $sAnswerContent & @CRLF & _
        '    </div>' & @CRLF & _
        '    <script src="https://cdn.quilljs.com/1.3.7/quill.js"></script>' & @CRLF & _
        '    <script>' & @CRLF & _
        '      var Block = Quill.import(''blots/block'');' & @CRLF & _
        '      Block.tagName = ''DIV'';' & @CRLF & _
        '      Quill.register(Block, true);' & @CRLF & _
        '      var toolbarOptions = [' & @CRLF & _
        '        ["bold", "italic", "underline", "strike"],' & @CRLF & _
        '        [{ color: [] }, { background: [] }],' & @CRLF & _
        '        ["link", "blockquote", "code-block"],' & @CRLF & _
        '        [{ list: "ordered" }, { list: "bullet" }],' & @CRLF & _
        '        [{ indent: "-1" }, { indent: "+1" }],' & @CRLF & _
        '        [{ align: [] }],' & @CRLF & _
        '        [{ header: [1, 2, 3, 4, 5, 6, false] }],' & @CRLF & _
        '        [{ script: "sub" }, { script: "super" }],' & @CRLF & _
        '        ["clean"]' & @CRLF & _
        '      ];' & @CRLF & _
        '      var quill = new Quill("#editor", {' & @CRLF & _
        '        modules: {' & @CRLF & _
        '          toolbar: toolbarOptions,' & @CRLF & _
        '        },' & @CRLF & _
        '        theme: "snow",' & @CRLF & _
        '      });' & @CRLF & _
        '    </script>' & @CRLF & _
        '  </body>' & @CRLF & _
        '</html>' & @CRLF

    _WriteFile($sQuillEditorFilePath, $sHtml)
EndFunc

Func _FillTagRelatedAnswerToQuillEditor()
    Local $aListOfAnswers = _GetListOfAnswers(GUICtrlRead($cTagDropdown))

    _LoadAnswer($aListOfAnswers, 0)

    Return $aListOfAnswers
EndFunc

Func _GetListOfAnswers($sTag)
    Local $aQuery         = "select * from answers where tag like '%" & $sTag & "%';"
    Local $aListOfAnswers = _QueryResultToArray($aQuery)

    If _GetCount($aListOfAnswers) < 1 Then
        Return False
    EndIf

    Return _DeleteArrayElement($aListOfAnswers, 0)
EndFunc

Func _LoadAnswer($aListOfAnswers, $iIndex)
    If Not IsArray($aListOfAnswers) Then
        Return
    EndIf

    _CreateQuillEditorHtmlFile($aListOfAnswers[$iIndex][2])
    _LoadQuillEditor()
    GUICtrlSetData($cCurrentTagInput, $aListOfAnswers[$iIndex][1])
EndFunc

Func _CopyAnswerToClipboard()
    Local Const $iActiveButton = 80
    If GUICtrlGetState($cCopyButton) <> $iActiveButton Then
        Return
    EndIf

    _CopyAction()
    _ClickListOfTagsDropdown()

    If Not _ShouldProgramBeMinimizedAfterCopyAction() Then
        Return
    EndIf

    _MinimizeGui()
    _GoBackToPreviousWindow()
EndFunc

Func _PrepareAddingNewAnswer()
    _ResetToEmptyQuillEditor()
    _SetGuiControlsDefaultState()
    _DisableCurrentAnswerArea()
    _EnableNewAnswerArea()
    _ShowFirstDropdownEntry()
EndFunc

Func _SaveNewAnswer()
    Local Const $iLeadingTrailingAndDoubleWhitespaces = 7
    Local $sTag = StringStripWS(GUICtrlRead($cNewTagInput), $iLeadingTrailingAndDoubleWhitespaces)

    If $sTag == '' Then
        Local Const $iWarningIcon = 48
        MsgBox($iWarningIcon, 'Warning', 'Please define a tag for the new answer. You can type multiple tags comma separated.')

        Return
    EndIf

    If _ShouldMessageBoxBeDisplayed() Then
        If Not _IsQuestionAnsweredByYes('Are you sure you want to add the new answer and persist to database?') Then
            Return
        EndIf
    EndIf

    Local $sAnswer = _IEGetObjById($oIE, "editor").innerHTML
    Local $sQuery  = "insert into answers (tag, answer) values ('" & StringLower($sTag) & "', '" & $sAnswer & "');"

    If Not _ExecuteQuery($sQuery) Then
        Return
    EndIf

    _ReloadTagList()
    _PrepareAddingNewAnswer()

    GUICtrlSetData($cNewTagInput, '')
EndFunc

Func _UpdateCurrentAnswer($aListOfAnswers)
    Local Const $iLeadingTrailingAndDoubleWhitespaces = 7
    Local $sTag = StringStripWS(GUICtrlRead($cCurrentTagInput), $iLeadingTrailingAndDoubleWhitespaces)

    If $sTag == '' Then
        Local Const $iWarningIcon = 48
        MsgBox($iWarningIcon, 'Warning', 'Please define a tag for the current answer. You can type multiple tags comma separated.')

        Return
    EndIf

    If _ShouldMessageBoxBeDisplayed() Then
        If Not _IsQuestionAnsweredByYes('Are you sure you want to update the current displayed answer and persist to database?') Then
            Return
        EndIf
    EndIf

    Local $sAnswer = _IEGetObjById($oIE, "editor").innerHTML
    Local $sQuery = "update answers set tag = '" & StringLower($sTag) & "', answer = '" & $sAnswer & "' where id = " & $aListOfAnswers[$iMinAnswerIndex][0] & ";"

    _ExecuteQuery($sQuery)
    _ReloadTagList()
EndFunc

Func _DeleteCurrentAnswer($aListOfAnswers)
    If Not _IsQuestionAnsweredByYes('Are you sure you want to delete the current displayed answer?') Then
        Return
    EndIf

    Local $sQuery = "delete from answers where id = " & $aListOfAnswers[$iMinAnswerIndex][0] & ";"

    _ExecuteQuery($sQuery)
    _ReloadTagList()
    _PrepareAddingNewAnswer()
EndFunc

Func _ReloadTagList()
    Local $aListOfTags        = _GetListOfTags()
    Local $sPipeSeparatedTags = _BuildPipeSeparatedTagString($aListOfTags)

    _LoadTagDropdown($sPipeSeparatedTags)
EndFunc
