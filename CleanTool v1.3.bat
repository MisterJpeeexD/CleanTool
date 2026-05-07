@echo off
REM  --> Analizando los permisos
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)
 
if '%errorlevel%' NEQ '0' (echo Ejecutando modo administrador... 
timeout /t 1 /nobreak > NUL
) else ( goto gotAdmin )
 
:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
 
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B
 
:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
title CleanTool v 3.0
color 4
cls
echo 		/=============================================================================\
echo 		º   / \  ADVERTENCIA: Este programa necesita permisos de administrador  / \   º
echo 		º  / ! \ para funcionar, de lo contrario, no se completara el programa / ! \  º
echo 		º=============================================================================º
echo 		º  / \ WARNING: This program needs administrator permissions to work, / \     º
echo 		º / ! \          otherwise the program will not be completed         / ! \    º
echo 		\=============================================================================/
echo.
pause
cls
goto 1

################################		SELECCION DE IDIOMA		################################

:1
cls
echo 			/==================================\
echo 			º 1._ Seleccione su idioma (ES_US) º
echo 			º 2._ Select your language (EN_US) º
echo 			\==================================/
echo.
set /p l= Answer/respuesta: 
if %l%==1 goto Multi_Es
if %l%==2 goto Multi_En
if %l%==. goto info
echo.
echo Respuesta invalida, intentelo de nuevo
echo Invalid answer, Try again
timeout /t 2 /nobreak > NUL
cls
goto 1

################################		INICIO ESPAÑOL			################################

:Multi_es
cls
echo 			/==================================\
echo 			º Que herramienta desea ejecutar?  º
echo 			º==================================º
echo 			º 1._ Desfragmentador              º
echo 			º 2._ Limpiador                    º
echo 			º 3._ Kill-Svc                     º
echo 			º 4._ Que hay de nuevo?            º
echo 			º 5._ Ez Mode                      º
echo 			º 6._ Back                         º
echo 			\==================================/
:Multi_es_re
echo.
set /p r= Orden: 
if %r%==1 goto S
if %r%==2 goto Ale
if %r%==3 goto SvcS
if %r%==4 goto novedades
if %r%==5 goto ez
if %r%==6 goto 1
echo.
echo Respuesta invalida, intentelo de nuevo
timeout /t 2 /nobreak > NUL
cls
goto Multi_es
################################		EZ MODE		################################

:ez
echo 			/=========================\
echo 			º Bienvenido al asistente º
echo 			º       de limpieza       º
echo 			º        automatico       º
echo                    º                         º
echo 			º          3.0 v          º
echo 			\=========================/
echo.
echo Iniciando el asistente, puede seguir usando su PC
timeout /t 2 /nobreak > NUL
cls
echo Paso 1 de 3: Desfragmentacion
defrag c: /u
echo.
echo Desfragmentacion completa
echo Paso 2 de 3: Eliminacion de archivos basura
del /q /s %temp% >nul
del /q /s C:\Windows\Temp >nul
del /q /s C:\Windows\Prefetch >nul
echo.
echo Eliminacion completada
echo Paso 3 de 3: Deteniendo servicios innecesarios
sc stop DsSvc
sc stop DusmSvc
sc stop NlaSvc
sc stop RasMan
sc stop RmSvc
sc stop SessionEnv
sc stop TabletInputService
sc stop TapiSrv
sc stop TeamViewer
sc stop TermService
sc stop SEVPNCLIENT
cls
echo.
echo /==================================\
echo º     Herramienta de limpieza      º
echo º             creada por           º
echo º==================================º
echo º                                  º
echo º          MisterJpeeexD           º
echo º              3.0 v               º
echo º                                  º
echo \==================================/
echo.
echo /============================================\
echo º  / \                                  / \  º
echo º / ! \ Pulse una tecla para finalizar / ! \ º
echo \============================================/
pause >nul
exit


################################		NOVEDADES ESPAÑOL		################################

:novedades
cls
echo /=============================================================================\
echo º Que hay de nuevo?                                                           º
echo º                                                                             º
echo º - Efectos visuales eliminados: Retraso de programa	     		      º
echo º - Los consejos se mostraran al iniciar el desfragmentado	              º
echo º - Agregado repetir respuesta                                                º
echo º - Bugs arreglados        					              º
echo \=============================================================================/
echo.
echo Pulse cualquier tecla para volver atras...
pause >nul
goto Multi_es

################################		DESFRAGMENTACION ESPAÑOL		################################

:S
cls
echo 			/=========================\
echo 			º Bienvenido al asistente º
echo 			º  de desfragmentacion    º
echo 			º                         º
echo 			º          3.0 v          º
echo 			\=========================/
echo.
echo /=========================================================================\
echo º ( ? ) Que unidad desfragmenteras (escribe la letra de directorio) ( ? ) º
echo º                            (Ej: C, D, E, H...)                          º
echo \=========================================================================/
echo.
set /p U= Escriba el directorio: 
echo.
echo Buscando directorio...
timeout /t 1 /nobreak > NUL
echo.
cd %u%: >nul
if %errorlevel% equ 1 goto noencontrado
goto siencontrado

################################		DESFRAGMENTACION ESPAÑOL		################################

:noencontrado
cls
echo 			/=========================\
echo 			º Bienvenido al asistente º
echo 			º  de desfragmentacion    º
echo 			º                         º
echo 			º          3.0 v          º
echo 			\=========================/
echo.
echo /=========================================================================\
echo º ( ? ) Que unidad desfragmenteras (escribe la letra de directorio) ( ? ) º
echo º                            (Ej: C, D, E, H...)                          º
echo \=========================================================================/
echo.
echo Escriba el directorio: %u%
echo.
echo El directorio no existe, por favor intente nuevamente
timeout /t 2 /nobreak > NUL
goto s

:siencontrado
cls
echo 		/=============================================================\
echo 		º  / \                                                   / \  º
echo 		º / ! \          Se ha detectado el directorio!         / ! \ º
echo 		\=============================================================/
echo.
echo 		/=============================================================\
echo 		º Consejos:                                                   º
echo 		º                                                             º
echo 		º  - El proceso puede durar entre 30-60 Minutos, se paciente. º
echo 		º  - Tu PC puede volverse lento en el proceso, es normal.     º
echo 		º  - Si quieres que el proceso vaya rapido, no uses tu PC!    º
echo 		º  - Se recomienda eliminar los archivos de la papelera       º
echo 		º=============================================================º
echo 		º  / \      Estas seguro que deseas desfragmentar?       / \  º
echo 		º / ! \       (se desfragmentara la unidad %u%:)          / ! \ º
echo 		\=============================================================/
echo.
echo 		/=======\
echo 		º 1. Si º
echo 		º 2. No º
echo 		\=======/
echo.
set /p n= Escriba su respuesta:	
if %n%==1 goto Ce
if %n%==2 goto Ne
echo Respuesta invalida, intente nuevamente
timeout /t 2 /nobreak > NUL
goto siencontrado

################################		DESFRAGMENTACION ACEPTADA		################################

:Ce
cls
echo			/============================================================\
echo 		º  / \    Le gustaria priorizar la tarea? Esto dejara   / \  º
echo 		º / ! \ su PC inutilizable hasta que finalize la tarea / ! \ º
echo 		\============================================================/
echo.
echo 		/=======\
echo 		º 1. Si º
echo 		º 2. No º
echo 		\=======/
echo.
set /p orden= Escriba su respuesta:
if %orden%==1 goto modo_rendimiento
if %orden%==2 goto modo_normal
echo Respuesta incorrecta, por favor, intente nuevamente
timeout /t 2 /nobreak > nul
goto ce

:modo_rendimiento
taskkill /im explorer.exe > nul
taskkill /f /im explorer.exe > nul
cls
echo /====================================================\
echo º  / \                                          / \  º
echo º / ! \ Inicializando desfragmentacion de %u%:   / ! \ º
echo \====================================================/
timeout /t 2 /nobreak > NUL
cls
defrag %u%: /u
start explorer.exe
cls
echo /====================================================\
echo º  / \                                          / \  º
echo º / ! \  La desfragmentacion se ha completada  / ! \ º
echo º====================================================º
echo º ( ? ) Desea iniciar el asistente de limpieza ( ? ) º
echo \====================================================/
echo.
echo /=======\
echo º 1. Si º
echo º 2. No º
echo \=======/
echo.
set /p y= Escriba su orden: 
echo.
if %y%==1 goto Ale
if %y%==2 goto adios
echo.
echo respuesta invalida, intente nuevamente
timeout /t 2 /nobreak > NUL
goto error

:modo_normal
cls
echo /====================================================\
echo º  / \                                          / \  º
echo º / ! \ Inicializando desfragmentacion de %u%:   / ! \ º
echo \====================================================/
timeout /t 2 /nobreak > NUL
cls
defrag %u%: /u
cls
echo /====================================================\
echo º  / \                                          / \  º
echo º / ! \  La desfragmentacion se ha completada  / ! \ º
echo º====================================================º
echo º ( ? ) Desea iniciar el asistente de limpieza ( ? ) º
echo \====================================================/
echo.
echo /=======\
echo º 1. Si º
echo º 2. No º
echo \=======/
echo.
set /p y= Escriba su orden: 
echo.
if %y%==1 goto Ale
if %y%==2 goto adios
echo.
echo respuesta invalida, intente nuevamente
timeout /t 2 /nobreak > NUL
goto error
################################		DESFRAGMENTACION CANCELADA		################################

:Ne
cls
echo /==========================================================\
echo º  / \                                                / \  º
echo º / ! \      La desfragmentacion se ha cancelado     / ! \ º
echo º==========================================================º
echo º ( ? ) Le gustaria iniciar el asistente de limpieza ( ? ) º
echo \==========================================================/
echo.
echo /=======\
echo º 1. Si º
echo º 2. No º
echo \=======/
echo.
set /p y= Escriba su orden: 
if %y%==1 goto Ale
if %y%==2 goto adios
echo respuesta invalida, intente nuevamente
timeout /t 2 /nobreak > NUL
goto Ne

################################		LIMPIEZA		################################

:Ale
cls
echo /==========================================\
echo º  / \ Se estan borrando los archivos / \  º
echo º / ! \   basura, por favor espera   / ! \ º
echo \==========================================/
echo.
del /q /s %temp% >nul
del /q /s C:\Windows\Temp >nul
del /q /s C:\Windows\Prefetch >nul
timeout /t 2 /nobreak > NUL
goto preguntaservicios

################################		PREGUNTA SERVICIOS		################################

:preguntaservicios
cls
echo 			/=================================\
echo 			º  / \                       / \  º
echo 			º / ! \ Limpieza completada / ! \ º
echo 			º=================================/
echo.
echo /========================================================================\
echo º ( ? ) Le gustaria iniciar el asistente de detencion de servicios ( ? ) º
echo \========================================================================/
echo.
echo /=======\
echo º 1. Si º
echo º 2. No º
echo \=======/
echo.
set /p y= Escriba su orden: 
if %y%==1 goto svcS
if %y%==2 goto adios
echo respuesta invalida, intente nuevamente
timeout /t 2 /nobreak > NUL
goto Ne

################################		DESPEDIDA		################################

:adios
cls
echo /==================================\
echo º     Herramienta de mantencion    º
echo º             creada por           º
echo º==================================º
echo º                                  º
echo º          MisterJpeeexD           º
echo º              3.0 v               º
echo º                                  º
echo \==================================/
echo.
echo /============================================\
echo º  / \                                  / \  º
echo º / ! \ Pulse una tecla para finalizar / ! \ º
echo \============================================/
pause >nul
exit

############################################################################################################################################################
############################################################################################################################################################


################################		INICIO INGLES			################################

:Multi_En
cls
echo 			/================================\
echo			º What tool do you want to run?  º
echo 			º================================º
echo 			º 1._ Desfragmenter              º
echo 			º 2._ Cleaner                    º
echo 			º 3._ Stop Services              º
echo 			º 4._ What's new?                º
echo 			º 5._ Volver                     º
echo 			\================================/
echo.
set /p e= Order:
if %e%==1 goto E
if %e%==2 goto Cil
if %e%==3 goto SvcE
if %e%==4 goto news
if %e%==5 goto 1 
echo.
echo Invalid answer, Try again
timeout /t 2 /nobreak > NUL
goto Multi_en

################################		NOVEDADES INGLES			################################

:news
cls
echo /=============================================================================\
echo º What's new?							    	      º
echo º									      º
echo º - Visual effects removed: Program delay				      º
echo º - The tips will be displayed when you start the desfragment		      º
echo º - Add repeat the answer	                                              º				
echo º - Bug fixed                                                                 º
echo \=============================================================================/
echo.
echo Press any key to go back...
goto Multi_en

################################	DESFRAGMENTACION INGLES		################################

:E
cls
echo 			/=============================\
echo 			º       Welcome to the        º
echo 			º   desfragmentation wizard   º
echo 			º                             º
echo 			º             3.0 v           º
echo 			\=============================/
echo.
echo /============================================================================\
echo º ( ? ) What unit will you defrag? (Write the letter of the directory) ( ? ) º
echo º                            (Ej: C, D, E, H...)                             º
echo \============================================================================/
echo.
set /p unit= Answer: 
echo.
echo Searching the directory...
timeout /t 2 /nobreak > NUL
echo.
cd %u%: >nul
if %errorlevel% equ 1 goto false
goto true

:false
cls
echo 			/=============================\
echo 			º       Welcome to the        º
echo 			º   desfragmentation wizard   º
echo 			º                             º
echo 			º             3.0 v           º
echo 			\=============================/
echo.
echo /============================================================================\
echo º ( ? ) What unit will you defrag? (Write the letter of the directory) ( ? ) º
echo º                            (Ej: C, D, E, H...)                             º
echo \============================================================================/
echo.
set /p unit= Answer: 
echo.
echo The directory does not exist, please try again...
timeout /t 2 /nobreak > NUL
goto E

:true
echo 		/=================================================================\
echo 		º  / \                                                       / \  º
echo 		º / ! \          The directory has been detected!           / ! \ º
echo 		\=================================================================/
echo.
echo 		/=================================================================\
echo 		º Tips:                                                           º
echo 		º                                                                 º
echo 		º  - The process can last between 30-60 minutes, be patient.      º
echo 		º  - Your PC may become slow in the process, it is normal.        º
echo 		º  - If you want the process to go fast, do not use your PC!      º
echo 		º  - It s recommended to delete the files in the trash            º
echo 		º=================================================================º
echo 		º  / \          Are you sure you want to defrag?             / \  º
echo 		º / ! \       (unit% u% :) / will be defragmented!          / ! \ º
echo 		\=================================================================/
echo.
echo 		/========\
echo 		º 1. Yes º
echo 		º 2. No  º
echo 		\========/
echo.
echo.
set /p n= Write your answer:	
if %n%==1 goto Ci
if %n%==2 goto Ni
echo.
echo The directory does not exist, please try again...
timeout /t 2 /nobreak > NUL
goto true

:Ci
cls
echo /====================================================\
echo º  / \                                          / \  º
echo º / ! \     Starting desfragment %nota1%:      / ! \ º
echo \====================================================/
timeout /t 2 /nobreak > NUL
cls
defrag %nota1%: /u
cls
echo  / \                        / \
echo / ! \       / ! \
echo.
echo ( ? ) Do you want to start the cleaning assistant ( ? )
echo.
echo º 1. Yes º
echo º 2. No  º
echo.
set /p y= Write you answer: 
echo.
if %y%==1 goto Cil
if %y%==2 goto Nil
exit
:Nil
cls
echo.
echo.
echo                      *****         ****         *****
echo                     **********************************
echo                    **            Hard Disk           **
echo                     ***        Desfragmenter       ***
echo                       ****        Wizard         ****
echo ====================**********************************=============================
echo                       ******    Created by    ******
echo                      ****        Yipi-kun         ****
echo                     **********************************
echo                      *****         ****         *****
echo.
echo  / \                                          / \
echo / ! \ Finished program, closing in 5 seconds / ! \
echo.
echo.
echo.
echo.
timeout /t 5 /nobreak>nul
exit

:Ni
cls
color 4
echo  / \                        / \
echo / ! \ Desfragment canceled / ! \
echo.
echo ( ? ) Do you want to start the cleaning assistant ( ? )
echo.
echo º 1. Yes º
echo º 2. No  º
echo.
set /p y= Write you answer: 
if %y%==1 goto Cil
if %y%==2 goto Nil
exit
:Cil
title Cleaning assistant
cls
color 6
echo  / \                           / \
echo / ! \ Starting service...  º  / ! \
timeout /t 1 /nobreak > NUL
cls
echo  / \                           / \
echo / ! \ Starting service...  /  / ! \
timeout /t 1 /nobreak > NUL
cls
echo  / \                           / \
echo / ! \ Starting service...  -  / ! \
timeout /t 1 /nobreak > NUL
cls
echo  / \                           / \
echo / ! \ Starting service...  \  / ! \
timeout /t 1 /nobreak > NUL
cls
echo  / \                           / \
echo / ! \ Starting service... º   / ! \
timeout /t 1 /nobreak > NUL
cls
color 4
echo                      *****         ****         *****
echo                     **********************************
echo                       **    Welcome to Cleaning   **
echo ====================*******     Assistant       *******=============================
echo                     **********************************
echo                      *****         ****         *****
echo.
echo.
echo.
echo  / \                           / \
echo / ! \ I NEED YOU CONFIRMATION / ! \
echo.
echo.
echo.
echo ( ? ) Do you want start the service ( ? )
echo.
echo º 1. Yes º
echo º 2. No  º
echo.
set /p n= Write you answer:	
if %n%==1 goto Ali
if %n%==2 goto Nli
exit
:Ali
cls
echo  / \                            / \
echo / ! \ Starting service...  º   / ! \
timeout /t 1 /nobreak > NUL
cls
echo  / \                            / \
echo / ! \ Starting service...  /   / ! \
timeout /t 1 /nobreak > NUL
cls
echo  / \                            / \
echo / ! \ Starting service...  -   / ! \
timeout /t 1 /nobreak > NUL
cls
echo  / \                            / \
echo / ! \ Starting service...  \   / ! \
timeout /t 1 /nobreak > NUL
cls
echo  / \                            / \
echo / ! \ Starting service...  º   / ! \
timeout /t 1 /nobreak > NUL
cls
echo  / \                              / \
echo / ! \ Deleting junk files... /   / ! \
timeout /t 1 /nobreak > NUL
del /q /s %temp%>nul
cls
echo  / \                               / \
echo / ! \ Deleting junk files...  -   / ! \
timeout /t 1 /nobreak > NUL
del /q /s C:\Windows\Temp>nul
cls
echo  / \                                        / \
echo / ! \ Optimizing started of Windows... \   / ! \
echo.
timeout /t 2 /nobreak>nul
del /q /s C:\Windows\Prefetch>nul
cls
color 2
echo  / \                      / \
echo / ! \ Cleaning complete! / ! \
echo.
echo                      *****         ****         *****
echo                     **********************************
echo                      ****         Cleaning       ****
echo                       **          Assistant       **
echo ====================**********************************=============================
echo                       ******   Created by     ******
echo                    ****       MisterJpeeexD        ****
echo                     **********************************
echo                      *****         ****         *****
echo.
echo  / \                                          / \
echo / ! \ Finished program, Closing in 5 seconds / ! \
echo.
echo.
echo.
echo.
timeout /t 5 /nobreak>nul
exit

:Nli
cls
echo  / \                     / \
echo / ! \ Cleaning canceled / ! \
echo.
echo                      *****         ****         *****
echo                     **********************************
echo                      ****         Cleaning       ****
echo                       **          Assistant       **
echo ====================**********************************=============================
echo                       ******   Created by     ******
echo                    ****       MisterJpeeexD        ****
echo                     **********************************
echo                      *****         ****         *****
echo.
echo  / \                                          / \
echo / ! \ Finished program, closing in 5 seconds / ! \
echo.
echo.
echo.
echo.
timeout /t 5 /nobreak>nul
exit

:SvcE
echo Kill-Services
cls
sc stop DsSvc
sc stop DusmSvc
sc stop NlaSvc
sc stop RasMan
sc stop RmSvc
sc stop SessionEnv
sc stop TabletInputService
sc stop TapiSrv
sc stop TeamViewer
sc stop TermService
sc stop SEVPNCLIENT
echo.
echo Revise los detalles de servicios detenidos
pause
exit

:SvcS
echo Detener servicios
cls
sc stop DsSvc
sc stop DusmSvc
sc stop NlaSvc
sc stop RasMan
sc stop RmSvc
sc stop SessionEnv
sc stop TabletInputService
sc stop TapiSrv
sc stop TeamViewer
sc stop TermService
sc stop SEVPNCLIENT
echo.
echo Los servicios anteriores han sido desactivados
echo.
pause
goto adios
exit