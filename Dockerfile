# Use MSFT's .Net framework on the latest LTSC release for the optimal usage.
FROM microsoft/dotnet-framework:3.5-runtime-windowsservercore-ltsc2019

# Metadata
LABEL maintainer="ehuffman@elliot-labs.com"
LABEL Version="0.0.1"
LABEL Description="A docker file to automate the containerization of A La Mode's Total Server software. \
This effectively make it PaaS software."

# Make the working directory.
RUN ["Powershell", "mkdir", "C:\\Total"]

# Switch to the working directory.
WORKDIR C:\\Total

# Download the Total Software and its dependencies to the container.
RUN ["Invoke-WebRequest", "-Uri \"https://download.microsoft.com/download/f/0/3/f03c202d-1ce4-4267-9393-a8a4b400a982/Vs6sp6B.exe\"", "-OutFile \"VB6Zip.exe\""]
RUN ["Invoke-WebRequest", "-Uri \"http://download.alamode.com/Installs/TOTAL/TOTALSetup.exe\"", "-OutFile \"TotalSetup.exe\""]

EXPOSE 445/tcp
EXPOSE 137/tcp
EXPOSE 138/tcp
EXPOSE 139/tcp