Func _CreateGuiStructure()
    $aGui[$eHandle] = GUICreate('Au3AnswerByTag', $aGui[$eWidth], $aGui[$eHeight])
                      GUISetFont(11)
                      GUISetBkColor(0xFFFFFF, $aGui[$eHandle])

    _GroupForListOfTags()
    _GroupForConfiguration()
    _GroupForNewAnswer()
    _GroupForCurrentAnswer()
    _EmbeddIEObject()

    _SetGuiControlsDefaultState()
    _DisableCurrentAnswerArea()
EndFunc

Func _GroupForListOfTags()
    GUICtrlCreateGroup('🏷 Tags', $aGui[$eGap] - 7, $aGui[$eGap], $aGui[$eWidth] * 0.8, $iHeightOfGuiGroup)

    $cTagDropdown  = GUICtrlCreateCombo($sInitDropdownText, ($aGui[$eGap] * 1.5), ($aGui[$eGap] * 3) - 4, ($aGui[$eWidth] / 3) + 25)
    $cReloadButton = GUICtrlCreateButton('⟳', ($aGui[$eGap] * 3.5) + ($aGui[$eWidth] / 3), ($aGui[$eGap] * 3) - 5, 26, 26)
                     GUICtrlSetFont(-1, 14)
                     GUICtrlSetTip(-1, 'Reload list of tags')
    $cCopyButton   = GUICtrlCreateButton('⧉', ($aGui[$eGap] * 5.5) + ($aGui[$eWidth] / 3), ($aGui[$eGap] * 3) - 5, 26, 26)
                     GUICtrlSetTip(-1, 'Copy')

    _AnswerPagination()
EndFunc

Func _AnswerPagination()
    GUICtrlCreateLabel('🗃*', ($aGui[$eGap] * 9) + ($aGui[$eWidth] / 3), ($aGui[$eGap] * 3))
    GUICtrlSetTip(-1, 'Answer count of chosen tag')

    $cPaginationLabel      = GUICtrlCreateLabel('0 of 0', ($aGui[$eGap] * 11.5) + ($aGui[$eWidth] / 3), ($aGui[$eGap] * 3), 55)
    $cPreviousAnswerButton = GUICtrlCreateButton('◀', ($aGui[$eGap] * 16) + ($aGui[$eWidth] / 3), ($aGui[$eGap] * 3) - 4, 25, 25)
    $cNextAnswerButton     = GUICtrlCreateButton('▶', ($aGui[$eGap] * 18) + ($aGui[$eWidth] / 3), ($aGui[$eGap] * 3) - 4, 25, 25)
EndFunc

Func _GroupForConfiguration()
    GUICtrlCreateGroup('⚙ Configuration', $aGui[$eWidth] * 0.8 + $aGui[$eGap], $aGui[$eGap], $aGui[$eWidth] * 0.2 - ($aGui[$eGap] * 2) + 7, $iHeightOfGuiGroup)

    $cOpenConfigButton = GUICtrlCreateButton('📂', $aGui[$eWidth] * 0.8 + ($aGui[$eGap] * 1.5) + 7, ($aGui[$eGap] * 3) - 5, 25, 25)
                         GUICtrlSetTip(-1, 'Open config')
EndFunc

Func _GroupForNewAnswer()
    GUICtrlCreateGroup('📝 New answer', $aGui[$eGap] - 7, $iControlBottomPosition + $aGui[$eGap], ($aGui[$eWidth] / 2) - $aGui[$eGap] + 3.5, $iHeightOfGuiGroup)

    $cAddAnswerButton  = GUICtrlCreateButton('➕', ($aGui[$eGap] * 1.5), $iControlBottomPosition + ($aGui[$eGap] * 3) - 5, 25, 25)
                         GUICtrlSetTip(-1, 'Add')
    $cSaveAnswerButton = GUICtrlCreateButton('💾', ($aGui[$eGap] * 3.5), $iControlBottomPosition + ($aGui[$eGap] * 3) - 5, 25, 25)
                         GUICtrlSetTip(-1, 'Save')

    GUICtrlCreateLabel('🏷* Tag', ($aGui[$eGap] * 6.5), $iControlBottomPosition + ($aGui[$eGap] * 3), 60)
    GUICtrlSetTip(-1, 'Type tags separated by commas.')

    $cNewTagInput = GUICtrlCreateInput('', ($aGui[$eGap] * 10), $iControlBottomPosition + ($aGui[$eGap] * 3) - 4, ($aGui[$eWidth] / 3.2))
EndFunc

Func _GroupForCurrentAnswer()
    GUICtrlCreateGroup('✏ Current answer', ($aGui[$eWidth] / 2) + 3.5, $iControlBottomPosition + $aGui[$eGap], ($aGui[$eWidth] / 2) - $aGui[$eGap] + 3.5, $iHeightOfGuiGroup)

    $cUpdateAnswerButton = GUICtrlCreateButton('💾', ($aGui[$eWidth] / 2) + 3.5 + $aGui[$eGap], $iControlBottomPosition + ($aGui[$eGap] * 3) - 5, 25, 25)
                           GUICtrlSetTip(-1, 'Update')
    $cDeleteAnswerButton = GUICtrlCreateButton('🗑', ($aGui[$eWidth] / 2) + 3.5 + ($aGui[$eGap] * 3), $iControlBottomPosition + ($aGui[$eGap] * 3) - 5, 25, 25)
                           GUICtrlSetTip(-1, 'Delete')

    GUICtrlCreateLabel('🏷* Tag', ($aGui[$eWidth] / 2) + 3.5 + ($aGui[$eGap] * 6), $iControlBottomPosition + ($aGui[$eGap] * 3), 60)
    GUICtrlSetTip(-1, 'Type tags separated by commas.')

    $cCurrentTagInput = GUICtrlCreateInput('', ($aGui[$eWidth] / 2) + 3.5 + ($aGui[$eGap] * 9.5), $iControlBottomPosition + ($aGui[$eGap] * 3) - 4, ($aGui[$eWidth] / 3.2))
EndFunc

Func _EmbeddIEObject()
    $oIE = _IECreateEmbedded()
    GUICtrlCreateObj($oIE, 0, ($iHeightOfGuiGroup * 2) + ($aGui[$eGap] * 3), $aGui[$eWidth], $iQuillEditorHeight)
EndFunc
