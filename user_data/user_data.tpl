<powershell>
#Function to store log data
function Write-Log {
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$Message
    )
    [pscustomobject]@{
        Time = (Get-Date -f g)
        Message = $Message
    } | Export-Csv -Path "c:\UserDataLog\UserDataLogFile.log" -Append -NoTypeInformation
 }
#Read input variables
$ServerName = "${ServerName}"
#----------------------------------
#Create log file location
if (-not(Test-Path "C:\UserDataLog"))
{
    New-Item -ItemType directory -Path "C:\UserDataLog"
    Write-Log -Message "Created folder to store log file."
} else {
    Write-Log -Message "Folder already exists."
}
#----------------------------------
#Userdata location
Write-Log -Message "-------------------------"
Write-Log -Message "Userdata script is stored at : $PSScriptRoot"
Write-Log -Message "Execution Beginning now..."
#----------------------------------
#Check Computer ServerName
if ($env:COMPUTERNAME -eq $ServerName)
{
    Write-Log -Message "The name of the machine is correct: $env:COMPUTERNAME"
} else {
    Write-Log -Message "The name of the machine is incorrect and needs to change from $env:COMPUTERNAME to $ServerName."
    Rename-Computer -NewName $ServerName -Restart -Force
    Write-Log -Message "The machine will be renamed and restarted."
}
#----------------------------------
#----------------------------------
#Check Windows feature 
if ((Get-WindowsFeature Web-Server).installed -ne 'True')
{
    Write-Log -Message "Windows feature is not installed and will be installed."
    Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature
} else
{
    Write-Log -Message "Windows feature is already installed."
}
#----------------------------------
$ListofModulesInstalled = (Get-InstalledModule).Name
Write-Log -Message "Ckecking if AWS.Tools.Installer is installed on this instance."
if ($ListofModulesInstalled -contains "AWS.Tools.Installer")
{ 
    Write-Log -Message "AWS.Tools.Installer module exists."
}else { 
    Write-Log -Message "AWS.Tools.Installer module does not exist and needs to be installed."
    $ListofPackagesInstalled = (Get-PackageProvider -ListAvailable).Name
    Write-Log -Message "AWS.Tools.Installer requires nuget package version 2.8.5.201 or above to be installed. Checking if correct version of nuget package is installed."
    if ($ListofPackagesInstalled -contains "Nuget")
    {
        Write-Log -Message "Nuget package exists. Ckecking version."
        $CheckNugetVersion=(get-PackageProvider -Name NuGet).Version
        if($CheckNugetVersion -ge "2.8.5.201")
        {
            Write-Log -Message "Nuget version is $CheckNugetVersion and that is acceptable."
        }else {
            Write-Log -Message "Nuget version is $CheckNugetVersion and a newer package will be installed."
            Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
        }
    } else {
        Write-Log -Message "Nugest package does not exists and will be installed."
        Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
    }
    Install-Module -Name AWS.Tools.Installer -Force
    Write-Log -Message "AWS.Tools.Installer was installed successfully."
}
</powershell>
<persist>true</persist>