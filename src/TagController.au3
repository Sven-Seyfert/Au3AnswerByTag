Func _GetListOfTags()
    Local $sQuery      = "select tag from answers;"
    Local $aListOfTags = _QueryResultToArray($sQuery)

    $aListOfTags = _DeleteArrayElement($aListOfTags, 0)
    $aListOfTags = _ReplaceCommasWithPipe($aListOfTags)

    Local $sPipeSeparatedTags = _BuildPipeSeparatedTagString($aListOfTags, True)

    Return _GetFilteredListOfTags($sPipeSeparatedTags)
EndFunc

Func _ReplaceCommasWithPipe($aList)
    For $i = 0 To _GetCount($aList) Step 1
        $aList[$i][0] = StringReplace($aList[$i][0], ' , ', ',')
        $aList[$i][0] = StringReplace($aList[$i][0], ' ,', ',')
        $aList[$i][0] = StringReplace($aList[$i][0], ', ', ',')
        $aList[$i][0] = StringReplace($aList[$i][0], ',', '|')
    Next

    Return $aList
EndFunc

Func _BuildPipeSeparatedTagString($aList, $bIs2dArray = False)
    Local $sPipeSeparatedTags

    For $i = 0 To _GetCount($aList) Step 1
        Local $sTag = ($bIs2dArray) ? $aList[$i][0] : $aList[$i]
        $sPipeSeparatedTags &= $sTag & '|'
    Next

    Return $sPipeSeparatedTags
EndFunc

Func _GetFilteredListOfTags($sPipeSeparatedTags)
    Local $aListOfTags = StringSplit($sPipeSeparatedTags, '|')

    $aListOfTags = _DeleteArrayElement($aListOfTags, _GetCount($aListOfTags))
    $aListOfTags = _DeleteArrayElement($aListOfTags, 0)
    $aListOfTags = _ArrayUnique($aListOfTags)
    $aListOfTags = _DeleteArrayElement($aListOfTags, 0)

    _ArraySort($aListOfTags)

    Return $aListOfTags
EndFunc
