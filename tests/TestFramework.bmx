Rem
	Blockd Large-Scale Unit Testing Framework
	Blockd Game Engine
	Luke Bullard, September-October 2013
End Rem
SuperStrict

Type TestingFramework
	'put all your initialization code in an override of this function
	Method Init() Abstract
	
	'put all your testing code and main loop in an override of this function
	Method Test() Abstract
	
	'put all your shutdown code in an override of this function, optional
	Method Shutdown()
	End Method
End Type

'set this to be an instance of your custom, overridden, non-abstract testing framework class
'it is recommended to only use one instance of this per large-scale unit test
Global CurrentTest:TestingFramework