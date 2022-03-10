Global $sConfigFilePath                 = '..\config\config.ini'
Global $sSqliteDll                      = '..\data\sqlite3_x64.dll'
Global $sQuillEditorFilePath            = '..\data\quilljs.html'
Global $sSignatureFilePath              = '..\data\signature.html'
Global $sDatabaseFilePath               = IniRead($sConfigFilePath, 'Settings', 'DatabaseFilePath', '..\data\Au3AnswerByTag.db')
Global $sWithKindRegardsOf              = IniRead($sConfigFilePath, 'Settings', 'WithKindRegardsOf', '<NAME>')
Global $sMessageBoxBeforeSaveOrUpdate   = IniRead($sConfigFilePath, 'Settings', 'MessageBoxBeforeSaveOrUpdate', 'y')
Global $sMinimizeProgramAfterCopyAction = IniRead($sConfigFilePath, 'Settings', 'MinimizeProgramAfterCopyAction', 'n')
Global $hDatabase

Global $hOutlookWindow, $aMousePosition
Global $sClassOfOutlookWindow = '[CLASS:rctrl_renwnd32]'

Global Const $iGuiEventClose = -3
Global $sInitDropdownText    = 'List of tags'

Global $aGui[$iMaxEnumIndex]
       $aGui[$eHandle] = Null
       $aGui[$eWidth]  = Int(IniRead($sConfigFilePath, 'Settings', 'GuiWidth', 900))
       $aGui[$eHeight] = Int(IniRead($sConfigFilePath, 'Settings', 'GuiHeight', 625))
       $aGui[$eGap]    = 15

Global $cTagDropdown, $cReloadButton, $cCopyButton
Global $cPaginationLabel, $cPreviousAnswerButton, $cNextAnswerButton
Global $cOpenConfigButton

Global $oIE

Global $cAddAnswerButton, $cSaveAnswerButton, $cNewTagInput
Global $cUpdateAnswerButton, $cDeleteAnswerButton, $cCurrentTagInput

Global $iQuillEditorHeight = ($aGui[$eHeight] / 1.5) + ($aGui[$eGap] / 2)
Global $iHeightOfGuiGroup = 70
Global $iControlBottomPosition = $iHeightOfGuiGroup + $aGui[$eGap]

Global $iMinAnswerIndex, $iMaxAnswerIndex
Global $bWasConfigFileAlreadyOpened = False
