; compiler information for AutoIt
#pragma compile(CompanyName, © SOLVE SMART)
#pragma compile(FileVersion, 0.2.0)
#pragma compile(LegalCopyright, © Sven Seyfert)
#pragma compile(ProductName, Au3AnswerByTag)
#pragma compile(ProductVersion, 0.2.0 - 2022-03-09)

#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Icon=..\media\favicon.ico
#AutoIt3Wrapper_Outfile_x64=..\build\Au3AnswerByTag.exe
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseX64=y



; opt and just singleton -------------------------------------------------------
Opt('MouseCoordMode', 0)
Opt('MustDeclareVars', 1)
Global $aInst = ProcessList('Au3AnswerByTag.exe')
If $aInst[0][0] > 1 Then Exit



; includes ---------------------------------------------------------------------
#include-once
#include <Array.au3>
#include <GuiComboBox.au3>
#include <GUIConstants.au3>
#include <GuiRichEdit.au3>
#include <IE.au3>
#include <SQLite.au3>
#include <SQLite.dll.au3>
#include <String.au3>



; modules ----------------------------------------------------------------------
#include "Enum.au3"
#include "Declaration.au3"
#include "SqliteController.au3"
#include "GuiBuilder.au3"
#include "GuiController.au3"
#include "TagController.au3"
#include "AnswerController.au3"
#include "HelperFunctions.au3"
#include "PaginationController.au3"



; processing -------------------------------------------------------------------
#include "ActionHandler.au3"
