_Setup()
_OpenDatabase()

_CreateQuillEditorHtmlFile()

Global $aListOfTags        = _GetListOfTags()
Global $sPipeSeparatedTags = _BuildPipeSeparatedTagString($aListOfTags)

_CreateGuiStructure()
_LoadTagDropdown($sPipeSeparatedTags)
_LoadQuillEditor()
_ShowGui()

HotKeySet('^{SPACE}', '_CopyAnswerToClipboard')

While True
    Switch GUIGetMsg()
        Case $iGuiEventClose
            ExitLoop

        Case $cTagDropdown
            _EnabelCurrentAnswerArea()
            _DisableNewAnswerArea()
            _EnableControl($cCopyButton)

            Global $aListOfAnswers = _FillTagRelatedAnswerToQuillEditor()

            _SetPagination($aListOfAnswers)

        Case $cCopyButton
            _CopyAnswerToClipboard()

        Case $cOpenConfigButton
            Run('notepad.exe ' & $sConfigFilePath)

        Case $cAddAnswerButton
            _PrepareAddingNewAnswer()

        Case $cSaveAnswerButton
            _SaveNewAnswer()

        Case $cUpdateAnswerButton
            _UpdateCurrentAnswer($aListOfAnswers)

        Case $cDeleteAnswerButton
            _DeleteCurrentAnswer($aListOfAnswers)

        Case $cPreviousAnswerButton
            _LoadPreviousAnswer($aListOfAnswers)

        Case $cNextAnswerButton
            _LoadNextAnswer($aListOfAnswers)
    EndSwitch
WEnd

_GuiDispose()
_TearDown()

Exit
