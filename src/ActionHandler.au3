_Setup()
_OpenDatabase()

_CreateQuillEditorHtmlFile()

Global $aListOfTags        = _GetListOfTags()
Global $sPipeSeparatedTags = _BuildPipeSeparatedTagString($aListOfTags)

_CreateGuiStructure()
_LoadTagDropdown($sPipeSeparatedTags)
_LoadQuillEditor()
_MinimizeGui()

HotKeySet('^1', '_ShowGui')
HotKeySet('^2', '_CopyAnswerToClipboard')
HotKeySet('^3', '_ReloadTagList')

GUIRegisterMsg($WM_COMMAND, '_WatchDropdownInput_WindowsMessage')

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

        Case $cReloadButton
            _ReloadTagList()

        Case $cCopyButton
            _CopyAnswerToClipboard()

        Case $cOpenConfigButton
            _OpenConfigFile()

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
