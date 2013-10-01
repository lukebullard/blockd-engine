Rem
	Blockd Fatal Error Debug Dump File Reader
	Modified Exported File from LogicGUI
	Blockd Game Engine
	Luke Bullard, October 2013
End Rem
Global	MainWindow:TGadget
Global	QuitButton:TGadget
Global	LoadButton:TGadget
Global	FaultingProgram:TGadget
Global	XMLView:TGadget


MainWindow = CreateWindow("Blockd Dump File Reader",392,95,640,480,Null,WINDOW_TITLEBAR|WINDOW_CENTER)
	QuitButton = CreateButton("Quit",560,418,70,28,MainWindow,BUTTON_PUSH)
	LoadButton = CreateButton("Load",468,418,71,28,MainWindow,BUTTON_PUSH)
	FaultingProgram = CreateTextField(11,34,611,22,MainWindow,Null)
		SetGadgetText( FaultingProgram,"Unknown")
		DisableGadget( FaultingProgram )
	Local Label1:TGadget = CreateLabel("Faulting Program:",13,10,95,18,MainWindow,Null)
	Local Label2:TGadget = CreateLabel("Faulting Object:",13,67,96,18,MainWindow,Null)
	XMLView = CreateTextArea(11,94,611,310,MainWindow,TEXTAREA_READONLY)
		SetTextAreaText( XMLView , "No XML Data To Display" )

Repeat
	WaitEvent()
	Select EventID()
		Case EVENT_WINDOWCLOSE
			Select EventSource()
				Case MainWindow	MainWindow_WC( MainWindow )
			End Select

		Case EVENT_GADGETACTION
			Select EventSource()
				Case QuitButton	QuitButton_GA( QuitButton )
				Case LoadButton	LoadButton_GA( LoadButton )
			End Select
	End Select
Forever

Function MainWindow_WC( Window:TGadget )
	If Proceed("Are you sure you want to quit?",False) = 1 Then
		End
	EndIf
End Function

Function QuitButton_GA( Button:TGadget )
	If Proceed("Are you sure you want to quit?",False) = 1 Then
		End
	EndIf
End Function

Function LoadButton_GA( Button:TGadget )
	Local filename:String = RequestFile("Select a Blockd Dump File...","Dump Files:bdmp;All Files:*")
	If filename = "" Then Return
	Local fileStream:TStream = ReadFile(filename)
	If Not fileStream Then Return
	Local fileVersion:Int = ReadShort(fileStream)
	If fileVersion <> DUMP_VERSION Then
		CloseFile fileStream
		Notify("Incompatible Dump File Version: " + fileVersion + "~nExpected: =" + PROGRAM_VERSION)
		Return
	EndIf
	Local faultingExe:String = ReadString(fileStream,ReadInt(fileStream))
	If faultingExe = "" Then
		SetGadgetText(FaultingProgram,"Program")
	Else
		SetGadgetText(FaultingProgram,faultingExe)
	EndIf
	Local xml:String = ReadString(fileStream,ReadInt(fileStream))
	CloseFile fileStream
	SetGadgetText(XMLView,xml)
End Function