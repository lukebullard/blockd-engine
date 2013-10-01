Rem
	Blockd High-Performance Game Event System
	Blockd Game Engine
	Luke Bullard, October 2013
	-----
	This Event system must be used over the regular event system, despite the overhead, becuase Linked Lists are infinite.
	The regular, built-in event system uses an array with a max value of 256. There is a chance (although there shouldn't be)
	that the event system will reach that cap and fail to report events.
End Rem
SuperStrict
Import brl.linkedlist

Type BD_Event
	Field _type:Int
	Method Create:BD_Event(__type:Int)
		_type = __type
		Return Self
	End Method
End Type

Type BD_EventManager
	Global events:TList = CreateList()
	Function Poll:BD_Event()
		Return BD_Event(events.RemoveFirst())
	End Function
	Function Peek:BD_Event()
		Return BD_Event(events.First())
	End Function
	Function Post(event:BD_Event)
		events.AddLast(event)
	End Function
End Type