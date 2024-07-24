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
} | Export-Csv -Path "$LogFolderPath\UserDataLogFile.log" -Append -NoTypeInformation
}

##############################################

# Execution begins from here

##############################################
$LogFolderPath = "C:\UserDataLog"
$InstallerFolderPath = $LogFolderPath+"\Installer"
$UserName = "User03"
$UserNameWithComputer = "$env:COMPUTERNAME"+"\"+"User03"

#Create log file location
if (-not(Test-Path $LogFolderPath))
{
New-Item -ItemType directory -Path $LogFolderPath
Write-Log -Message "Created folder to store log file."
} else {
Write-Log -Message "Folder already exists."
}
#Userdata location
Write-Log -Message "Userdata script is stored at : $PSScriptRoot"

#Create a new user if does not exist.
$CheckIfUserExists = (Get-LocalUser).Name -Contains $UserName
if ($CheckIfUserExists -eq $false) {
Write-Host "$UserName does not exist and will be created."
try {
Write-Log -Message "Adding the user: $UserName"
$Secure_String_Password = ConvertTo-SecureString "${Password}" -AsPlainText -Force

    $params = @{
        Name        = $UserName
        Password    = $Secure_String_Password
        FullName    = 'Third User'
        Description = 'Description of this account.'
    }
    New-LocalUser @params
}
catch {
        Write-Log -Message "An error occurred:"
        Write-Log -Message $_
        Write-Log -Message "Could not create a local user."
        break
    }
} ElseIf ($CheckIfUserExists -eq $true) {
    Write-Log -Message "$UserName Exists."
}

#Add user to Administrators group
Write-Log -Message "Checking if $UserName belongs to the Administrators group already."
$CheckIfUserBelongsToAdministrator = (Get-LocalGroupMember -Group "Administrators").Name -Contains $UserName
if ($CheckIfUserBelongsToAdministrator -eq $false) {
Write-Log -Message "$UserName does not belong to Administrators group and will be added."
try {
Add-LocalGroupMember -Group "Administrators" -Member "$UserName"
}
catch {
$"An error occurred:"
Write-Log -Message $_
Write-Log -Message "Could not add user to Administrators group."
break
}
} ElseIf ($CheckIfUserBelongsToAdministrator -eq $true) {
Write-Log -Message "$UserName is in Administrators group already."
}
Write-Log -Message "$UserName added to Administrators."

</powershell>
<persist>true</persist>