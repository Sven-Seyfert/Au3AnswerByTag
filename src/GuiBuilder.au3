Func _CreateGuiStructure()
    $aGui[$eHandle] = GUICreate('Au3AnswerByTag', $aGui[$eWidth], $aGui[$eHeight])
                      GUISetFont(11)

    _GroupForListOfTags()
    _GroupForConfiguration()
    _EmbeddIEObject()
    _GroupForNewAnswer()
    _GroupForCurrentAnswer()

    _SetGuiControlsDefaultState()
    _DisableCurrentAnswerArea()
EndFunc

Func _GroupForListOfTags()
    GUICtrlCreateGroup('🏷 Tags', $aGui[$eGap] - 7, $aGui[$eGap], $aGui[$eWidth] * 0.8, 70)

    $cTagDropdown = GUICtrlCreateCombo($sInitDropdownText, ($aGui[$eGap] * 1.5), ($aGui[$eGap] * 3) - 4, ($aGui[$eWidth] / 3) + 25)
    $cCopyButton  = GUICtrlCreateButton('⧉', ($aGui[$eGap] * 3.5) + ($aGui[$eWidth] / 3), ($aGui[$eGap] * 3) - 5, 26, 26)
                    GUICtrlSetTip(-1, 'Copy')

    _SetFocusToGuiControl($cTagDropdown)
    _AnswerPagination()
EndFunc

Func _AnswerPagination()
    GUICtrlCreateLabel('🗃*', ($aGui[$eGap] * 7) + ($aGui[$eWidth] / 3), ($aGui[$eGap] * 3))
    GUICtrlSetTip(-1, 'Answer count of chosen tag')

    $cPaginationLabel      = GUICtrlCreateLabel('0 of 0', ($aGui[$eGap] * 9.5) + ($aGui[$eWidth] / 3), ($aGui[$eGap] * 3), 55)
    $cPreviousAnswerButton = GUICtrlCreateButton('◀', ($aGui[$eGap] * 14) + ($aGui[$eWidth] / 3), ($aGui[$eGap] * 3) - 4, 25, 25)
    $cNextAnswerButton     = GUICtrlCreateButton('▶', ($aGui[$eGap] * 16) + ($aGui[$eWidth] / 3), ($aGui[$eGap] * 3) - 4, 25, 25)
EndFunc

Func _GroupForConfiguration()
    GUICtrlCreateGroup('⚙ Configuration', $aGui[$eWidth] * 0.8 + $aGui[$eGap], $aGui[$eGap], $aGui[$eWidth] * 0.2 - ($aGui[$eGap] * 2) + 7, 70)

    $cOpenConfigButton = GUICtrlCreateButton('📂', $aGui[$eWidth] * 0.8 + ($aGui[$eGap] * 1.5) + 7, ($aGui[$eGap] * 3) - 5, 25, 25)
                         GUICtrlSetTip(-1, 'Open config')
EndFunc

Func _EmbeddIEObject()
    $oIE = _IECreateEmbedded()
    GUICtrlCreateObj($oIE, 0, $aGui[$eGap] * 7, $aGui[$eWidth], $iQuillEditorHeight)

    $iControlBottomPosition = $aGui[$eGap] * 7 + $iQuillEditorHeight
EndFunc

Func _GroupForNewAnswer()
    GUICtrlCreateGroup('📝 New answer', $aGui[$eGap] - 7, $iControlBottomPosition + $aGui[$eGap], ($aGui[$eWidth] / 2) - $aGui[$eGap] + 3.5, 70)

    $cAddAnswerButton  = GUICtrlCreateButton('➕', ($aGui[$eGap] * 1.5), $iControlBottomPosition + ($aGui[$eGap] * 3) - 5, 25, 25)
                         GUICtrlSetTip(-1, 'Add')
    $cSaveAnswerButton = GUICtrlCreateButton('💾', ($aGui[$eGap] * 3.5), $iControlBottomPosition + ($aGui[$eGap] * 3) - 5, 25, 25)
                         GUICtrlSetTip(-1, 'Save')

    GUICtrlCreateLabel('🏷* Tag', ($aGui[$eGap] * 6.5), $iControlBottomPosition + ($aGui[$eGap] * 3), 60)
    GUICtrlSetTip(-1, 'Type tags separated by commas.')

    $cNewTagInput = GUICtrlCreateInput('', ($aGui[$eGap] * 10), $iControlBottomPosition + ($aGui[$eGap] * 3) - 4, ($aGui[$eWidth] / 3.2))
EndFunc

Func _GroupForCurrentAnswer()
    GUICtrlCreateGroup('✏ Current answer', ($aGui[$eWidth] / 2) + 3.5, $iControlBottomPosition + $aGui[$eGap], ($aGui[$eWidth] / 2) - $aGui[$eGap] + 3.5, 70)

    $cUpdateAnswerButton = GUICtrlCreateButton('💾', ($aGui[$eWidth] / 2) + 3.5 + $aGui[$eGap], $iControlBottomPosition + ($aGui[$eGap] * 3) - 5, 25, 25)
                           GUICtrlSetTip(-1, 'Update')
    $cDeleteAnswerButton = GUICtrlCreateButton('🗑', ($aGui[$eWidth] / 2) + 3.5 + ($aGui[$eGap] * 3), $iControlBottomPosition + ($aGui[$eGap] * 3) - 5, 25, 25)
                           GUICtrlSetTip(-1, 'Delete')

    GUICtrlCreateLabel('🏷* Tag', ($aGui[$eWidth] / 2) + 3.5 + ($aGui[$eGap] * 6), $iControlBottomPosition + ($aGui[$eGap] * 3), 60)
    GUICtrlSetTip(-1, 'Type tags separated by commas.')

    $cCurrentTagInput = GUICtrlCreateInput('', ($aGui[$eWidth] / 2) + 3.5 + ($aGui[$eGap] * 9.5), $iControlBottomPosition + ($aGui[$eGap] * 3) - 4, ($aGui[$eWidth] / 3.2))
EndFunc
