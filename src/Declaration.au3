Global $sConfigFilePath               = '..\config\config.ini'
Global $sSqliteDll                    = '..\data\sqlite3_x64.dll'
Global $sQuillEditorFilePath          = '..\data\quilljs.html'
Global $sDatabaseFilePath             = IniRead($sConfigFilePath, 'Settings', 'DatabaseFilePath', '..\data\Au3AnswerByTag.db')
Global $sSignatureAppendix            = IniRead($sConfigFilePath, 'Settings', 'SignatureAppendix', 'with kind regards, <NAME>') ; TODO: Implement it for save, update and copy.
Global $sMessageBoxBeforeSaveOrUpdate = IniRead($sConfigFilePath, 'Settings', 'MessageBoxBeforeSaveOrUpdate', 'y') ; TODO: Implement it for save, update and delete.
Global $hDatabase

Global Const $iGuiEventClose = -3
Global $sInitDropdownText    = 'List of tags'

Global $aGui[$iMaxEnumIndex]
       $aGui[$eHandle] = Null
       $aGui[$eWidth]  = Int(IniRead($sConfigFilePath, 'Settings', 'GuiWidth', 900))
       $aGui[$eHeight] = Int(IniRead($sConfigFilePath, 'Settings', 'GuiHeight', 625))
       $aGui[$eGap]    = 15

Global $cTagDropdown, $cCopyButton
Global $cPaginationLabel, $cPreviousAnswerButton, $cNextAnswerButton
Global $cOpenConfigButton

Global $oIE

Global $cAddAnswerButton, $cSaveAnswerButton, $cNewTagInput
Global $cUpdateAnswerButton, $cDeleteAnswerButton, $cCurrentTagInput

Global $iQuillEditorHeight = $aGui[$eHeight] / 1.5
Global $iControlBottomPosition
Global $iMinAnswerIndex, $iMaxAnswerIndex

