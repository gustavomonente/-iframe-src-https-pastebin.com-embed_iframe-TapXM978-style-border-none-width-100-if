@cls
@rem MakeFSZipX.bat
@rem A batch file to make self-extracting .zip files using 
@rem Funduc Software's FSZipX self-extracting zip stub.
@rem
@rem IMPORTANT NOTE:
@rem
@rem This .bat was created as an aid only. We have tested this 
@rem and use it ourselves. However, no guarantee as to 
@rem usability or freedom from bugs is made. USE THIS AT YOUR 
@rem OWN RISK.
@rem 
@rem You may modify this file as you see fit for your own use.
@rem However, if you distribute MakeFSZipX.bat you must distribute
@rem the original or obtain permission from us first to do otherwise.
@rem
@rem Copyright 1999-2011 Funduc Software, Inc.
@rem http://www.funduc.com/   http://www.searchandreplace.com
@rem support@funduc.com       support@searchandreplace.com
@rem 
@echo                         MakeFSZipX.bat
@echo.
@echo A batch file to make self-extracting .zip files using 
@echo Funduc Software's FSZipX self-extracting zip stub.
@echo.
@echo Copyright 1999-2011 Funduc Software, Inc.
@echo http://www.funduc.com/   http://www.searchandreplace.com
@echo support@funduc.com       support@searchandreplace.com
@echo.
@echo IMPORTANT NOTE
@echo --------------
@echo This .bat was created as an aid only. We have tested this 
@echo and use it ourselves. However, no guarantee as to 
@echo usability or freedom from bugs is made. 
@echo.
@echo Press CTRL+C (the CTRL and C key simultaneously) to abort 
@echo the job and answer Y if you are prompted to terminate
@echo or
@pause
@cls
@IF NOT EXIST fszipx.exe GOTO NOSTUB
@IF "%1"== "" GOTO NONAME
@IF NOT EXIST %1 GOTO NOTFOUND
@IF "%2"== "" GOTO AUTONAME
:NAMED
@IF EXIST %2 GOTO OVER1
@GOTO MAKE1
:OVER1
@cls
@echo.
@echo The file 
@echo.
@echo   %2 
@echo.
@echo already exists (less " characters in the name if you specified them).
@echo.
@echo IF YOU CONTINUE THE EXISTING FILE WILL BE OVER-WRITTEN.
@echo.
@echo Press CTRL+C (the CTRL and C key simultaneously) to abort the job and
@echo answer Y if you are prompted to terminate
@echo or
@pause
@del %2
:MAKE1
@echo.
copy FSZipX.exe /b + %1 /b %2
@cls
@echo.
@echo Finished. 
@echo.
@echo The name of your self-extracting zip is
@echo.
@echo    %2%
@echo.
@echo (less " characters the name if you specified them)
@echo.
@echo NOTE: If this file does not end with .exe you should either 
@echo rename the %2% file manually 
@echo or 
@echo delete %2% and run MakeFSZipX.bat again, this time specifying the .exe
@echo part of the self-extractor you want to make.
@echo.
@echo Funduc Software Zip Self-Extractor
@echo Copyright 1999-2011 Funduc Software, Inc.
@echo http://www.funduc.com/   http://www.searchandreplace.com
@echo support@funduc.com       support@searchandreplace.com
@GOTO QUIT
:AUTONAME
@IF EXIST %1%.exe GOTO OVER2
@GOTO MAKE2
:OVER2
@cls
@echo.
@echo The file
@echo.
@echo   %1%.exe
@echo.
@echo already exists (less " characters in the name if you specified them).
@echo.
@echo IF YOU CONTINUE THE EXISTING FILE WILL BE OVER-WRITTEN.
@echo.
@echo Press CTRL+C (the CTRL and C key simultaneously) to abort the job and
@echo answer Y if you are prompted to terminate
@echo or
@pause
@del %1.exe
:MAKE2
@echo.
copy FSZipX.exe /b + %1 /b %1.exe
@cls
@echo.
@echo Finished.
@echo.
@echo The name of your self-extracting zip is
@echo.
@echo    %1%.exe
@echo.
@echo (Less " characters in the name if you specified them)
@echo.
@echo Funduc Software Zip Self-Extractor
@echo Copyright 1999-2011 Funduc Software, Inc.
@echo http://www.funduc.com/   http://www.searchandreplace.com
@echo support@funduc.com       support@searchandreplace.com
GOTO QUIT
:NOTFOUND
@cls
@echo Funduc Software Zip Self-Extractor
@echo Copyright 1999-2011 Funduc Software, Inc.
@echo http://www.funduc.com/   http://www.searchandreplace.com
@echo support@funduc.com       support@searchandreplace.com
@echo.
@echo The file named - 
@echo.
@echo    %1% 
@echo.
@echo was not found. Perhaps you made a typing error. Please double
@echo check your file name and try again.
@echo.
@pause
@GOTO USAGE
:NONAME
@echo.
@echo You did not specify a file to make into a self-extracting zip....
@echo.
@echo Funduc Software Zip Self-Extractor
@echo Copyright 1999-2011 Funduc Software, Inc.
@echo http://www.funduc.com/   http://www.searchandreplace.com
@echo support@funduc.com       support@searchandreplace.com
@echo.
@pause
@GOTO USAGE
:USAGE
@cls
@echo SYNTAX:
@echo.
@echo The syntax is
@echo.
@echo     MakeFSZipX name_of_zipfile.zip
@echo or
@echo     MakeFSZipX name_of_zipfile.zip name_of_self-extractor
@echo.
@echo - Be sure to specify the .zip part of the zip file name!
@echo - You must also specify the complete path name to the .zip if that 
@echo   file does exist in the same directory as FSZipX.exe.
@echo - If you specify the name of the self-extractor to create, be sure to
@echo   specify .exe as a file name suffix.
@echo - MakeFSZipX.bat should not be run by double clicking on it from 
@echo   Windows Explorer. Run the MakeFSZipX.bat from a MS-DOS window run 
@echo   or by specifying all the command line options from Start-Run menu.
@echo - Use " characters if your path names have spaces in them.
@echo.
@echo Funduc Software Zip Self-Extractor
@echo Copyright 1999-2011 Funduc Software, Inc.
@echo http://www.funduc.com/   http://www.searchandreplace.com
@echo support@funduc.com       support@searchandreplace.com
@GOTO QUIT
:NOSTUB
@cls
@echo.
@echo PROBLEM - 
@echo.
@echo The self-extractor stub file, FSZipX.exe, could not be located.
@echo MakeFSZipX.bat expects FSZipX.exe to be in the same path as it is.
@echo If you moved FSZipX.exe, please relocate it back to the path 
@echo MakeFSZipX.bat is in or modify MakeFSZipX.bat to suit where you 
@echo have FSZipX.exe on your computer.
@echo.
@echo Funduc Software Zip Self-Extractor
@echo Copyright 1999-2011 Funduc Software, Inc.
@echo http://www.funduc.com/   http://www.searchandreplace.com
@echo support@funduc.com       support@searchandreplace.com
@GOTO QUIT
:QUIT