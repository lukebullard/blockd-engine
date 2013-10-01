Rem
	Blockd Fatal Error Debug Dump File Reader
	Main File
	Blockd Game Engine
	Luke Bullard, October 2013
End Rem
SuperStrict
Import maxgui.drivers
Import bah.libxml
Const PROGRAM_VERSION:Int = 1
Const DUMP_VERSION:Int = 1
AppTitle = "Blockd Dump File Reader"

Type BD_DumpedObject
	Field _type:String
	Field _value:String
	Method Create:BD_DumpedObject(__type:String,__value:String)
		_type = __type
		_value = __value
		Return Self
	End Method
End Type

Include "GUI.bmx"