@echo off
setlocal enabledelayedexpansion

REM Clone the app repository and install dependencies
echo Checking app repository...
if not exist "steadfast-stoic-app\.git" (
    echo Cloning app...
    git clone https://github.com/narenkram/steadfast-stoic-app.git
) else (
    echo App repository already exists, skipping clone...
)
cd steadfast-stoic-app
echo Installing app dependencies...
call npm install
if !errorlevel! neq 0 (
    echo Error occurred while installing app dependencies.
    goto :error
)
cd ..

REM Clone the API repository and install dependencies
echo Checking API repository...
if not exist "steadfast-stoic-api\.git" (
    echo Cloning API...
    git clone https://github.com/narenkram/steadfast-stoic-api.git
) else (
    echo API repository already exists, skipping clone...
)
cd steadfast-stoic-api
echo Installing API dependencies...
call npm install
if !errorlevel! neq 0 (
    echo Error occurred while installing API dependencies.
    goto :error
)
cd ..

REM Clone the WebSocket repository and install dependencies
echo Checking WebSocket repository...
if not exist "steadfast-websocket\.git" (
    echo Cloning WebSocket...
    git clone https://github.com/narenkram/steadfast-websocket.git
) else (
    echo WebSocket repository already exists, skipping clone...
)
cd steadfast-websocket

echo Installing WebSocket dependencies...
cd flattrade
call pip install -r requirements.txt
if !errorlevel! neq 0 (
    echo Error occurred while installing WebSocket dependencies for Flattrade.
    goto :error
)
cd ..

echo Installing Shoonya dependencies...
cd shoonya
call pip install -r requirements.txt
if !errorlevel! neq 0 (
    echo Error occurred while installing WebSocket dependencies for Shoonya.
    goto :error
)
cd ..\..

echo Repositories cloned and dependencies installed successfully.
goto :end

:error
echo An error occurred. Please check the output above for details.

:end
pause
endlocal