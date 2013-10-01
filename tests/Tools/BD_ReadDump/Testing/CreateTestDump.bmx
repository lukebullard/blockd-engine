SuperStrict
Import bah.persistence
Type TTest
	Field a:Int = 1
	Field b:Int = 3 {nopersist}
	Field c:Int = 5
	Field d:String = "Luke is Awesome!"
	Field parent:TTest
	Field strings:String[] = ["Luke","Cool 1","Not Cool 2","Cool 3"]
	Field ints:Int[] = [0,1,2,3,4]
End Type

Local instanceA:TTest = New TTest

Local instanceB:TTest = New TTest
instanceB.a = 10
instanceB.b = 500
instanceB.c = 95
instanceB.d = "The Kapitan is Jelly"
instanceB.parent = instanceA

Const DUMP_VERSION:Int = 1
Const PROGRAM_NAME:String = "Blockd Dump Test"

Function DebugDump(obj:Object)
	Local file:TStream = WriteFile("crash_" + Replace(CurrentDate()," ","-") + "_" + Replace(CurrentTime(),":","") + ".bdmp")
	If Not file Then Return
	WriteShort(file,DUMP_VERSION)
	WriteInt(file,Len(PROGRAM_NAME))
	WriteString(file,PROGRAM_NAME)
	TPersist.Format = True
	Local serializedObj:String = TPersist.Serialize(obj)
	WriteInt(file,Len(serializedObj))
	WriteString(file,serializedObj)
	CloseFile file
End Function

DebugDump(instanceA)
Delay 1000
DebugDump(instanceB)