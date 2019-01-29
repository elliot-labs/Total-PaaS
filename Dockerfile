# Use MSFT's .Net framework on the latest LTSC release for the optimal usage.
FROM microsoft/dotnet-framework:3.5-runtime-windowsservercore-ltsc2019

# Global Settings
ENV CustomerNumber 1234567890
ENV eMail example@contoso.com
ENV Password Passw0rd!

# Metadata
LABEL maintainer="ehuffman@elliot-labs.com"
LABEL Version="0.0.2"
LABEL Description="A Dockerfile to automate the containerization of A La Mode's Total Server software. \
    This effectively make it PaaS software."

# Make the working directory.
RUN Powershell.exe -Command \
    New-Item -Path 'C:\\' -Name 'Total' -ItemType Directory

# Switch to the working directory.
WORKDIR C:\\Total

# Download and install the VB6 Runtime prerequisite, then clean up.
RUN Powershell.exe -Command \
    $ProgressPreference = 'SilentlyContinue'; \
    $ErrorActionPreference = 'Stop'; \
    Invoke-WebRequest -Uri 'https://download.microsoft.com/download/5/a/d/5ad868a0-8ecd-4bb0-a882-fe53eb7ef348/VB6.0-KB290887-X86.exe' -OutFile 'VB6Zip.exe'; \
    .\VB6zip.exe /Q /T:C:\Total\VB6\ /C \
    .\VB6\vbrun60sp6.exe /Q /T:C:\Total\VB6\ /C; \
    InfDefaultInstall.exe .\VB6\vbrun60.inf; \
    Remove-Item -Path .\VB6\ -Recurse -Force; \
    Remove-Item -Path .\VB6Zip.exe -Force;

# Install the Total Server Software and then clean up.
RUN Powershell.exe -Command \
    $ProgressPreference = 'SilentlyContinue'; \
    $ErrorActionPreference = 'Stop'; \
    Invoke-WebRequest -Uri 'http://download.alamode.com/Installs/TOTAL/TOTALSetup.exe' -OutFile 'TotalSetup.exe'

# Expose the ports used to the network environment.
EXPOSE 445/tcp
EXPOSE 137/tcp
EXPOSE 138/tcp
EXPOSE 139/tcp