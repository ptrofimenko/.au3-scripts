#include <WinAPI.au3>

$sProcess = 'Shutdown Version 3.0.1'

Start_($sProcess)
Exit


Func Start_($_sProcess)
	Local $_aWList, $_iA, $_iPID, $_iState
	Dim $flag = 1
	While $flag = 1
		sleep(100)
		$_aWList = WinList()
		For $_iA = 1 To $_aWList[0][0]
			StringReplace($_aWList[$_iA][0], $sProcess, '')
			If @extended Then
				_WinAPI_GetWindowThreadProcessId($_aWList[$_iA][1], $_iPID)
				$_iState = WinGetState($_aWList[$_iA][1])
				If BitAND($_iState, 2) Then
					If(WinClose($_aWList[$_iA][1])) Then
					   $flag = 0
					   ExitLoop
					EndIf
				EndIf
			EndIf
		Next
	WEnd
EndFunc