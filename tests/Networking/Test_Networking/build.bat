@echo off
echo Building Test_Networking Client
cd Client
bmk makeapp -a -r -t console -o Test_Networking_Client.exe Test_Networking_Client.bmx
echo Deleting Intermediate Directory...
del /F /S /Q .bmx
rmdir .bmx
cd ..
echo Building Test_Networking Server
cd Server
bmk makeapp -a -r -t console -o Test_Networking_Server.exe Test_Networking_Server.bmx
echo Deleting Intermediate Directory...
del /F /S /Q .bmx
rmdir .bmx
cd ..