@echo off

REM Defina os URLs corretos para os instaladores do Git, Docker e GitHub Desktop
set GIT_URL=https://github.com/git-for-windows/git/releases/download/v2.33.0.windows.1/Git-2.33.0-64-bit.exe
set DOCKER_URL=https://drive.usercontent.google.com/download?id=1Qy9Kj8ldQhvXXmPJQ6l2o9xD5B_6O5N1
set GITHUB_DESKTOP_URL=https://central.github.com/deployments/desktop/desktop/latest/win32

REM Defina o diretório onde você deseja baixar os instaladores
set DOWNLOAD_DIR=C:\Downloads

REM Verificar e baixar o Git
if not exist "%ProgramFiles%\Git\bin\git.exe" (
    echo Baixando e instalando o Git...
    bitsadmin /transfer DownloadGit %GIT_URL% "%DOWNLOAD_DIR%\GitInstaller.exe"
    "%DOWNLOAD_DIR%\GitInstaller.exe" /SILENT
) else (
    echo Git já está instalado.
)

REM Verificar e baixar o Docker
if not exist "%ProgramFiles%\Docker\Docker\Docker Desktop Installer.exe" (
    echo Baixando e instalando o Docker...
    bitsadmin /transfer DownloadDocker %DOCKER_URL% "%DOWNLOAD_DIR%\DockerInstaller.exe"
    "%DOWNLOAD_DIR%\DockerInstaller.exe" /SILENT
) else (
    echo Docker já está instalado.
)

REM Verificar e baixar o GitHub Desktop
if not exist "%AppData%\GitHub Desktop" (
    REM Baixar e instalar o GitHub Desktop
    echo Baixando e instalando o GitHub Desktop...
    bitsadmin /transfer DownloadGitHubDesktop %GITHUB_DESKTOP_URL% "%DOWNLOAD_DIR%\GitHubDesktopSetup.exe"
    "%DOWNLOAD_DIR%\GitHubDesktopSetup.exe"
) else (
    echo GitHub Desktop já está instalado.
)


REM Aguardar um tempo para as instalações serem concluídas
timeout /t 10 /nobreak

REM Construir e executar o contêiner Docker
docker build -t versao_um .
docker run -p 5000:5000 versao_um

REM Após as instalações, você pode prosseguir com o restante do seu script
