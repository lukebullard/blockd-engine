Rem
	Blockd Package Installer
	Blockd Game Engine
	Luke Bullard, October 2013
	-----
	Syntax:
		bpkg
			Same as bpkg help.
		bpkg help
			Displays help for bpkg.
		bpkg install package.bpkg [package1.bpkg] [package2.bpkg] [packageN.bpkg]
			Installs the package into the local directory.
		bpkg package
			Creates a package with the files and settings specified by bpkg.json.
End Rem
SuperStrict

Import bah.libxml
Import gman.zipengine
Import bah.regex

Const VERSION_STRING:String = "0.0.1"

Global verb:String = "help"
Global nouns:TList

Function ParseArguments()
	If AppArgs.Length < 2 Then
		Return
	EndIf
	Select AppArgs[1]
		Case "help"
			verb = "help"
		Case "install"
			If AppArgs.Length > 2 Then
				verb = "install"
				nouns = CreateList()
				For Local i:Int = 2 To AppArgs.Length-1
					nouns.AddLast(AppArgs[i])
				Next
			EndIf
		Case "package"
			verb = "package"
	End Select
End Function

Function DisplayHelp()
	Print "bpkg v" + VERSION_STRING
	Print "Blockd Game Engine v0.1"
	Print "Copyright (C) TheGamerBoard.com, 2013."
	Print
	Print "Syntax"
	Print "~tbpkg"
	Print "~t~tSame as `bpkg help`"
	Print "~tbpkg help"
	Print "~t~tDisplays this help message"
	Print "~tbpkg install package1.bpkg [package2.bpkg] [packageN.bpkg]"
	Print "~t~tInstalls the packages into the local directory."
	Print "~t~tIt is good to note that this does not check for dependencies."
	Print "~t~tThat can be done through bpm-get, and why bpm-get was made."
	Print "~tbpkg package"
	Print "~t~tPackages the package in the current directory specified by bpkg.json to 'packageName'.bpkg"
	Print
End Function

Function InstallPackage(filename:String)
	Print "Package Install Functionality Not Implemented!"
	End
	
	If FileType(filename) <> 1 Then
		Print "Missing Package File: ~q" + filename + "~q!"
		End
	EndIf
End Function

Function VerifyVersionString:String(version:String)
	Local regex:TRegEx = TRegEx.Create("^(([0-9])+\.){2}([0-9])+$")
	Local match:TRegExMatch
	
	Try
		match = regex.Find(version)
	Catch e:TRegExException
		If e.num <> REGEX_NOMATCH Then
			Print "Regex Error Parsing Package Version: " + e.toString()
			End
		Else
			Print "Invalid Package Version in bpkg.xml!"
			End
		End If
	End Try
	If match Then
		Return version
	End If
End Function

Function VerifyNameString:String(name:String)
	Local regex:TRegEx = TRegEx.Create("^([a-zA-Z0-9_-])+$")
	Local match:TRegExMatch

	Try
		match = regex.Find(name)
	Catch e:TRegExException
		If e.num <> REGEX_NOMATCH Then
			Print "Regex Error Parsing Package Name: " + e.toString()
			End
		Else
			Print "Invalid Package Name in bpkg.xml!"
			End
		End If
	End Try
	If match Then
		Return name
	End If
End Function

Function CreatePackage()
	If FileType("bpkg.xml") <> 1 Then
		Print "Missing bpkg.xml!"
		End
	EndIf
	Local bpkgDoc:TxmlDoc = TxmlDoc.parseFile("bpkg.xml")
	Local bpkgRoot:TxmlNode = bpkgDoc.getRootElement()
	Local nameValue:String = bpkgRoot.getAttribute("name")
	If nameValue = Null Or nameValue = "" Then
		Print "Missing Package Name in bpkg.xml!"
		End
	EndIf
	Local versionValue:String = bpkgRoot.getAttribute("version")
	If versionValue = Null Or versionValue = "" Then
		Print "Missing Package Version in bpkg.xml!"
		End
	EndIf
	Local outputFilename:String = VerifyNameString(nameValue.ToString()) + "-" + VerifyVersionString(versionValue.ToString())
	If FileType(outputFilename + ".zip") = 1 Then
		Local changedOutputFilename:String = outputFilename + "_0"
		Local count:Int = 1
		While FileType(changedOutputFilename + ".zip") = 1
			changedOutputFilename = outputFilename + "_" + count
			count :+ 1
		Wend
		outputFilename = changedOutputFilename
	EndIf
	outputFilename :+ ".zip"
	
	Local child:TxmlNode = GetNodeByName(bpkgRoot,"import")
	If child = Null Then
		Print "Missing Import File Declaration in bpkg.xml!"
		End
	EndIf
	Local importValue:String = child.getContent()
	If importValue = Null Then
		Print "Missing Import File Value in bpkg.xml!"
		End
	EndIf
	Local outputZipWriter:ZipWriter = New ZipWriter
	outputZipWriter.OpenZip(outputFilename,False)
	outputZipWriter.AddFile(importValue)
	
	Local nodes:TList = bpkgRoot.getChildren()
	For Local node:TxmlNode = EachIn nodes
		If node.getName() = "include" Then
			Local inputFile:String = node.getAttribute("source")
			If inputFile = Null Or inputFile = "" Then
				Print "Missing or Invalid Include Source!"
				outputZipWriter.CloseZip()
				DeleteFile outputFilename
				End
			EndIf
			inputFile = inputFile
			Local outputFile:String = node.getAttribute("output")
			If outputFile = Null Or outputFile = "" Then
				Print "Missing or Invalid Include Output!"
				outputZipWriter.CloseZip()
				DeleteFile outputFilename
				End
			EndIf
			If FileType(inputFile) = 2 Then
				'folder
				RecursiveAddFolder(inputFile,outputFile,outputZipWriter,True)
			Else
				'file
				outputZipWriter.AddFileToDest(inputFile,outputFile)
			EndIf
		EndIf
	Next
	outputZipWriter.CloseZip()
End Function

Function GetNodeByName:TxmlNode(original:TxmlNode,name:String)
	Local nodes:TList = original.getChildren()
	For Local node:TxmlNode = EachIn nodes
		If node.getName() = name Then
			Return node
		EndIf
	Next
	Return Null
End Function

Function RecursiveAddFolder(folder:String,outputFolder:String,outputZipWriter:ZipWriter,isTop:Int=False)
	Local dir:String[] = LoadDir(folder)
	If Not dir Then
		outputZipWriter.AddFileToDest(Null,outputFolder)
		Return
	EndIf
	For Local file:String = EachIn dir
		If FileType(folder + "/" + file) = 2 Then
			'folder
			Print folder + "/" + file+ "=>" + outputFolder
			RecursiveAddFolder(folder + "/" + file,outputFolder + "/" + file,outputZipWriter)
		Else
			'file
			Print folder + "/" + file+ "=>" + outputFolder
			outputZipWriter.AddFileToDest(folder + "/" + file,outputFolder + "/" + file)
		EndIf
	Next
End Function

ParseArguments()

Select verb
	Case "help"
		DisplayHelp()
	Case "install"
		For Local noun:String = EachIn nouns
			InstallPackage(noun)
		Next
	Case "package"
		CreatePackage()
End Select