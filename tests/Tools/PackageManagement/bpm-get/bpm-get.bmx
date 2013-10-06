Rem
	Blockd Package Management System
	Blockd Game Engine
	Luke Bullard, October 2013
	-----
	Syntax:
		bpm-get
			Same as `bpm-get help`
		bpm-get help
			Displays help for bpm-get
		bpm-get search query
			Searches the local (updated) database for a package like query
		bpm-get list
			Shows all the packages available
		bpm-get update
			Updates the local package database with that of the repositories in repos.list
		bpm-get install [package] [package2] [package 3] [packageN]
			Downloads the packages (*.bpkg) to the temp directory, and runs bpkg on them.
			If no package is set in the command line, it will install the dependencies of the current directories' bpkg.json.
			It also shows how to incorporate the packages into the game.
			If there are unmet dependencies, it will prompt to install those, and quit if they are not selected.
		bpm-get remove package [package2] [package 3] [packageN]
			Removes packages from the local directory, and shows how to remove them from the game.
		bpm-get publish [server]
			Publishes the package (specified by bpm.xml in the local directory) to the [server] or the first server accepting packages
			in repos.list
End Rem
SuperStrict

Const VERSION_STRING:String = "0.0.1"

Global verb:String = "help"
Global nouns:TList

Function DisplayHelp()
	Print "bpm-get v" + VERSION_STRING
	Print "Blockd Game Engine v0.1"
	Print "Copyright (C) TheGamerBoard.com, 2013."
	Print
	Print "Syntax"
	Print "~tbpm-get"
	Print "~t~tSame as `bpm-get help`"
	Print "~tbpm-get help"
	Print "~t~tDisplays this help message"
	Print "~tbpm-get search query"
	Print "~t~tSearches the (hopefully) updated local database for a package like query"
	Print "~tbpm-get list"
	Print "~t~tShows all the packages available"
	Print "~tbpm-get update"
	Print "~t~tUpdates the local package database with that of the repositories in repos.list"
	Print "~tbpm-get install [package1] [package2] [packageN]"
	Print "~t~tDownloads the packages (*.bpkg) to the temp directory, and runs bpkg on them."
	Print "~t~tIf no package is set in the command line, it will install the dependencies of the current directories' bpkg.json"
	Print "~t~tIt also shows how to incorporate the packages into the game."
	Print "~t~tIf there are unmet dependencies, it will prompt to install those, and quit if the user does not select them."
	Print "~tbpm-get remove package1 [package2] [packageN]"
	Print "~t~tRemoves the packages from the local directory, and shows how to remove them from the game."
	Print "~tbpm-get publish [server]"
	Print "~t~tPublishes the package (specified by bpkg.json in the local directory) to the [server] or the first server"
	Print "~t~taccepting packages in repos.list"
End Function

Function ParseArguments()
	
End Function

Print "BPM-Get Not Implemented Yet!"
End
