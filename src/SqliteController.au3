Func _Setup()
    _SQLite_Startup($sSqliteDll)

    If @error Then
        Local Const $iErrorIcon = 16
        MsgBox($iErrorIcon, 'Error', 'Dll file "' & $sSqliteDll & '" not found.')

        Exit -1
    EndIf
EndFunc

Func _OpenDatabase()
    $hDatabase = _SQLite_Open($sDatabaseFilePath)

    If @error Then
        Local Const $iErrorIcon = 16
        MsgBox($iErrorIcon, 'Error', 'Can not open database "' & $sDatabaseFilePath & '".')

        Exit -1
    EndIf
EndFunc

Func _QueryResultToArray($sQuery)
    Local $aQueryResult, $iRows, $iColumns

    _SQLite_GetTable2d($hDatabase, $sQuery, $aQueryResult, $iRows, $iColumns)

    Return $aQueryResult
EndFunc

Func _ExecuteQuery($sQuery)
    Local $iSqliteReturn = _SQLite_Exec($hDatabase, $sQuery)

    Switch $iSqliteReturn
        Case $SQLITE_OK
            Return True

        Case $SQLITE_CONSTRAINT
            Local Const $iWarningIcon = 48
            MsgBox($iWarningIcon, 'Warning', _
                'An answer with the exact same content already exists. Answer duplications are not allowed.' & _
                'But you can "Update" the "Tag*" for this answer, in "Current answer" section, if you want to.')

            Return False

        Case Else
            Local Const $iErrorIcon = 16
            MsgBox($iErrorIcon, 'Error', _
                'Sqlite return value: "' & $iSqliteReturn & '". ' & _
                'Please contact the program author for specific information.')

            Return False
    EndSwitch
EndFunc

Func _TearDown()
    _SQLite_Close()
    _SQLite_Shutdown()
EndFunc
