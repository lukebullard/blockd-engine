@echo off
set startdir=%CD%
echo Starting BuildDump Building Process...
cd Tools\BD_ReadDump
call build.bat
cd %startdir%
echo Starting Test_Networking Building Process...
cd Networking/Test_Networking
call build.bat
cs %startdir%
echo Complete!