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
Write-Log -Message "`nExecution Beginning now..."
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
#Read from ssm-parameter store
#This way a secure variable can be passed into a user data script such that its value does not persist in the file
$ASecureVariable = (get-ssmparameter -Name "/dev/SecureVariableOne" -WithDecryption $true).value
#The below step is only to demonstrate that the above step actually worked. Secure values should not be printed.
Write-Log -Message "The value of the secure variable that was read from ssm-parameter store is: $ASecureVariable"
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
</powershell>
<persist>true</persist>