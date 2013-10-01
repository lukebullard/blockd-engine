Rem
	Blockd Fatal Error Debug Dumping System
	Blockd Game Engine
	Luke Bullard, October 2013
End Rem
SuperStrict
Import brl.stream
Import brl.filesystem
Import bah.persistence

Private
Global DUMP_PROGRAM_NAME:String = "Blockd v1.X"
Const DUMP_VERSION:Int = 1

Public
Function DebugDump(obj:Object)
	Local file:TStream = WriteFile("crash_" + Replace(CurrentDate()," ","-") + "_" + Replace(CurrentTime(),":","") + ".bdmp")
	If Not file Then Return
	WriteShort(file,DUMP_VERSION)
	WriteInt(file,Len(DUMP_PROGRAM_NAME))
	WriteString(file,DUMP_PROGRAM_NAME)
	TPersist.Format = True
	Local serializedObj:String = TPersist.Serialize(obj)
	WriteInt(file,Len(serializedObj))
	WriteString(file,serializedObj)
	CloseFile file
End Function